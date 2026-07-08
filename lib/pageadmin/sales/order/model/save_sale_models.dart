import 'dart:convert';

class SaveSaleRequest {
  final int customerId;
  final String taxStatus;
  final String? dueDate;
  final int shippingFee;
  final int marketingId;
  final List<SaleItemRequest> items;

  SaveSaleRequest({
    required this.customerId,
    required this.taxStatus,
    required this.dueDate,
    required this.shippingFee,
    required this.marketingId,
    required this.items,
  });

  Map<String, dynamic> toApiMap() {
    final itemsList = items.map((e) => e.toMap()).toList();

    return {
      'customer_id': customerId,
      'tax_status': taxStatus,

      // Laravel validasi json biasanya butuh STRING JSON
      'items': jsonEncode(itemsList),

      'due_date': dueDate,
      'shipping_fee': shippingFee,
      'marketing': marketingId,
    };
  }

  String toJson() => jsonEncode(toApiMap());
}

class SaleItemRequest {
  final int productId;
  final int quantity;
  final int price;
  final int diskonBarang;
  final List<SaleBatchAllocation> batches;

  SaleItemRequest({
    required this.productId,
    required this.quantity,
    required this.price,
    required this.diskonBarang,
    this.batches = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'price': price,
      'diskon_barang': diskonBarang,
      'batches': batches.map((b) => b.toMap()).toList(),
    };
  }

  String toJson() => jsonEncode(toMap());
}

class SaleBatchAllocation {
  final int productBatchId;
  final int qty;
  final List<String> serials;

  SaleBatchAllocation({
    required this.productBatchId,
    required this.qty,
    this.serials = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'product_batch_id': productBatchId,
      'qty': qty,
      'serials': serials,
    };
  }

  String toJson() => jsonEncode(toMap());
}

class SaveSaleResult {
  final bool success;
  final String message;
  final int? saleId;
  final String? invoiceNumber;

  SaveSaleResult({
    required this.success,
    required this.message,
    this.saleId,
    this.invoiceNumber,
  });

  factory SaveSaleResult.fromAny(dynamic decoded, {String? rawBody}) {
    if (decoded is Map<String, dynamic>) {
      final data = decoded['data'];

      final msg = (decoded['message'] ?? decoded['msg'] ?? 'Success').toString();

      final saleId = _asIntOrNull(
        decoded['sale_id'] ??
            decoded['id'] ??
            (data is Map ? data['sale_id'] : null) ??
            (data is Map ? data['id'] : null),
      );

      final invoiceNumber = (decoded['invoice_number'] ??
              (data is Map ? data['invoice_number'] : null))
          ?.toString();

      final success = decoded['success'] == true ||
          decoded['status']?.toString().toLowerCase() == 'success';

      return SaveSaleResult(
        success: success,
        message: msg,
        saleId: saleId,
        invoiceNumber: invoiceNumber,
      );
    }

    return SaveSaleResult(
      success: false,
      message: rawBody ?? 'Unexpected response',
    );
  }
}

int? _asIntOrNull(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  return int.tryParse(value.toString());
}