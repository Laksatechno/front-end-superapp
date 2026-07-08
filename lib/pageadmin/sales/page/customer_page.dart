import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yofa/pageadmin/sales/area/bloc/area_bloc.dart';
import 'package:yofa/pageadmin/sales/customer/model/customer_model.dart';
import 'package:yofa/pageadmin/sales/page/edit_customer_page.dart'
    show EditCustomerPage;
import 'package:yofa/pageadmin/sales/page/harga_produk_customer_page.dart';
import 'package:yofa/pageadmin/sales/page/tambah_customer_page.dart';
import 'package:yofa/theme/app_theme.dart';

import 'package:yofa/pageadmin/sales/customer/bloc/customer_bloc.dart';

//  import model Customer kamu (sesuaikan path jika beda)
// contoh: import 'package:yofa/pageadmin/sales/customer/model/customer.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final TextEditingController _searchCtrl = TextEditingController();

  String _area = 'Semua Area';
  String _tipe = 'Semua Tipe';

  final List<String> _tipes = ['Semua Tipe', 'Reguler', 'Subdis', 'PMI'];

  @override
  void initState() {
    super.initState();
    // load dari API
    context.read<CustomerBloc>().add(
      const CustomerEvent.getCustomers(page: 1, perPage: 50),
    );
    context.read<AreaBloc>().add(const AreaEvent.started());
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  // filter tetap di UI seperti punya kamu
  List<CustomerItem> _applyFilter(List<CustomerItem> items) {
    final q = _searchCtrl.text.trim().toLowerCase();

    bool matchSearch(CustomerItem it) {
      if (q.isEmpty) return true;
      return it.name.toLowerCase().contains(q) ||
          it.phone.toLowerCase().contains(q) ||
          it.address.toLowerCase().contains(q);
    }

    bool matchArea(CustomerItem it) {
      if (_area == 'Semua Area') return true;
      return it.area == _area;
    }

    bool matchTipe(CustomerItem it) {
      if (_tipe == 'Semua Tipe') return true;
      return it.type.toLowerCase() == _tipe.toLowerCase();
    }

    return items
        .where((it) => matchSearch(it) && matchArea(it) && matchTipe(it))
        .toList();
  }

  void _onDownload() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('TODO: Unduh data customer')));
  }

  void _onAdd() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => AreaBloc(),
          child: const TambahCustomerPage(),
        ),
      ),
    );
  }

  void _onHargaPerCustomer() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const HargaProdukCustomerPage()),
    );
  }

  void _onEdit(CustomerItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => AreaBloc(),
          child: EditCustomerPage(item: item),
        ),
      ),
    );
  }

  Future<void> _onDelete(CustomerItem item) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Konfirmasi'),
        content: Text('Hapus customer "${item.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (ok != true) return;

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('TODO: Hapus customer (endpoint belum dibuat)'),
      ),
    );

    // kalau sudah ada endpoint delete nanti:
    // context.read<CustomerBloc>().add(CustomerEvent.delete(id: item.id));
  }

  Widget _filterChip({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFEFE6EC)),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.primary, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: AppTheme.textDark,
                ),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Color(0xFF6F646B),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickArea() async {
    final areas = context.read<AreaBloc>().state.maybeWhen(
      success: (areas) => areas,
      orElse: () => [],
    );

    final items = <String>[
      'Semua Area',
      ...areas.map((e) => e.name).cast<String>(),
    ];

    final res = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (ctx) =>
          _PickerSheet(title: 'Pilih Area', items: items, selected: _area),
    );

    if (res == null) return;

    setState(() {
      _area = res;
    });
  }

  Future<void> _pickTipe() async {
    final res = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (ctx) => _PickerSheet(
        title: 'Pilih Tipe Pelanggan',
        items: _tipes,
        selected: _tipe,
      ),
    );
    if (res == null) return;
    setState(() => _tipe = res);

    // kalau kamu mau filter remote (backend support filter_type), aktifkan ini:
    // context.read<CustomerBloc>().add(CustomerEvent.getCustomers(
    //   page: 1,
    //   perPage: 50,
    //   filterType: (_tipe == 'Semua Tipe') ? null : _tipe,
    // ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Customer'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Unduh',
            onPressed: _onDownload,
            icon: const Icon(Icons.download_rounded),
          ),
          IconButton(
            tooltip: 'Harga per Customer',
            onPressed: _onHargaPerCustomer,
            icon: const Icon(Icons.currency_exchange),
          ),
          IconButton(
            tooltip: 'Tambah Customer',
            onPressed: _onAdd,
            icon: const Icon(Icons.add_circle_outline_rounded),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: Column(
        children: [
          // Search + filter (tetap sama)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Column(
              children: [
                // Search
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFEFE6EC)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x06000000),
                        blurRadius: 10,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search_rounded,
                        color: Color(0xFF6F646B),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _searchCtrl,
                          onChanged: (_) => setState(() {}),
                          decoration: const InputDecoration(
                            hintText: 'Cari nama/no hp/alamat...',
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                      if (_searchCtrl.text.isNotEmpty)
                        IconButton(
                          onPressed: () {
                            _searchCtrl.clear();
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.close_rounded,
                            color: Color(0xFF6F646B),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: _filterChip(
                        icon: Icons.map_outlined,
                        label: 'Area',
                        value: _area,
                        onTap: _pickArea,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _filterChip(
                        icon: Icons.badge_outlined,
                        label: 'Tipe',
                        value: _tipe,
                        onTap: _pickTipe,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          //  LIST: ambil dari Bloc, tapi UI list/card tetap sama
          Expanded(
            child: BlocConsumer<CustomerBloc, CustomerState>(
              listener: (context, state) {
                state.maybeWhen(
                  error: (msg) => ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(msg))),
                  orElse: () {},
                );
              },
              builder: (context, state) {
                return state.when(
                  initial: () => const Center(child: Text('Memuat...')),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (message) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(message, textAlign: TextAlign.center),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              context.read<CustomerBloc>().add(
                                const CustomerEvent.getCustomers(
                                  page: 1,
                                  perPage: 50,
                                ),
                              );
                            },
                            child: const Text('Coba lagi'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  success: (message) => Center(child: Text(message)),
                  loaded: (data, page, perPage, filterType, status) {
                    // data dari API: List<Customer> -> convert ke CustomerItem agar card lama tetap dipakai
                    final items = data.map(CustomerItem.fromCustomer).toList();
                    final list = _applyFilter(items);

                    if (list.isEmpty) {
                      return const Center(child: Text('Data customer kosong'));
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<CustomerBloc>().add(
                          const CustomerEvent.refresh(),
                        );
                      },
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: list.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (_, i) {
                          final it = list[i];
                          return _CustomerCard(
                            item: it,
                            onEdit: () => _onEdit(it),
                            onDelete: () => _onDelete(it),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ===== Card (tetap sama) =====
class _CustomerCard extends StatelessWidget {
  final CustomerItem item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _CustomerCard({
    required this.item,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFE6EC)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: AppTheme.textDark,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _pill(item.type),
                    const SizedBox(width: 6),
                    _pill(item.area, solid: true),
                  ],
                ),
                const SizedBox(height: 8),
                _miniRow(Icons.phone_iphone_rounded, item.phone),
                const SizedBox(height: 4),
                _miniRow(Icons.location_on_outlined, item.address),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              _roundIcon(icon: Icons.edit_outlined, onTap: onEdit),
              // const SizedBox(height: 8),
              // _roundIcon(
              //   icon: Icons.delete_outline_rounded,
              //   color: Colors.red,
              //   onTap: onDelete,
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _miniRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF6F646B)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: Color(0xFF6F646B),
              height: 1.15,
            ),
          ),
        ),
      ],
    );
  }

  Widget _pill(String text, {bool solid = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: solid ? AppTheme.primary : const Color(0xFFF4ECF2),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFEADDE6)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          color: solid ? Colors.white : AppTheme.primary,
          fontSize: 11.5,
        ),
      ),
    );
  }

  Widget _roundIcon({
    required IconData icon,
    required VoidCallback onTap,
    Color color = AppTheme.primary,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: const Color(0xFFF4ECF2),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFEADDE6)),
        ),
        child: Icon(icon, color: color),
      ),
    );
  }
}

