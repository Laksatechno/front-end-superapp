class Tagihan {
  final int id;
  final String invoiceNumber;
  final int total;
  final String status;
  final String paymentStatus;
  final String tanggal;
  final String? dueDate;
  final List<dynamic> details;

  Tagihan({
    required this.id,
    required this.invoiceNumber,
    required this.total,
    required this.status,
    required this.paymentStatus,
    required this.tanggal,
    required this.dueDate,
    required this.details,
  });

  factory Tagihan.fromJson(Map<String, dynamic> json) {
    return Tagihan(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
      invoiceNumber: (json['invoice_number'] ?? '').toString(),
      total: int.tryParse(json['total']?.toString() ?? '') ?? 0,
      status: (json['status'] ?? '').toString(),
      paymentStatus: (json['payment_status'] ?? '').toString(),
      tanggal: (json['tanggal'] ?? '').toString(),
      dueDate: json['due_date']?.toString(),
      details: json['details'] ?? const [],
    );
  }

  bool get isPaid => paymentStatus.toLowerCase() == 'paid' || paymentStatus.toLowerCase() == 'lunas';
  bool get isPending => paymentStatus.toLowerCase() == 'pending' || paymentStatus.toLowerCase() == 'menunggu';
  bool get isVerifikasiAdmin => paymentStatus.toLowerCase() == 'sedang verifikasi admin';


  String get displayStatus {
    if (isPaid) return 'Lunas';
    if (isPending) return 'Menunggu Pembayaran';
    if (isVerifikasiAdmin) return 'Sedang Verifikasi Admin';
    return status;
  }
}
