

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:yofa/core/constants/variables.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';
import 'package:yofa/pageadmin/sales/area/model/area_model.dart';

class AreaRemoteDatasource {
  final http.Client _client;

  AreaRemoteDatasource(this._client);

  Future<Either<String, List<Area>>> fetchArea() async {
  try {
    final authData = await AuthLocalDatasource().getAuthData();
    final token = authData?.token;

    if (token == null || token.isEmpty) {
      return const Left('Authorization token is missing');
    }

    final url = Uri.parse('${Variables.baseUrl}/area');

    final res = await _client.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode != 200) {
      return Left('Failed to fetch data: ${res.statusCode}');
    }

    final decoded = jsonDecode(res.body);

    print("decoded: $decoded");

    if (decoded is! Map<String, dynamic>) {
      return const Left('Invalid response format');
    }

    final success = decoded['success'] ?? false;

    if (success != true) {
      return Left(decoded['message'] ?? 'Failed to fetch area');
    }

    final data = decoded['data'];

    if (data is! List) {
      return const Left('Invalid data format');
    }

    final areas = data
        .map((item) => Area.fromJson(item as Map<String, dynamic>))
        .toList();

    return Right(areas);
  } catch (e) {
    return Left('Error: $e');
  }
}
}