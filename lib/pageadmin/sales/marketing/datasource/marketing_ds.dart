import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:yofa/core/constants/variables.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';

import '../model/marketing_models.dart';

class MarketingDataSource {
  final http.Client _client;
  MarketingDataSource({http.Client? client}) : _client = client ?? http.Client();

  Future<Either<String, List<MarketingUser>>> fetchMarketingUsers() async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final token = authData?.token;

      final url = Uri.parse('${Variables.baseUrl}/usermarketing');

      final res = await _client.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (res.statusCode != 200) {
        return Left('Failed to fetch marketing: ${res.statusCode}');
      }

      final decoded = json.decode(res.body);
      if (decoded is! Map<String, dynamic>) {
        return const Left('Invalid response format');
      }

      final status = (decoded['status'] ?? '').toString().toLowerCase();
      if (status != 'success') {
        return Left((decoded['message'] ?? 'Unknown error').toString());
      }

      final list = decoded['data'];
      if (list is! List) return const Left('Invalid data format');

      final items = list
          .whereType<Map>()
          .map((e) => MarketingUser.fromJson(e.cast<String, dynamic>()))
          .toList();

      return Right(items);
    } catch (e) {
      return Left('Failed to fetch marketing: $e');
    }
  }
}