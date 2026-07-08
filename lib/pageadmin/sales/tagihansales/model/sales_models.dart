class SalesListResponse {
  final String status;
  final String message;
  final SalesPage data;

  SalesListResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SalesListResponse.fromJson(Map<String, dynamic> json) {
    return SalesListResponse(
      status: (json['status'] ?? '').toString(),
      message: (json['message'] ?? '').toString(),
      data: SalesPage.fromJson((json['data'] as Map?)?.cast<String, dynamic>() ?? const {}),
    );
  }
}

class SalesPage {
  final int currentPage;
  final List<Sale> data;
  final int? from;
  final int? lastPage;
  final int? perPage;
  final int? to;
  final int? total;

  final String? nextPageUrl;
  final String? prevPageUrl;

  SalesPage({
    required this.currentPage,
    required this.data,
    required this.from,
    required this.lastPage,
    required this.perPage,
    required this.to,
    required this.total,
    required this.nextPageUrl,
    required this.prevPageUrl,
  });

  factory SalesPage.fromJson(Map<String, dynamic> json) {
    final list = (json['data'] as List?) ?? const [];
    return SalesPage(
      currentPage: _asInt(json['current_page']),
      data: list
          .whereType<Map>()
          .map((e) => Sale.fromJson(e.cast<String, dynamic>()))
          .toList(),
      from: _asIntOrNull(json['from']),
      lastPage: _asIntOrNull(json['last_page']),
      perPage: _asIntOrNull(json['per_page']),
      to: _asIntOrNull(json['to']),
      total: _asIntOrNull(json['total']),
      nextPageUrl: json['next_page_url']?.toString(),
      prevPageUrl: json['prev_page_url']?.toString(),
    );
  }
}

class Sale {
  final int id;
  final String invoiceNumber;
  final int customerId;
  final int userId;
  final int total;
  final int tax;
  final String diskon;
  final String taxStatus; // ppn / non-ppn
  final String shippingFee;
  final String tanggal; // "2026-02-26"
  final String? dueDate; // "2026-03-28" nullable
  final String status; // pending/paid/etc (sesuai backend)
  final int isEditable;

  final CustomerLite? customer;
  final UserLite? user;
  final List<SaleDetail> details;
  final ShipmentLite? shipment;
  final PaymentLite? payment;

  Sale({
    required this.id,
    required this.invoiceNumber,
    required this.customerId,
    required this.userId,
    required this.total,
    required this.tax,
    required this.diskon,
    required this.taxStatus,
    required this.shippingFee,
    required this.tanggal,
    required this.dueDate,
    required this.status,
    required this.isEditable,
    required this.customer,
    required this.user,
    required this.details,
    required this.shipment,
    required this.payment,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    final detailsJson = (json['details'] as List?) ?? const [];
    return Sale(
      id: _asInt(json['id']),
      invoiceNumber: (json['invoice_number'] ?? '').toString(),
      customerId: _asInt(json['customer_id']),
      userId: _asInt(json['user_id']),
      total: _asInt(json['total']),
      tax: _asInt(json['tax']),
      diskon: (json['diskon'] ?? '0').toString(),
      taxStatus: (json['tax_status'] ?? '').toString(),
      shippingFee: (json['shipping_fee'] ?? '0').toString(),
      tanggal: (json['tanggal'] ?? '').toString(),
      dueDate: json['due_date']?.toString(),
      status: (json['status'] ?? '').toString(),
      isEditable: _asInt(json['is_editable']),
      customer: json['customer'] is Map
          ? CustomerLite.fromJson((json['customer'] as Map).cast<String, dynamic>())
          : null,
      user: json['user'] is Map
          ? UserLite.fromJson((json['user'] as Map).cast<String, dynamic>())
          : null,
      details: detailsJson
          .whereType<Map>()
          .map((e) => SaleDetail.fromJson(e.cast<String, dynamic>()))
          .toList(),
      shipment: json['shipment'] is Map
          ? ShipmentLite.fromJson((json['shipment'] as Map).cast<String, dynamic>())
          : null,
      payment: json['payment'] is Map
          ? PaymentLite.fromJson((json['payment'] as Map).cast<String, dynamic>())
          : null,
    );
  }
}

class CustomerLite {
  final int id;
  final int? areaId;
  final String name;
  final String phone;
  final String address;
  final String? email;
  final String tipePelanggan;

