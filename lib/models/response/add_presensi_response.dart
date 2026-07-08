import 'dart:convert';

class AddPresensiResponseModel {
  final String status;
  final String message;
  final dynamic data;

  AddPresensiResponseModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory AddPresensiResponseModel.fromJson(Map<String, dynamic> json) {
    return AddPresensiResponseModel(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }
}


class CheckinCheckOutRequest {
  final String? latitude;
  final String? longitude;
  final String? pictureBase64;  

  CheckinCheckOutRequest({
    this.latitude,
    this.longitude,
    this.pictureBase64,
  });

  factory CheckinCheckOutRequest.fromJson(String str) =>
      CheckinCheckOutRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CheckinCheckOutRequest.fromMap(Map<String, dynamic> json) =>
      CheckinCheckOutRequest(
        latitude: json["latitude"],
        longitude: json["longitude"],
        pictureBase64: json["picture"],  // Map the field correctly
      );

  Map<String, dynamic> toMap() => {
        "latitude": latitude,
        "longitude": longitude,
        "picture": pictureBase64,  // Map the field correctly
      };
}
