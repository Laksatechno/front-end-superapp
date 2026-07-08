import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:yofa/core/constants/variables.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';
import 'package:yofa/pageadmin/karyawanku/kelolalat/model/alat_model.dart';
import 'package:yofa/pageadmin/karyawanku/kelolalat/model/maintenance_model.dart';


class AlatDataSource {
  Future<Map<String, String>> _headers() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final token = authData?.token;

    if (token == null || token.isEmpty) {
      throw Exception('Authorization token is missing');
    }

    return {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

List<dynamic> _safeList(dynamic decoded) {
  if (decoded is Map<String, dynamic>) {
    final data = decoded['data'];

    if (data is Map<String, dynamic>) {
      if (data['alats'] is List) {
        return data['alats'] as List;
      }

      if (data['data'] is List) {
        return data['data'] as List;
      }
    }

    if (data is List) {
      return data;
    }

    if (decoded['alats'] is List) {
      return decoded['alats'] as List;
    }
  }

  if (decoded is List) return decoded;

  return [];
}

  String _safeMessage(dynamic decoded, String fallback) {
    if (decoded is Map<String, dynamic>) {
      return decoded['message']?.toString() ?? fallback;
    }
    return fallback;
  }

  Future<Either<String, List<Alat>>> getAlats({
    int page = 1,
    int perPage = 10,
    String? filterType,
    String? status,
    String? search,
  }) async {
    try {
      final headers = await _headers();

      final uri = Uri.parse('${Variables.baseUrl1}/v1/terpasang').replace(
        queryParameters: {
          'page': '$page',
          'per_page': '$perPage',
          if (filterType != null && filterType.isNotEmpty)
            'filter_type': filterType,
          if (status != null && status.isNotEmpty) 'status': status,
          if (search != null && search.isNotEmpty) 'search': search,
        },
      );

      final response = await http.get(uri, headers: headers);
      final decoded = json.decode(response.body);


      print ("decoded" + decoded);

      if (response.statusCode != 200) {
        return Left(_safeMessage(decoded, 'Gagal mengambil data alat'));
      }

      final list = _safeList(decoded);
      return Right(
        list
            .whereType<Map>()
            .map((e) => Alat.fromMap(Map<String, dynamic>.from(e)))
            .toList(),
      );
    } catch (e) {
      return Left(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<Either<String, Alat>> searchCustomerBarcode(String noseri) async {
    try {
      final headers = await _headers();

      final uri = Uri.parse('${Variables.baseUrl}/v1/searchdatacustomerbarcode')
          .replace(queryParameters: {'noseri': noseri});

      final response = await http.get(uri, headers: headers);
      final decoded = json.decode(response.body);

      if (response.statusCode != 200) {
        return Left(_safeMessage(decoded, 'Data customer tidak ditemukan'));
      }

      final data = decoded['data'];
      if (data is Map<String, dynamic>) {
        return Right(Alat.fromMap(data));
      }

      if (data is List && data.isNotEmpty && data.first is Map) {
        return Right(Alat.fromMap(Map<String, dynamic>.from(data.first)));
      }

      return const Left('Data customer tidak ditemukan');
    } catch (e) {
      return Left(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<Either<String, Alat>> searchDataChip(String noseri) async {
    try {
      final headers = await _headers();

      final uri = Uri.parse('${Variables.baseUrl}/v1/searchdatachip')
          .replace(queryParameters: {'noseri': noseri});

      final response = await http.get(uri, headers: headers);
      final decoded = json.decode(response.body);

      if (response.statusCode != 200) {
        return Left(_safeMessage(decoded, 'Data chip tidak ditemukan'));
      }

      final data = decoded['data'];
      if (data is Map<String, dynamic>) {
        return Right(Alat.fromMap(data));
      }

      if (data is List && data.isNotEmpty && data.first is Map) {
        return Right(Alat.fromMap(Map<String, dynamic>.from(data.first)));
      }

      return const Left('Data chip tidak ditemukan');
    } catch (e) {
      return Left(e.toString().replaceAll('Exception: ', ''));
    }
  }

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

  Future<Either<String, String>> tambahMaintenance({
    required Map<String, dynamic> body,
  }) async {
    try {
      final headers = await _headers();

      final response = await http.post(
        Uri.parse('${Variables.baseUrl}/v1/tambahmaintenance'),
        headers: headers,
        body: json.encode(body),
      );

      final decoded = json.decode(response.body);

      if (response.statusCode != 200 && response.statusCode != 201) {
        return Left(_safeMessage(decoded, 'Gagal menambah maintenance'));
      }

      return Right(_safeMessage(decoded, 'Maintenance berhasil ditambahkan'));
    } catch (e) {
      return Left(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<Either<String, String>> updateMaintenance({
    required Map<String, dynamic> body,
  }) async {
    try {
      final headers = await _headers();

      final response = await http.post(
        Uri.parse('${Variables.baseUrl}/v1/updatemaintenance'),
        headers: headers,
        body: json.encode(body),
      );

      final decoded = json.decode(response.body);

      if (response.statusCode != 200) {
        return Left(_safeMessage(decoded, 'Gagal update maintenance'));
      }

      return Right(_safeMessage(decoded, 'Maintenance berhasil diupdate'));
    } catch (e) {
      return Left(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<Either<String, String>> moveAlat({
    required Map<String, dynamic> body,
  }) async {
    try {
      final headers = await _headers();

      final response = await http.post(
        Uri.parse('${Variables.baseUrl}/v1/move'),
        headers: headers,
        body: json.encode(body),
      );

      final decoded = json.decode(response.body);

      if (response.statusCode != 200) {
        return Left(_safeMessage(decoded, 'Gagal memindahkan alat'));
      }

      return Right(_safeMessage(decoded, 'Alat berhasil dipindahkan'));
    } catch (e) {
      return Left(e.toString().replaceAll('Exception: ', ''));
    }
  }
}