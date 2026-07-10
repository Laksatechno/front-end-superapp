import 'package:flutter/material.dart';
import 'package:yofa/pagecustomer/history/model/history_order_model.dart';
import 'package:yofa/theme/app_theme.dart';

class HistoryOrderDetailPage extends StatelessWidget {
  final CustomerOrderHistory order;

  const HistoryOrderDetailPage({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Detail Pesanan'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderInfo(context),
            const SizedBox(height: 24),
            _buildItemsList(context),
            const SizedBox(height: 24),
            _buildTotal(context),
            const SizedBox(height: 24),
            //tombol download invoice
            _buildDownloadButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoRow(
            label: 'No. Invoice',
            value: order.invoice,
          ),
          const SizedBox(height: 8),
          _InfoRow(
            label: 'Tanggal',
            value: order.date,
          ),
          const SizedBox(height: 8),
          _InfoRow(
            label: 'Status',
            value: order.status,
          ),
          const SizedBox(height: 8),
          _InfoRow(
            label: 'Pembayaran',
            value: order.paymentStatus,
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rincian Pesanan',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          // Tampilkan daftar barang dari order.details
          ...order.details.map(
            (detail) {
              final productName = detail['product']['name'] as String? ?? 'Produk Tidak Dikenal';
              final quantity = detail['quantity'] as int? ?? 1;
              final price = detail['price'] as int? ?? 0;
              final total = detail['total'] as int? ?? (quantity * price);
              
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$productName × $quantity',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${_formatRupiah(price)} × $quantity = ${_formatRupiah(total)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTotal(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border),
      ),
      child: _InfoRow(
        label: 'Total',
        value: _formatRupiah(order.total),
        isBold: true,
      ),
    );
  }

  Widget _buildDownloadButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          // Implementasi download invoice
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Fitur download invoice belum tersedia.')),
          );
        },
        icon: const Icon(Icons.download, color: Colors.white),
        label: const Text('Download Invoice', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  static String _formatRupiah(int value) {
    final text = value.toString();
    final buffer = StringBuffer();
    
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && (text.length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(text[i]);
    }
    
    return 'Rp $buffer';
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _InfoRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.textMuted,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}