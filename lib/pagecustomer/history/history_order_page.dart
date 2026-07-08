import 'package:flutter/material.dart';
import 'package:yofa/theme/app_theme.dart';

class HistoryCustomerOrderPage extends StatefulWidget {
  const HistoryCustomerOrderPage({super.key});

  @override
  State<HistoryCustomerOrderPage> createState() =>
      _HistoryCustomerOrderPageState();
}

class _HistoryCustomerOrderPageState extends State<HistoryCustomerOrderPage> {
  final TextEditingController _searchCtrl = TextEditingController();

  String _selectedStatus = 'Semua';

  final List<String> _statusFilters = [
    'Semua',
    'Menunggu',
    'Diproses',
    'Dikirim',
    'Selesai',
    // 'Dibatalkan',
  ];

  final List<CustomerOrderHistory> _orders = [
    CustomerOrderHistory(
      invoice: 'INV-20260526-001',
      date: '26 Mei 2026',
      status: 'Selesai',
      total: 1850000,
      itemCount: 4,
      paymentStatus: 'Lunas',
      items: [
        'Microcuvette',
        'Golda Anti A',
        'EDTA',
        'Masker Medis',
      ],
    ),
    CustomerOrderHistory(
      invoice: 'INV-20260525-002',
      date: '25 Mei 2026',
      status: 'Dikirim',
      total: 975000,
      itemCount: 2,
      paymentStatus: 'Belum Lunas',
      items: [
        'Microcuvette',
        'Golda Anti A',
      ],
    ),
    CustomerOrderHistory(
      invoice: 'INV-20260524-003',
      date: '24 Mei 2026',
      status: 'Diproses',
      total: 2450000,
      itemCount: 3,
      paymentStatus: 'Lunas',
      items: [
        'Microcuvette',
        'Golda Anti A',
        'Cuvette',
      ],
    ),
    CustomerOrderHistory(
      invoice: 'INV-20260523-004',
      date: '23 Mei 2026',
      status: 'Menunggu',
      total: 650000,
      itemCount: 1,
      paymentStatus: 'Menunggu Pembayaran',
      items: [
        'Golda Anti A',
      ],
    ),
    // CustomerOrderHistory(
    //   invoice: 'INV-20260520-005',
    //   date: '20 Mei 2026',
    //   status: 'Dibatalkan',
    //   total: 1200000,
    //   itemCount: 2,
    //   paymentStatus: 'Dibatalkan',
    //   items: [
    //     'Microcuvette',
    //     'Golda Anti A',
    //   ],
    // ),
  ];

  List<CustomerOrderHistory> get _filteredOrders {
    final keyword = _searchCtrl.text.toLowerCase().trim();

    return _orders.where((order) {
      final matchStatus =
          _selectedStatus == 'Semua' || order.status == _selectedStatus;

      final matchSearch =
          order.invoice.toLowerCase().contains(keyword) ||
          order.items.join(' ').toLowerCase().contains(keyword) ||
          order.status.toLowerCase().contains(keyword);

      return matchStatus && matchSearch;
    }).toList();
  }

  int get _totalOrder => _orders.length;

  int get _totalSelesai =>
      _orders.where((element) => element.status == 'Selesai').length;

  int get _totalProses => _orders
      .where(
        (element) =>
            element.status == 'Diproses' ||
            element.status == 'Dikirim' ||
            element.status == 'Menunggu',
      )
      .length;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final orders = _filteredOrders;

    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Riwayat Pesanan'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: RefreshIndicator(
        color: AppTheme.primary,
        onRefresh: _onRefresh,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 900;
            final maxWidth = isDesktop ? 1000.0 : double.infinity;

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _HeaderSection(
                        totalOrder: _totalOrder,
                        totalProses: _totalProses,
                        totalSelesai: _totalSelesai,
                      ),
                      const SizedBox(height: 16),
                      _SearchBox(
                        controller: _searchCtrl,
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 14),
                      _StatusFilter(
                        filters: _statusFilters,
                        selected: _selectedStatus,
                        onSelected: (value) {
                          setState(() {
                            _selectedStatus = value;
                          });
                        },
                      ),
                      const SizedBox(height: 18),
                      if (orders.isEmpty)
                        const _EmptyState()
                      else
                        ListView.separated(
                          itemCount: orders.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            return _OrderCard(order: orders[index]);
                          },
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomerOrderHistory {
  final String invoice;
  final String date;
  final String status;
  final int total;
  final int itemCount;
  final String paymentStatus;
  final List<String> items;

  CustomerOrderHistory({
    required this.invoice,
    required this.date,
    required this.status,
    required this.total,
    required this.itemCount,
    required this.paymentStatus,
    required this.items,
  });
}

class _HeaderSection extends StatelessWidget {
  final int totalOrder;
  final int totalProses;
  final int totalSelesai;

