import 'package:flutter/material.dart';
import 'package:yofa/pagecustomer/shipping/shipping_customer_page.dart';
import 'package:yofa/theme/app_theme.dart';

class DetailPengirimanPage extends StatelessWidget {
  final PengirimanItem item;
  const DetailPengirimanPage({super.key, required this.item});

  String _stageText(ShippingStage s) {
    switch (s) {
      case ShippingStage.handover:
        return 'Pesanan sudah diserahkan ke logistik';
      case ShippingStage.onTheWay:
        return 'Pesanan Sedang perjalanan';
      case ShippingStage.delivered:
        return 'Barang sampai';
    }
  }

  Widget _pill(String text, {bool solid = false, IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: solid ? AppTheme.primary : const Color(0xFFF4ECF2),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: const Color(0xFFEADDE6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: solid ? Colors.white : AppTheme.primary),
            const SizedBox(width: 6),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w900,
              color: solid ? Colors.white : AppTheme.primary,
            ),
          ),
        ],
      ),
    );
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
          ),
        ],
      ),
      child: child,
    );
  }

  void _showProof(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 3 / 4,
                child: Image.network(item.proofUrl, fit: BoxFit.cover),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _timelineTile({
    required String title,
    required bool done,
    required bool active,
    Widget? trailing,
  }) {
    final dotColor = done || active ? AppTheme.primary : const Color(0xFFBEB2BA);
    final lineColor = done ? AppTheme.primary : const Color(0xFFEADDE6);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // left line + dot
        Column(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 2,
              height: 44,
              color: lineColor,
            ),
          ],
        ),
        const SizedBox(width: 12),

        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: done || active ? AppTheme.textDark : const Color(0xFF6F646B),
                    ),
                  ),
                ),
                if (trailing != null) trailing,
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final stage = item.stage;

    final doneHandover = stage == ShippingStage.handover ||
        stage == ShippingStage.onTheWay ||
        stage == ShippingStage.delivered;
    final doneOnWay = stage == ShippingStage.onTheWay || stage == ShippingStage.delivered;
    final doneDelivered = stage == ShippingStage.delivered;

    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Detail Pengiriman'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        children: [
          _card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.invoice,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: AppTheme.textDark,
                      fontSize: 14.5,
                    )),
                const SizedBox(height: 8),
                Text(
                  item.customer,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF6F646B),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _pill('Status: ${_stageText(stage)}', icon: Icons.local_shipping_outlined),
                  ],
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
                  'Timeline',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 12),

                _timelineTile(
                  title: 'Pesanan sudah diserahkan ke logistik',
                  done: doneHandover,
                  active: stage == ShippingStage.handover,
                ),

                _timelineTile(
                  title: 'Pesanan Sedang perjalanan',
                  done: doneOnWay,
                  active: stage == ShippingStage.onTheWay,
                ),

                _timelineTile(
                  title: 'Barang sampai',
                  done: doneDelivered,
                  active: stage == ShippingStage.delivered,
                  trailing: doneDelivered
                      ? InkWell(
                          onTap: () => _showProof(context),
                          borderRadius: BorderRadius.circular(999),
                          child: _pill('Lihat Bukti Pengiriman', solid: true, icon: Icons.image_outlined),
                        )
                      : null,
                ),

                // rapihin garis terakhir (hapus "tail")
                const SizedBox(height: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
