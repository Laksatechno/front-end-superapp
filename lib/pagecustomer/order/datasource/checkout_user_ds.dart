import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:yofa/core/constants/variables.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';

class CheckoutUserDataSource {
  final http.Client _client;
  final AuthLocalDatasource _authLocalDatasource;

  CheckoutUserDataSource({
    http.Client? client,
    required AuthLocalDatasource authLocalDatasource,
  })  : _client = client ?? http.Client(),
        _authLocalDatasource = authLocalDatasource;

  Future<Either<String, String>> checkoutUser({
    required List<Map<String, dynamic>> items,
    required String userName,
    required String userAddress,
    required String userPhone,
    required String paymentType,
  }) async {
    try {
      final authData = await _authLocalDatasource.getAuthData();

      final token = authData?.token;

      if (token == null || token.isEmpty) {
        return const Left(
          'Authorization token is missing',
        );
      }

      final url = Uri.parse(
        '${Variables.baseUrl}/selforder/store',
      );
      print(jsonEncode(items));
      final response = await _client.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'items': jsonEncode(items),
          'user_name': userName,
          'user_address': userAddress,
          'user_phone': userPhone,
          'payment_type': paymentType
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        return Right(
          data['message']?.toString() ??
              'Checkout berhasil',
        );
      }

      return Left(
        data['message']?.toString() ??
            'Checkout gagal',
      );
    } catch (e) {
      return Left(
        e.toString(),
      );
    }
  }
}