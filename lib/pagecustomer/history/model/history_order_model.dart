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

  factory CustomerOrderHistory.fromJson(Map<String, dynamic> json) {
    final details = json['details'] as List<dynamic>;
    final items = details.map((detail) => detail['product']['name'] as String).toList();
    final total = json['total'] as int;
    final status = _mapStatus(json['status'] as String);
    final paymentStatus = _mapPaymentStatus(json['status'] as String);
    final date = _formatDate(json['tanggal'] as String);

    return CustomerOrderHistory(
      invoice: json['invoice_number'] as String,
      date: date,
      status: status,
      total: total,
      itemCount: items.length,
      paymentStatus: paymentStatus,
      items: items,
    );
  }

  static String _mapStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Menunggu';
      case 'processing':
        return 'Diproses';
      case 'shipped':
        return 'Dikirim';
      case 'completed':
        return 'Selesai';
      case 'cancelled':
        return 'Dibatalkan';
      default:
        return 'Menunggu';
    }
  }

  static String _mapPaymentStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Menunggu Pembayaran';
      case 'processing':
        return 'Belum Lunas';
      case 'shipped':
        return 'Belum Lunas';
      case 'completed':
        return 'Lunas';
      case 'cancelled':
        return 'Dibatalkan';
      default:
        return 'Menunggu Pembayaran';
    }
  }

  static String _formatDate(String date) {
    final months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
    ];
    final parts = date.split('-');
    final day = parts[2];
    final month = months[int.parse(parts[1]) - 1];
    final year = parts[0];
    return '$day $month $year';
  }
}