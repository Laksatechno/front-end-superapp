import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class HargaProdukCustomerPage extends StatefulWidget {
  const HargaProdukCustomerPage({super.key});

  @override
  State<HargaProdukCustomerPage> createState() => _HargaProdukCustomerPageState();
}

class _HargaProdukCustomerPageState extends State<HargaProdukCustomerPage> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _selectedCustomer = 'PT Sehat Sentosa';

  final List<String> _customers = [
    'PT Sehat Sentosa',
    'Klinik Maju Jaya',
    'PMI Cabang Depok',
  ];

  final List<_HargaItem> _items = const [
    _HargaItem('Hemoglobin Meter', 1200000, 1100000),
    _HargaItem('Strip Hb', 250000, 240000),
    _HargaItem('Lancet', 50000, 45000),
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<_HargaItem> get _filtered {
    final q = _searchCtrl.text.trim().toLowerCase();
    if (q.isEmpty) return _items;
    return _items.where((e) => e.product.toLowerCase().contains(q)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final list = _filtered;

    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Harga Produk Customer'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Column(
              children: [
                // pilih customer
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFEFE6EC)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.person_outline, color: AppTheme.primary),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedCustomer,
                            items: _customers.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                            onChanged: (v) => setState(() => _selectedCustomer = v ?? _selectedCustomer),
                            style: const TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark),
                            isExpanded: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // search produk
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFEFE6EC)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search_rounded, color: Color(0xFF6F646B)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _searchCtrl,
                          onChanged: (_) => setState(() {}),
                          decoration: const InputDecoration(
                            hintText: 'Cari produk...',
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
                          icon: const Icon(Icons.close_rounded, color: Color(0xFF6F646B)),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (_, i) {
                final it = list[i];
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFEFE6EC)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(it.product,
                                style: const TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                            const SizedBox(height: 6),
                            Text('Harga default: Rp ${it.defaultPrice}',
                                style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF6F646B))),
                            Text('Harga customer: Rp ${it.customerPrice}',
                                style: const TextStyle(fontWeight: FontWeight.w900, color: AppTheme.primary)),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // TODO: edit harga
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('TODO: edit harga "${it.product}"')),
                          );
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4ECF2),
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFEADDE6)),
                          ),
                          child: const Icon(Icons.edit_outlined, color: AppTheme.primary),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _HargaItem {
  final String product;
  final int defaultPrice;
  final int customerPrice;

  const _HargaItem(this.product, this.defaultPrice, this.customerPrice);
}
