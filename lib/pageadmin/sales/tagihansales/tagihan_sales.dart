import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:yofa/core/constants/variables.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';
import 'package:yofa/pageadmin/sales/order/bloc/sale_detail_bloc.dart';
import 'package:yofa/pageadmin/sales/order/datasource/save_sale_ds.dart';
import 'package:yofa/pageadmin/sales/order/edit_order.dart';
import 'package:yofa/pageadmin/sales/tagihansales/detail_faktur_page.dart';
import 'package:yofa/pageadmin/sales/tagihansales/pdfview_page.dart';
import '../../../theme/app_theme.dart';

import 'package:yofa/pageadmin/sales/tagihansales/bloc/sales_bloc.dart';
import 'package:yofa/pageadmin/sales/tagihansales/model/sales_models.dart';

class TagihanSales extends StatefulWidget {
  const TagihanSales({super.key});

  @override
  State<TagihanSales> createState() => _TagihanSalesState();
}

class _TagihanSalesState extends State<TagihanSales> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    //  load awal
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SalesBloc>().add(const SalesEvent.getSales(page: 1));
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  // ===== UI Helpers (TETAP) =====
  Widget _card({required Widget child}) {
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
      child: child,
    );
  }

  Widget _searchBox() {
    return Container(
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
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, color: Color(0xFF6F646B)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _searchCtrl,
              onChanged: (v) {
                // panggil API search (bukan filter local) supaya sesuai backend
                context.read<SalesBloc>().add(SalesEvent.applyFilter(search: v));
                setState(() {});
              },
              decoration: const InputDecoration(
                hintText: 'Cari invoice / customer...',
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          if (_searchCtrl.text.isNotEmpty)
            IconButton(
              onPressed: () {
                _searchCtrl.clear();
                context.read<SalesBloc>().add(const SalesEvent.clearFilter());
                setState(() {});
              },
              icon: const Icon(Icons.close_rounded, color: Color(0xFF6F646B)),
            ),
        ],
      ),
    );
  }

  Widget _statusBadgeFromSale(Sale s) {
    final paid = (s.status.toLowerCase() == 'paid' || s.status.toLowerCase() == 'lunas');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: paid ? const Color(0xFFE9FBF2) : const Color(0xFFFFF3E7),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: paid ? const Color(0xFFBFEED3) : const Color(0xFFFFD4B3),
        ),
      ),
      child: Text(
        paid ? 'Lunas' : 'Pending',
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 12,
          color: paid ? const Color(0xFF1F8B4C) : const Color(0xFFB15A00),
        ),
      ),
    );
  }

  String _rp(int v) {
    final s = v.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final revIndex = s.length - i;
      buf.write(s[i]);
      if (revIndex > 1 && revIndex % 3 == 1) buf.write('.');
    }
    return 'Rp $buf';
  }

  String _fmtDateUI(String? isoOrDate) {
    if (isoOrDate == null || isoOrDate.isEmpty) return '-';
    // backend: "2026-03-28" (date only)
    final parts = isoOrDate.split(' ').first.split('-');
    if (parts.length != 3) return isoOrDate;
    final y = parts[0];
    final m = parts[1];
    final d = parts[2];
    const months = {
      '01': 'Jan', '02': 'Feb', '03': 'Mar', '04': 'Apr', '05': 'Mei', '06': 'Jun',
      '07': 'Jul', '08': 'Agu', '09': 'Sep', '10': 'Okt', '11': 'Nov', '12': 'Des',
    };
    return '${int.tryParse(d) ?? d} ${months[m] ?? m} $y';
  }

  Future<void> _handleMenu(_InvoiceAction act, Sale s) async {
    final label = switch (act) {
      _InvoiceAction.detail => 'Detail Faktur',
      _InvoiceAction.edit => 'Edit',
      _InvoiceAction.delete => 'Hapus',
      _InvoiceAction.print => 'Print',
      _InvoiceAction.send => 'Kirim',
    };

    if (act == _InvoiceAction.detail) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DetailFakturPage(
            saleId: s.id, //  kunci ambil data dari bloc
          ),
        ),
      );
      return;
    }

    if (act == _InvoiceAction.edit) {
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SaleDetailBloc(ds: SaveSaleDataSource())
              ..add(SaleDetailEvent.get(id: s.id)),
            child: EditOrderPage(sale: s),
          ),
        ),
      );
      return;
    }

    if (act == _InvoiceAction.delete) {
      // endpoint delete belum kamu minta, jadi tetap TODO tapi UI dialog tetap sama
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Hapus Tagihan?'),
          content: Text('Yakin hapus ${s.invoiceNumber}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('TODO Delete: ${s.invoiceNumber}')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE63B5C),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Hapus'),
            ),
          ],
        ),
      );
      return;
    }

    if (act == _InvoiceAction.print) {
      final id = s.id; // pastikan ada id
      final baseUrl = Variables.baseUrl;
 
      /// jika PPN → langsung print versi 1
      if (s.taxStatus.toLowerCase() == 'ppn') {
        final url = '$baseUrl/sales/print/$id';

        await openPdfFromUrl(context, url);
        return;
      }

      /// jika NON PPN → pilih versi
      final version = await showDialog<int>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Pilih Versi Print'),
            content: const Text('Silakan pilih versi invoice'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, 1),
                child: const Text('Versi 1'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 2),
                child: const Text('Versi 2'),
              ),
            ],
          );
        },
      );

      if (version == null) return;

      final url = version == 1
          ? '$baseUrl/sales/print/$id'
          : '$baseUrl/sales/printversion2/$id';

      await openPdfFromUrl(context, url);
    }
  }

  Future<void> openPdfFromUrl(BuildContext context, String url) async {
      final authData = await AuthLocalDatasource().getAuthData();
      final token = authData?.token;
    try {
      final response = await http.get(Uri.parse(url),
      headers: {
        "Accept": "application/pdf",
        "Authorization":"Bearer $token",
      });

      if (response.statusCode == 200) {
        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/temp.pdf');

        await file.writeAsBytes(response.bodyBytes);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PDFViewPage(path: file.path),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal membuka PDF')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }



  Widget _filterBar({
  required int? year,
  required String? taxStatus,
  required String? paymentStatus,
}) {
  final now = DateTime.now();
  final years = List.generate(3, (i) => now.year - i); // 7 tahun terakhir

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
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
        Expanded(
          child: DropdownButtonFormField<int?>(
            value: year,
            isDense: true,
            decoration: const InputDecoration(
              labelText: 'Tahun',
              border: InputBorder.none,
              isDense: true,
            ),
            items: [
              const DropdownMenuItem<int?>(value: null, child: Text('Semua')),
              ...years.map((y) => DropdownMenuItem<int?>(
                    value: y,
                    child: Text('$y'),
                  )),
            ],
            onChanged: (val) {
              context.read<SalesBloc>().add(SalesEvent.applyFilter(year: val));
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: DropdownButtonFormField<String?>(
            value: taxStatus,
            isDense: true,
            decoration: const InputDecoration(
              labelText: 'Tax',
              border: InputBorder.none,
              isDense: true,
            ),
            items: const [
              DropdownMenuItem<String?>(value: null, child: Text('Semua')),
              DropdownMenuItem<String?>(value: 'ppn', child: Text('PPN')),
              DropdownMenuItem<String?>(value: 'non-ppn', child: Text('Non-PPN')),
            ],
            onChanged: (val) {
              context.read<SalesBloc>().add(SalesEvent.applyFilter(taxStatus: val));
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: DropdownButtonFormField<String?>(
            value: paymentStatus,
            isDense: true,
            decoration: const InputDecoration(
              labelText: 'Pembayaran',
              border: InputBorder.none,
              isDense: true,
            ),
            items: const [
              DropdownMenuItem<String?>(value: null, child: Text('Semua')),
              DropdownMenuItem<String?>(value: 'pending', child: Text('Pending')),
              DropdownMenuItem<String?>(value: 'completed', child: Text('Lunas')),
            ],
            onChanged: (val) {
              context.read<SalesBloc>().add(SalesEvent.applyFilter(paymentStatus: val));
            },
          ),
        ),
      ],
    ),
  );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: AppTheme.bg,
    appBar: AppBar(
      title: const Text('Tagihan Sales'),
      backgroundColor: AppTheme.primary,
      foregroundColor: Colors.white,
    ),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
          child: _searchBox(),
        ),

        // Integrasi BlocConsumer (UI list tetap)
        Expanded(
          child: BlocConsumer<SalesBloc, SalesState>(
            listener: (context, state) {
              state.whenOrNull(
                error: (msg) => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(msg)),
                ),
              );
            },
            builder: (context, state) {
              return state.when(
                initial: () => const Center(child: Text('Memuat...')),
                loading: () => const Center(child: CircularProgressIndicator()),
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
                            context.read<SalesBloc>().add(
                                  const SalesEvent.getSales(page: 1),
                                );
                          },
                          child: const Text('Coba lagi'),
                        ),
                      ],
                    ),
                  ),
                ),
                loaded: (items, page, lastPage, search, year, paymentStatus,
                    taxStatus, isLoadingMore) {
                  //  filter bar tetap tampil meskipun kosong
                  // (biar user bisa ganti filter meski hasil 0)
                  return Column(
                    children: [
                      _filterBar(
                        year: year,
                        taxStatus: taxStatus,
                        paymentStatus: paymentStatus,
                      ),

                      Expanded(
                        child: items.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 24),
                                child: Center(
                                  child: Text(
                                    'Data tidak ditemukan',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black.withOpacity(0.45),
                                    ),
                                  ),
                                ),
                              )
                            : NotificationListener<ScrollNotification>(
                                onNotification: (n) {
                                  //  infinite scroll
                                  if (n.metrics.pixels >=
                                      n.metrics.maxScrollExtent - 200) {
                                    context
                                        .read<SalesBloc>()
                                        .add(const SalesEvent.loadMore());
                                  }
                                  return false;
                                },
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    context
                                        .read<SalesBloc>()
                                        .add(const SalesEvent.refresh());
                                  },
                                  child: ListView.separated(
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 6, 16, 16),
                                    itemCount:
                                        items.length + (isLoadingMore ? 1 : 0),
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 10),
                                    itemBuilder: (_, i) {
                                      if (isLoadingMore && i == items.length) {
                                        return const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        );
                                      }

                                      final s = items[i];
                                      return _card(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          s.invoiceNumber,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            color: AppTheme
                                                                .textDark,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      _statusBadgeFromSale(s),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    s.customer?.name ?? '-',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Color(0xFF6F646B),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: _infoLine(
                                                          'Total',
                                                          _rp(s.total),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Expanded(
                                                        child: _infoLine(
                                                          'Jatuh Tempo',
                                                          _fmtDateUI(s.dueDate),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            PopupMenuButton<_InvoiceAction>(
                                              icon: const Icon(
                                                Icons.more_vert_rounded,
                                                color: Color(0xFF6F646B),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                              ),
                                              onSelected: (act) =>
                                                  _handleMenu(act, s),
                                              itemBuilder: (_) => const [
                                                PopupMenuItem(
                                                  value: _InvoiceAction.detail,
                                                  child: _MenuRow(
                                                    icon: Icons
                                                        .receipt_long_rounded,
                                                    text: 'Detail Pesanan',
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  value: _InvoiceAction.edit,
                                                  child: _MenuRow(
                                                    icon: Icons.edit_rounded,
                                                    text: 'Update Pesanan',
                                                  ),
                                                ),
                                                PopupMenuDivider(),
                                                PopupMenuItem(
                                                  value: _InvoiceAction.print,
                                                  child: _MenuRow(
                                                    icon: Icons.print_rounded,
                                                    text: 'Print',
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  value: _InvoiceAction.send,
                                                  child: _MenuRow(
                                                    icon: Icons.send_rounded,
                                                    text: 'Kirim',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                      ),
                    ],
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
  Widget _infoLine(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            color: Color(0xFF8B7F86),
            fontSize: 11.5,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            color: AppTheme.textDark,
            fontSize: 12.5,
          ),
        ),
      ],
    );
  }
}



// ===== Enums tetap =====
enum _InvoiceAction { detail, edit, delete, print, send }

class _MenuRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _MenuRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppTheme.primary),
        const SizedBox(width: 10),
        Text(text, style: const TextStyle(fontWeight: FontWeight.w800)),
      ],
    );
  }
}