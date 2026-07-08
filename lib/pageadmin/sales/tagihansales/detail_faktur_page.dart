import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../theme/app_theme.dart';

import 'package:yofa/pageadmin/sales/tagihansales/bloc/sales_bloc.dart';
import 'package:yofa/pageadmin/sales/tagihansales/model/sales_models.dart';

class DetailFakturPage extends StatelessWidget {
  final int saleId;

  const DetailFakturPage({
    super.key,
    required this.saleId,
  });

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
    final parts = isoOrDate.split(' ').first.split('-');
    if (parts.length != 3) return isoOrDate;
    final y = parts[0];
    final m = parts[1];
    final d = parts[2];
    const months = {
      '01': 'Jan',
      '02': 'Feb',
      '03': 'Mar',
      '04': 'Apr',
      '05': 'Mei',
      '06': 'Jun',
      '07': 'Jul',
      '08': 'Agu',
      '09': 'Sep',
      '10': 'Okt',
      '11': 'Nov',
      '12': 'Des',
    };
    return '${int.tryParse(d) ?? d} ${months[m] ?? m} $y';
  }

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
          )
        ],
      ),
      child: child,
    );
  }

  Widget _statusBadgeFromSale(Sale sale) {
    final paid = (sale.status.toLowerCase() == 'paid' || sale.status.toLowerCase() == 'lunas');
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

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                color: Color(0xFF8B7F86),
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                color: AppTheme.textDark,
                fontSize: 12.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _lineRow(_FakturLine it) {
    final total = it.qty * it.price;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F6F8),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEADDE6)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  it.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textDark,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${it.qty}x  ${_rp(it.price)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF6F646B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            _rp(total),
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: AppTheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  int _asInt(dynamic v) {
    if (v is int) return v;
    return int.tryParse(v?.toString() ?? '') ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Detail Faktur'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<SalesBloc, SalesState>(
        builder: (context, state) {
          final sale = state.maybeWhen(
            loaded: (items, page, lastPage, search, year, paymentStatus, taxStatus, isLoadingMore) {
              try {
                return items.firstWhere((e) => e.id == saleId);
              } catch (_) {
                return null;
              }
            },
            orElse: () => null,
          );

          // kalau belum ada di state (mis: user buka detail sebelum list loaded)
          if (sale == null) {
            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              children: [
                _card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Data faktur belum tersedia',
                        style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Kembali lalu buka lagi, atau refresh list Tagihan Sales.',
                        style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF6F646B)),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          final invoiceNo = sale.invoiceNumber;
          final customer = sale.customer?.name ?? '-';
          final marketing = sale.user?.name ?? '-';
          final dueDate = _fmtDateUI(sale.dueDate);

          final lines = sale.details.map((d) {
            final name = (d.product?.name?.trim().isNotEmpty ?? false)
                ? d.product!.name
                : 'Produk #${d.productId}';
            return _FakturLine(
              name: name,
              qty: d.quantity,
              price: d.price,
            );
          }).toList();

          final subtotal = lines.fold<int>(0, (a, b) => a + (b.qty * b.price));
          final discount = _asInt(sale.diskon); // diskon header
          final tax = sale.tax;
          final shipping = _asInt(sale.shippingFee);
          final total = sale.total + shipping + tax + _asInt(sale.diskon); 

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            children: [
              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            invoiceNo,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: AppTheme.textDark,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        _statusBadgeFromSale(sale),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _infoRow('Nama Customer', customer),
                    _infoRow('Marketing', marketing),
                    _infoRow('Jatuh Tempo', dueDate),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Rincian Produk',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (lines.isEmpty)
                      const Text(
                        'Tidak ada detail produk.',
                        style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF6F646B)),
                      )
                    else
                      ListView.separated(
                        itemCount: lines.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (_, i) => _lineRow(lines[i]),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ringkasan',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                   
                    _infoRow('Diskon', '- ${_rp(discount)}'),
                    _infoRow('Tax', tax == 0 ? 'Rp 0' : _rp(tax)),
                    _infoRow('Biaya Pengiriman', _rp(shipping)),
                     _infoRow('Subtotal', _rp(subtotal)),                    const Divider(height: 18, thickness: 1),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Total',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: AppTheme.textDark,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Text(
                          _rp(total),
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            color: AppTheme.primary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FakturLine {
  final String name;
  final int qty;
  final int price;

  const _FakturLine({
    required this.name,
    required this.qty,
    required this.price,
  });
}