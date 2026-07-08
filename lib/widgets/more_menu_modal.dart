import 'package:flutter/material.dart';
import 'package:yofa/page/brosur/brosur_page.dart';
import 'package:yofa/page/pengiriman/pengiriman_page.dart';
import 'package:yofa/pageadmin/sales/tagihansales/tagihan_sales.dart';
import '../theme/app_theme.dart';

class MoreMenuFullScreen extends StatelessWidget {
  const MoreMenuFullScreen({super.key});

  static Future<void> show(BuildContext context) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black.withOpacity(0.12),
        pageBuilder: (_, __, ___) => const MoreMenuFullScreen(),
        transitionsBuilder: (_, animation, __, child) {
          final tween = Tween(begin: const Offset(0, 1), end: Offset.zero)
              .chain(CurveTween(curve: Curves.easeOutCubic));
          return SlideTransition(position: animation.drive(tween), child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = <_MoreItem>[
      _MoreItem('Pegajuan Laporan Bulanan', Icons.assignment_outlined),
      _MoreItem('Tagihan Sales', Icons.receipt_long_outlined),
      _MoreItem('Penawaran', Icons.show_chart_rounded),
      _MoreItem('Pengiriman', Icons.local_shipping_outlined),
      _MoreItem('Brosur', Icons.article_outlined),
      _MoreItem('Faktur Lunas', Icons.receipt_outlined),
      _MoreItem('Faktur Pending', Icons.pending_actions_outlined),
      _MoreItem('Laporan Sales', Icons.bar_chart_outlined),
      _MoreItem('Reimbursement', Icons.payments_outlined),
      _MoreItem('Inventaris', Icons.inventory_2_outlined),
    ];

    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // Header (mirip gambar)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 12, 10),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Menu Lainya',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: AppTheme.textDark,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      foregroundColor: AppTheme.primary,
                    ),
                    child: const Text(
                      'Tutup Menu',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFEFE6EC)),

            // List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 18),
                itemCount: items.length,
                separatorBuilder: (_, __) => const Padding(
                  padding: EdgeInsets.only(left: 56),
                  child: Divider(height: 1, color: Color(0xFFEFE6EC)),
                ),
                itemBuilder: (context, i) {
                  final it = items[i];
                  return InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.pop(context);
                    if (it.title == 'Brosur') {
                                Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const BrosurPage()),
                            );
                        return;
                      }

                     if (it.title == 'Tagihan Sales') {
                                Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const TagihanSales()),
                            );
                        return;
                      }

                      if (it.title == 'Pengiriman') {
                                Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const PengirimanPage()),
                            );
                        return;
                      }
                      
                      
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4ECF2),
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFFEADDE6)),
                            ),
                            child: Icon(it.icon, color: AppTheme.primary, size: 18),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              it.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppTheme.textDark,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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

class _MoreItem {
  final String title;
  final IconData icon;
  _MoreItem(this.title, this.icon);
}
