import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:yofa/core/constants/variables.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';

import '../model/customer_product_price_model.dart';

class CustomerProductsDataSource {
  final http.Client _client;
  CustomerProductsDataSource({http.Client? client})
      : _client = client ?? http.Client();

    Future<Either<String, List<CustomerProductPrice>>> getProductsByCustomer({
      required int customerId,
    }) async {
      try {
        final authData = await AuthLocalDatasource().getAuthData();
        final token = authData?.token;

        if (token == null || token.isEmpty) {
          return const Left('Authorization token is missing');
        }

        final url = Uri.parse(
          '${Variables.baseUrl}/customers/products/$customerId',
        );



        final res = await _client.get(
          url,
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        Map<String, dynamic> decoded = {};

        try {
          decoded = json.decode(res.body) as Map<String, dynamic>;
        } catch (_) {
          return const Left('Invalid response format');
        }

        /// ambil message dari backend jika ada
        final message = (decoded['message'] ?? 'Unknown error').toString();

        /// handle selain 200
        if (res.statusCode != 200) {
          return Left(message);
        }

        final status = (decoded['status'] ?? '').toString().toLowerCase();

        if (status != 'success') {
          return Left(message);
        }

        final rawData = decoded['data'];

        /// jika data kosong
        if (rawData == null) {
          return const Right([]);
        }

        if (rawData is! List) {
          return const Left('Invalid data format');
        }

        final items = rawData
            .whereType<Map<String, dynamic>>()
            .map((e) => CustomerProductPrice.fromJson(e))
            .toList();

        return Right(items);
      } catch (e) {
        return Left('Failed to fetch data: $e');
      }
    }
}
