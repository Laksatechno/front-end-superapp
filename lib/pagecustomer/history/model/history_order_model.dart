import 'dart:ffi';

import 'package:yofa/core/constants/variables.dart';

class CustomerOrderHistory {
  final int idSales;
  final String invoice;
  final String date;
  final String status;
  final int total;
  final int itemCount;
  final String orderStatus;
  final String paymentStatus;
  final List<String> items;
  final List<Map<String, dynamic>> details;
  final Shipment? shipment;

  CustomerOrderHistory({
    required this.idSales,
    required this.invoice,
    required this.date,
    required this.status,
    required this.total,
    required this.itemCount,
    required this.orderStatus,
    required this.paymentStatus,
    required this.items,
    required this.details,
    this.shipment,
  });

  factory CustomerOrderHistory.fromJson(Map<String, dynamic> json) {
    final details = (json['details'] as List<dynamic>? ?? []).map((detail) {
      return detail is Map<String, dynamic>
          ? detail
          : <String, dynamic>{};
    }).toList();
    
    final items = details.map((detail) {
      return detail['product'] != null && detail['product']['name'] != null
          ? detail['product']['name'] as String
          : 'Produk Tidak Dikenal';
    }).toList();
    
    final total = json['total'] as int? ?? 0;
    final status = _mapStatus(json['status'] as String? ?? 'pending');
    final orderStatus = _mapOrderStatus(json['order_status'] as String? ?? 'menunggu');
    final paymentStatus = _mapPaymentStatus(json['status'] as String? ?? 'pending');
    final date = json['tanggal'] != null ? _formatDate(json['tanggal'] as String) : 'Tanggal Tidak Dikenal';
    final shipment = json['shipment'] != null
    ? Shipment.fromJson(json['shipment'])
    : null;

    return CustomerOrderHistory(
      invoice: json['invoice_number'] as String? ?? 'Tidak Dikenal',
      idSales: json['id'] as int? ?? 0,
      date: date,
      status: status,
      total: total,
      itemCount: items.length,
      orderStatus: orderStatus,
      paymentStatus: paymentStatus,
      items: items,
      details: details,
      shipment: shipment,
    );
  }

  static String _mapOrderStatus(String orderStatus) {
    switch (orderStatus.toLowerCase()) {
      case 'menunggu':
        return 'Menunggu ';
      case 'diproses':
        return 'Diproses';
        case 'dikirim':
        return 'Dikirim';
      case 'selesai':
        return 'Selesai';
      case 'dibatalkan':
        return 'Dibatalkan';
      default:
        return 'Menunggu ';
    }
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
        return 'Menunggu';
      case 'processing':
        return 'Belum Lunas';
      case 'shipped':
        return 'Belum Lunas';
      case 'completed':
        return 'Lunas';
      case 'cancelled':
        return 'Dibatalkan';
      default:
        return 'Menunggu';
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

class Shipment {
  final int id;
  final String? deliveryDate;
  final String? arrivalDate;
  final String? photoProof;
  final List<ShipmentStatus> statuses;

  Shipment({
    required this.id,
    this.deliveryDate,
    this.arrivalDate,
    this.photoProof,
    required this.statuses,
  });


  factory Shipment.fromJson(Map<String, dynamic> json) {
    return Shipment(
      id: json['id'] ?? 0,
      deliveryDate: json['delivery_date'],
      arrivalDate: json['arrival_date'],
      photoProof:
      json['photo_proof'] != null
      ?
      Variables.storageUrl+'/shipment_photos/' + json['photo_proof']
      :
      null ?? '',
      statuses: (json['statuses'] as List<dynamic>? ?? [])
          .map((e) => ShipmentStatus.fromJson(e))
          .toList(),
    );
  }
}


class ShipmentStatus {

  final String status;
  final String timestamp;


  ShipmentStatus({
    required this.status,
    required this.timestamp,
  });


  factory ShipmentStatus.fromJson(Map<String,dynamic> json){

    return ShipmentStatus(
      status: json['status'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }
}