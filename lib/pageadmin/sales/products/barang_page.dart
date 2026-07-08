import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yofa/pageadmin/sales/products/detail_barang.dart';
import 'package:yofa/pageadmin/sales/products/tambah_barang_page.dart';
import 'package:yofa/pageadmin/sales/products/bloc/product_bloc.dart'; // ✅ sesuaikan path bloc kamu
import '../../../theme/app_theme.dart';

class BarangPage extends StatefulWidget {
  const BarangPage({super.key});

  @override
  State<BarangPage> createState() => _BarangPageState();
}

class _BarangPageState extends State<BarangPage> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    //  load awal
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductBloc>().add(const ProductEvent.getProducts(page: 1, perPage: 10));
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onAdd() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TambahBarangPage()),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tambah Barang')),
    );
  }

  void _onDownload() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Download data barang')),
    );
  }

  void _onDetail(int productId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<ProductBloc>(),
          child: DetailBarangPage(productId: productId),
        ),
      ),
    );
  }

  void _onEdit(_BarangItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit: ${item.name}')),
    );
  }

  void _onDelete(_BarangItem item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Barang'),
        content: Text('Yakin hapus "${item.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Terhapus: ${item.name}')),
              );
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = _searchCtrl.text.trim().toLowerCase();

    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Barang'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Download',
            onPressed: _onDownload,
            icon: const Icon(Icons.download_rounded),
          ),
          IconButton(
            tooltip: 'Tambah',
            onPressed: _onAdd,
            icon: const Icon(Icons.add_circle_outline_rounded),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: Column(
        children: [
          // Search bar (UI tetap)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFEFE6EC)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x06000000),
                    blurRadius: 10,
                    offset: Offset(0, 6),
                  )
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.search_rounded, color: Color(0xFF6F646B)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchCtrl,
                      onChanged: (_) {
                        // ✅ trigger search API (tanpa ubah UI)
                        context.read<ProductBloc>().add(
                              ProductEvent.changeSearch(
                                perPage: 10,
                                search: _searchCtrl.text.trim(),
                              ),
                            );
                        setState(() {}); // hanya untuk toggle tombol clear
                      },
                      decoration: const InputDecoration(
                        hintText: 'Cari nama produk...',
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                  if (_searchCtrl.text.isNotEmpty)
                    IconButton(
                      onPressed: () {
                        _searchCtrl.clear();
                        // ✅ reset list (page 1)
                        context.read<ProductBloc>().add(
                              const ProductEvent.getProducts(page: 1, perPage: 10),
                            );
                        setState(() {});
                      },
                      icon: const Icon(Icons.close_rounded, color: Color(0xFF6F646B)),
                    ),
                ],
              ),
            ),
          ),

          // List (UI tetap)
          Expanded(
            child: BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
                state.maybeWhen(
                  error: (msg) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(msg)),
                    );
                  },
                  orElse: () {},
                );
              },
              builder: (context, state) {
                // ambil data list dari state loaded
                final items = state.maybeWhen(
                  loaded: (data, page, perPage, search, selected) {
                    final mapped = data.items
                        .map((p) => _BarangItem(
                              id: p.id,
                              name: p.name,
                              stock: p.totalStock,
                            ))
                        .toList();

                    // tetap support filter lokal (biar perilaku sama seperti dummy)
                    if (q.isEmpty) return mapped;
                    return mapped.where((e) => e.name.toLowerCase().contains(q)).toList();
                  },
                  orElse: () => <_BarangItem>[],
                );

                // loading awal: tampilkan indikator di area list (tidak mengubah layout lain)
                final isLoading = state.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                );

                if (isLoading && items.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (_, i) {
                    final item = items[i];
                    return _BarangCard(
                      item: item,
                      onDetail: () => _onDetail(item.id),
                      onEdit: () => _onEdit(item),
                      onDelete: () => _onDelete(item),
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

class _BarangCard extends StatelessWidget {
  final _BarangItem item;
  final VoidCallback onDetail;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _BarangCard({
    required this.item,
    required this.onDetail,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFE6EC)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 10,
            offset: Offset(0, 6),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF4ECF2),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFEADDE6)),
                ),
                child: const Icon(Icons.inventory_2_outlined, color: AppTheme.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _pill('Stok: ${item.stock}', solid: true),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onDetail,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primary,
                    side: const BorderSide(color: Color(0xFFEADDE6)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  icon: const Icon(Icons.visibility_outlined, size: 18),
                  label: const Text('Detail', style: TextStyle(fontWeight: FontWeight.w900)),
                ),
              ),
              // const SizedBox(width: 10),
              // Expanded(
              //   child: OutlinedButton.icon(
              //     onPressed: onEdit,
              //     style: OutlinedButton.styleFrom(
              //       foregroundColor: AppTheme.primary,
              //       side: const BorderSide(color: Color(0xFFEADDE6)),
              //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              //       padding: const EdgeInsets.symmetric(vertical: 10),
              //     ),
              //     icon: const Icon(Icons.edit_outlined, size: 18),
              //     label: const Text('Edit', style: TextStyle(fontWeight: FontWeight.w900)),
              //   ),
              // ),
              // const SizedBox(width: 10),
              // Expanded(
              //   child: OutlinedButton.icon(
              //     onPressed: onDelete,
              //     style: OutlinedButton.styleFrom(
              //       foregroundColor: Colors.red,
              //       side: const BorderSide(color: Color(0xFFF2C6C6)),
              //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              //       padding: const EdgeInsets.symmetric(vertical: 10),
              //     ),
              //     icon: const Icon(Icons.delete_outline_rounded, size: 18),
              //     label: const Text('Hapus', style: TextStyle(fontWeight: FontWeight.w900)),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _pill(String text, {bool solid = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: solid ? const Color(0xFFF4ECF2) : Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFEADDE6)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w900,
          color: AppTheme.primary,
        ),
      ),
    );
  }
}

class _BarangItem {
  final int id;
  final String name;
  final int stock;

  const _BarangItem({
    required this.id,
    required this.name,
    required this.stock,
  });
}