import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:yofa/core/constants/variables.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';
import 'package:yofa/pageadmin/karyawanku/kelolalat/model/maintenance_model.dart';


class RiwayatDataSource {
  Future<Either<String, List<MaintenanceModel>>> getRiwayat({
    String? from,
    String? to,
    String? search,
  }) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final token = authData?.token;

      if (token == null || token.isEmpty) {
        return const Left('Authorization token is missing');
      }

      final query = <String, String>{};

      if (from != null && from.isNotEmpty) query['from'] = from;
      if (to != null && to.isNotEmpty) query['to'] = to;
      if (search != null && search.isNotEmpty) query['search'] = search;

      final uri = Uri.parse('${Variables.baseUrl}/maintenance')
          .replace(queryParameters: query.isEmpty ? null : query);

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      final decoded = json.decode(response.body);
      print ('Response body riwayat: ${response.body}');

      if (response.statusCode != 200) {
        final message = decoded is Map<String, dynamic>
            ? decoded['message']?.toString()
            : null;

        return Left(message ?? 'Gagal mengambil data riwayat');
      }

      if (decoded is! Map<String, dynamic>) {
        return const Left('Format response tidak valid');
      }

      final dynamic rawData = decoded['data'];

      List<dynamic> dataList = [];

      if (rawData is List) {
        dataList = rawData;
      } else if (rawData is Map<String, dynamic>) {
        final nestedData = rawData['data'];
        if (nestedData is List) {
          dataList = nestedData;
        }
      }

      final result = dataList
          .whereType<Map>()
          .map((item) => MaintenanceModel.fromMap(Map<String, dynamic>.from(item)))
          .toList();

      return Right(result);
    } catch (e) {
      return Left('Terjadi kesalahan: $e');
    }
  }
}