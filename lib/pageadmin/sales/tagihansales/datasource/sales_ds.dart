import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:yofa/core/constants/variables.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';

import '../model/sales_models.dart';

class SalesDataSource {
  final http.Client _client;
  SalesDataSource({http.Client? client}) : _client = client ?? http.Client();

  Future<Either<String, SalesListResponse>> fetchSales({
    int page = 1,
    String? search,
    int? year,
    String? paymentStatus, // backend: status
    String? taxStatus, // ppn / non-ppn
  }) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final token = authData?.token;

      if (token == null || token.isEmpty) {
        return const Left('Authorization token is missing');
      }

      final query = <String, String>{
        'page': '$page',
        if (search != null && search.trim().isNotEmpty) 'search': search.trim(),
        if (year != null) 'year': '$year',
        if (paymentStatus != null && paymentStatus.isNotEmpty) 'payment_status': paymentStatus,
        if (taxStatus != null && taxStatus.isNotEmpty) 'tax_status': taxStatus,
      };

      final url = Uri.parse('${Variables.baseUrl}/sales/loadsales')
          .replace(queryParameters: query);

      final res = await _client.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (res.statusCode != 200) {
        return Left('Failed to fetch sales: ${res.statusCode}');
      }

      final decoded = json.decode(res.body);
      if (decoded is! Map<String, dynamic>) {
        return const Left('Invalid response format');
      }

      final status = (decoded['status'] ?? '').toString().toLowerCase();
      if (status != 'success') {
        final msg = (decoded['message'] ?? 'Unknown error').toString();
        return Left(msg);
      }

      return Right(SalesListResponse.fromJson(decoded));
    } catch (e) {
      return Left('Failed to fetch sales: $e');
    }
  }
}