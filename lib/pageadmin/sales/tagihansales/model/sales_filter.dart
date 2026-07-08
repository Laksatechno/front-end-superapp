// sales_filter.dart
class SalesFilter {
  final String search;
  final int? year; // null = semua
  final String? tax; // 'ppn' | 'non-ppn' | null
  final String? paymentStatus; // 'pending' | 'completed' | null

  const SalesFilter({
    this.search = '',
    this.year,
    this.tax,
    this.paymentStatus,
  });

  SalesFilter copyWith({
    String? search,
    int? year,
    bool clearYear = false,
    String? tax,
    bool clearTax = false,
    String? paymentStatus,
    bool clearPaymentStatus = false,
  }) {
    return SalesFilter(
      search: search ?? this.search,
      year: clearYear ? null : (year ?? this.year),
      tax: clearTax ? null : (tax ?? this.tax),
      paymentStatus: clearPaymentStatus ? null : (paymentStatus ?? this.paymentStatus),
    );
  }

  bool get hasAny =>
      search.trim().isNotEmpty || year != null || tax != null || paymentStatus != null;
}