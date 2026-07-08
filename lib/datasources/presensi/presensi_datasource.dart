import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:yofa/core/constants/variables.dart';
import 'package:yofa/models/response/add_presensi_response.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';

class PresensiDatasource {
  Future<Either<String, AddPresensiResponseModel>> addPresensi(
    CheckinCheckOutRequest request,
  ) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final token = authData?.token;

      if (token == null || token.isEmpty) {
        return const Left('Token tidak ditemukan, silakan login ulang.');
      }

      final url = Uri.parse(
        '${Variables.baseUrl}/presensi/selfie',
      ); // <-- sesuaikan endpoint

      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: request.toJson(),
      );

      // debug
      // print('PRESENSI STATUS: ${response.statusCode}');
      // print('PRESENSI BODY: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = json.decode(response.body) as Map<String, dynamic>;
        return Right(AddPresensiResponseModel.fromJson(decoded));
      }

      if (response.statusCode == 401) {
        return const Left('Session habis. Silakan login ulang.');
      }

      // ambil message jika ada
      try {
        final map = json.decode(response.body);
        final msg = (map['message'] ?? 'Gagal presensi').toString();
        return Left(msg);
      } catch (_) {
        return Left('Gagal presensi (${response.statusCode})');
      }
    } catch (e) {
      return Left('Error presensi: $e');
    }
  }
}
