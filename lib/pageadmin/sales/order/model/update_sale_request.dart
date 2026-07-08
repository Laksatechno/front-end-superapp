class UpdateSaleRequest {
  final int customerId;
  final String taxStatus; // 'ppn' | 'non-ppn'
  final String tanggal;   // 'YYYY-MM-DD'
  final String? dueDate;  // '1'|'2'|'3' | null
  final int shippingFee;
  final int total;
  final int marketing;
  final List<UpdateSaleItemRequest> items;

  const UpdateSaleRequest({
    required this.customerId,
    required this.taxStatus,
    required this.tanggal,
    required this.dueDate,
    required this.shippingFee,
    required this.total,
    required this.marketing,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'customer_id': customerId,
      'tax_status': taxStatus,
      'tanggal': tanggal,
      'due_date': dueDate,
      'shipping_fee': shippingFee,
      'total': total,
      'marketing': marketing,
      // controller kamu menerima items bisa array -> kirim array langsung
      'items': items.map((e) => e.toJson()).toList(),
    };
  }
}

class UpdateSaleItemRequest {
  final int productId;
  final int quantity;
  final int price;
  final int diskonBarang; // nominal
  final int total;


  final List<UpdateSaleBatchAllocation> batches;

  const UpdateSaleItemRequest({
    required this.productId,
    required this.quantity,
    required this.price,
    required this.diskonBarang,
    required this.total,
    this.batches = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'price': price,
      'diskon_barang': diskonBarang,
      'total': total,
      if (batches.isNotEmpty) 'batches': batches.map((e) => e.toJson()).toList(),
    };
  }
}

class UpdateSaleBatchAllocation {
  final int productBatchId;
  final int qty;

  final List<String> serials;

  const UpdateSaleBatchAllocation({
    required this.productBatchId,
    required this.qty,
    this.serials = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'product_batch_id': productBatchId,
      'qty': qty,
      if (serials.isNotEmpty) 'serials': serials,
    };
  }
}