  const _HeaderSection({
    required this.totalOrder,
    required this.totalProses,
    required this.totalSelesai,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppTheme.primary,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withOpacity(0.18),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white24,
                child: Icon(
                  Icons.receipt_long_rounded,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Riwayat Pesanan Anda',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Pantau status dan detail pesanan secara mudah.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _SummaryCard(
                title: 'Total',
                value: '$totalOrder',
                icon: Icons.shopping_bag_outlined,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _SummaryCard(
                title: 'Proses',
                value: '$totalProses',
                icon: Icons.local_shipping_outlined,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _SummaryCard(
                title: 'Selesai',
                value: '$totalSelesai',
                icon: Icons.check_circle_outline,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppTheme.primary,
            size: 22,
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.textDark,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.textMuted,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBox extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SearchBox({
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Cari invoice, produk, atau status...',
        hintStyle: const TextStyle(color: AppTheme.hint),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: AppTheme.primary,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppTheme.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: AppTheme.primary,
            width: 1.4,
          ),
        ),
      ),
    );
  }
}

class _StatusFilter extends StatelessWidget {
  final List<String> filters;
  final String selected;
  final ValueChanged<String> onSelected;

  const _StatusFilter({
    required this.filters,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = filters[index];
          final active = item == selected;

          return ChoiceChip(
            selected: active,
            label: Text(item),
            onSelected: (_) => onSelected(item),
            selectedColor: AppTheme.primary,
            backgroundColor: Colors.white,
            labelStyle: TextStyle(
              color: active ? Colors.white : AppTheme.textMuted,
              fontWeight: FontWeight.w600,
            ),
            side: BorderSide(
              color: active ? AppTheme.primary : AppTheme.border,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          );
        },
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final CustomerOrderHistory order;

  const _OrderCard({
    required this.order,
  });

  Color get _statusColor {
    switch (order.status) {
      case 'Selesai':
        return Colors.green;
      case 'Dikirim':
        return Colors.blue;
      case 'Diproses':
        return Colors.orange;
      case 'Menunggu':
        return Colors.amber.shade700;
      case 'Dibatalkan':
        return Colors.red;
      default:
        return AppTheme.textMuted;
    }
  }

  IconData get _statusIcon {
    switch (order.status) {
      case 'Selesai':
        return Icons.check_circle_rounded;
      case 'Dikirim':
        return Icons.local_shipping_rounded;
      case 'Diproses':
        return Icons.inventory_2_rounded;
      case 'Menunggu':
        return Icons.schedule_rounded;
      case 'Dibatalkan':
        return Icons.cancel_rounded;
      default:
        return Icons.info_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final firstItem = order.items.isNotEmpty ? order.items.first : '-';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppTheme.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 14,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: _statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  _statusIcon,
                  color: _statusColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.invoice,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppTheme.textDark,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      order.date,
                      style: const TextStyle(
                        color: AppTheme.textMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              _StatusBadge(
                text: order.status,
                color: _statusColor,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.bg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _InfoRow(
                  label: 'Produk',
                  value: order.itemCount > 1
                      ? '$firstItem +${order.itemCount - 1} lainnya'
                      : firstItem,
                ),
                const SizedBox(height: 8),
                _InfoRow(
                  label: 'Pembayaran',
                  value: order.paymentStatus,
                ),
                const SizedBox(height: 8),
                _InfoRow(
                  label: 'Total',
                  value: _formatRupiah(order.total),
                  isBold: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.visibility_outlined, size: 18),
                  label: const Text('Detail'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primary,
                    side: const BorderSide(color: AppTheme.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_cart_checkout_rounded, size: 18),
                  label: const Text('Beli Lagi'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static String _formatRupiah(int value) {
    final text = value.toString();
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      final position = text.length - i;
      buffer.write(text[i]);
      if (position > 1 && position % 3 == 1) {
        buffer.write('.');
      }
    }

    return 'Rp $buffer';
  }
}

class _StatusBadge extends StatelessWidget {
  final String text;
  final Color color;

  const _StatusBadge({
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
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
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textMuted,
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppTheme.textDark,
              fontSize: 13,
              fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 38,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppTheme.border),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 54,
            color: AppTheme.hint,
          ),
          SizedBox(height: 12),
          Text(
            'Riwayat pesanan tidak ditemukan',
            style: TextStyle(
              color: AppTheme.textDark,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Coba ubah kata kunci pencarian atau filter status.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textMuted,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}