  CustomerLite({
    required this.id,
    required this.areaId,
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
    required this.tipePelanggan,
  });

  factory CustomerLite.fromJson(Map<String, dynamic> json) {
    return CustomerLite(
      id: _asInt(json['id']),
      areaId: _asIntOrNull(json['area_id']),
      name: (json['name'] ?? '').toString(),
      phone: (json['phone'] ?? '').toString(),
      address: (json['address'] ?? '').toString(),
      email: json['email']?.toString(),
      tipePelanggan: (json['tipe_pelanggan'] ?? '').toString(),
    );
  }
}

class UserLite {
  final int id;
  final String name;
  final String email;
  final String role;

  UserLite({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserLite.fromJson(Map<String, dynamic> json) {
    return UserLite(
      id: _asInt(json['id']),
      name: (json['name'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      role: (json['role'] ?? '').toString(),
    );
  }
}

class SaleDetail {
  final int id;
  final int saleId;
  final int productId;
  final int quantity;
  final int price;
  final int total;
  final String diskonBarang;

  final ProductLite? product; 
  SaleDetail({
    required this.id,
    required this.saleId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.total,
    required this.diskonBarang,
    required this.product,
  });

  factory SaleDetail.fromJson(Map<String, dynamic> json) {
    return SaleDetail(
      id: _asInt(json['id']),
      saleId: _asInt(json['sale_id']),
      productId: _asInt(json['product_id']),
      quantity: _asInt(json['quantity']),
      price: _asInt(json['price']),
      total: _asInt(json['total']),
      diskonBarang: (json['diskon_barang'] ?? '0').toString(),
      product: json['product'] is Map
          ? ProductLite.fromJson((json['product'] as Map).cast<String, dynamic>())
          : null,
    );
  }

}

class ProductLite {
  final int id;
  final String name;
  final int? stock;
  final bool? isSerialized;
  final int? totalStock;

  ProductLite({
    required this.id,
    required this.name,
    required this.stock,
    required this.isSerialized,
    required this.totalStock,
  });

  factory ProductLite.fromJson(Map<String, dynamic> json) {
    return ProductLite(
      id: _asInt(json['id']),
      name: (json['name'] ?? '').toString(),
      stock: json['stock'] == null ? null : _asInt(json['stock']),
      isSerialized: json['is_serialized'] == null ? null : (json['is_serialized'] == true || json['is_serialized'].toString() == '1'),
      totalStock: json['total_stock'] == null ? null : _asInt(json['total_stock']),
    );
  }
}
class ShipmentLite {
  final int id;
  final int saleId;
  final String deliveryDate;
  final String? arrivalDate;

  ShipmentLite({
    required this.id,
    required this.saleId,
    required this.deliveryDate,
    required this.arrivalDate,
  });

  factory ShipmentLite.fromJson(Map<String, dynamic> json) {
    return ShipmentLite(
      id: _asInt(json['id']),
      saleId: _asInt(json['sale_id']),
      deliveryDate: (json['delivery_date'] ?? '').toString(),
      arrivalDate: json['arrival_date']?.toString(),
    );
  }
}

class PaymentLite {
  final int id;
  final String status;

  PaymentLite({
    required this.id,
    required this.status,
  });

  factory PaymentLite.fromJson(Map<String, dynamic> json) {
    return PaymentLite(
      id: _asInt(json['id']),
      status: (json['status'] ?? '').toString(),
    );
  }
}

// ===== helpers =====
int _asInt(dynamic v) {
  if (v is int) return v;
  return int.tryParse(v?.toString() ?? '') ?? 0;
}

int? _asIntOrNull(dynamic v) {
  if (v == null) return null;
  if (v is int) return v;
  return int.tryParse(v.toString());
}