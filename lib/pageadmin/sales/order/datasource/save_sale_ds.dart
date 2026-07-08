import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:yofa/core/constants/variables.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';
import 'package:yofa/pageadmin/sales/tagihansales/model/sales_models.dart';

import '../model/save_sale_models.dart';

class SaveSaleDataSource {
  final http.Client _client;
  SaveSaleDataSource({http.Client? client}) : _client = client ?? http.Client();

  Future<Either<String, SaveSaleResult>> saveSale(SaveSaleRequest request) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final token = authData?.token;

      if (token == null || token.isEmpty) {
        return const Left('Authorization token is missing');
      }

      final url = Uri.parse('${Variables.baseUrl}/savesales');

    final body = jsonEncode(request.toApiMap());
      print(body);

      final res = await _client.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      final raw = res.body;

      dynamic decoded;
      try {
        decoded = jsonDecode(raw);
      } catch (_) {
        decoded = null;
      }

      if (res.statusCode < 200 || res.statusCode >= 300) {
        if (decoded is Map<String, dynamic>) {
          final msg = (decoded['message'] ?? 'Request failed').toString();
          final errs = decoded['errors'];
          if (errs is Map) {
            final flat = errs.values
                .expand((e) => (e is List) ? e : [e])
                .map((e) => e.toString())
                .join('\n');
            return Left('$msg\n$flat');
          }
          return Left(msg);
        }
        return Left('Failed to save sale: ${res.statusCode}\n$raw');
      }

      final result = SaveSaleResult.fromAny(decoded, rawBody: raw);

      if (result.success == false && decoded == null) {
        return Left('Unexpected response (non-JSON): $raw');
      }

      return Right(result);
    } catch (e) {
      return Left('Failed to save sale: $e');
    }
  }

  /// ✅ UPDATE SALE
  /// Karena controller update mewajibkan `tanggal`, kita kirim dari parameter.
  ///
  /// NOTE:
  /// - items tetap JSON string karena request.toApiMap() sudah jsonEncode(itemsList)
  /// - due_date tetap '1'|'2'|'3'|null sesuai request
  Future<Either<String, SaveSaleResult>> updateSale({
    required int saleId,
    required SaveSaleRequest request,
    required String tanggal,
  }) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final token = authData?.token;
      if (token == null || token.isEmpty) return const Left('Authorization token is missing');

      // kalau backend butuh tanggal terpisah (query/body), kita gabung di body
      final payload = request.toApiMap();
      payload['tanggal'] = tanggal;
      final url = Uri.parse('${Variables.baseUrl}/sales/update/$saleId'); // sesuaikan endpoint update

      // kalau backend kamu pakai PUT:
      final resp = await _client.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(payload),
      );

      
      print(jsonEncode(payload));
      final map = jsonDecode(resp.body) as Map<String, dynamic>;

      if (resp.statusCode >= 200 && resp.statusCode < 300) {
        return Right(SaveSaleResult.fromAny(map));
      }

      return Left(map['message']?.toString() ?? 'Gagal update penjualan');
    } catch (e) {
      return Left(e.toString());
    }
  }


  Future<Either<String, Sale>> fetchSaleDetail({
    required int id,
  }) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final token = authData?.token;
      if (token == null || token.isEmpty) {
        return const Left('Authorization token is missing');
      }

      final url = Uri.parse('${Variables.baseUrl}/sales/detail/$id');

      final res = await _client.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (res.statusCode < 200 || res.statusCode >= 300) {
        return Left('Gagal memuat detail sales (${res.statusCode}): ${res.body}');
      }

      final jsonMap = json.decode(res.body) as Map<String, dynamic>;
      final status = (jsonMap['status'] ?? '').toString();

      if (status.toLowerCase() != 'success') {
        return Left((jsonMap['message'] ?? 'Gagal memuat detail sales').toString());
      }

      final data = jsonMap['data'];
      if (data == null || data is! Map<String, dynamic>) {
        return const Left('Response detail sales tidak valid');
      }

      // Sale model kamu harus punya Sale.fromJson(Map)
      final sale = Sale.fromJson(data);
      return Right(sale);
    } catch (e) {
      return Left('Error fetchSaleDetail: $e');
    }
  }
}