// ===== Bottomsheet Picker (tetap sama) =====
class _PickerSheet extends StatelessWidget {
  final String title;
  final List<String> items;
  final String selected;

  const _PickerSheet({
    required this.title,
    required this.items,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Tutup',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: items.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (_, i) {
                  final it = items[i];
                  final active = it == selected;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      active ? Icons.check_circle : Icons.circle_outlined,
                      color: active
                          ? AppTheme.primary
                          : const Color(0xFF6F646B),
                    ),
                    title: Text(
                      it,
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                    onTap: () => Navigator.pop(context, it),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== mapping areaId -> nama area (sesuaikan dengan master area kamu) =====
const Map<int, String> kAreaMap = {
  1: 'Jakarta',
  2: 'Bogor',
  3: 'Depok',
  4: 'Tangerang',
  5: 'Bekasi',
  6: 'Sleman',
};

String areaNameFromId(int? id) {
  if (id == null) return 'Unknown';
  return kAreaMap[id] ?? 'Area $id';
}

// ===== Model UI (tetap seperti kamu, tapi dari API) =====
class CustomerItem {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String address;
  final String type;
  final String area;

  const CustomerItem({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.type,
    required this.area,
  });

  //  dari model API kamu
  factory CustomerItem.fromCustomer(Customer c) {
    return CustomerItem(
      id: c.id,
      name: c.name,
      phone: c.phone,
      email: c.email,
      address: c.address,
      type: c.tipePelanggan,
      area: c.area?.name ?? '-',
    );
  }
}
