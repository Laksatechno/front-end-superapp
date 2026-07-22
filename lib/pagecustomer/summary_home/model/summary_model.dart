class SummaryModel {

  final String status;
  final int totalTagihan;
  final int totalOrder;


  SummaryModel({
    required this.status,
    required this.totalTagihan,
    required this.totalOrder,
  });



  factory SummaryModel.fromMap(Map<String, dynamic> json) {

    return SummaryModel(
      status: json['status'] ?? '',
      totalTagihan: json['total_tagihan'] ?? 0,
      totalOrder: json['total_order'] ?? 0,
    );

  }



  Map<String, dynamic> toMap(){

    return {
      'status': status,
      'total_tagihan': totalTagihan,
      'total_order': totalOrder,
    };

  }

}