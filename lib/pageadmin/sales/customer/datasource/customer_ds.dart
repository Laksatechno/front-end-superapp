import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:yofa/core/constants/variables.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';
import 'package:yofa/pageadmin/sales/customer/model/customer_model.dart';

class CustomerDataSource {
  final http.Client _client;
  CustomerDataSource({http.Client? client}) : _client = client ?? http.Client();

  Future<Either<String, List<Customer>>> fetchCustomers({
    int page = 1,
    int perPage = 10,
    String? filterType, // filter_type
    String? status,
  }) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final token = authData?.token;
      if (token == null || token.isEmpty) {
        return const Left('Authorization token is missing');
      }

      final queryParams = <String, String>{
        'page': '$page',
        'per_page': '$perPage',
        if (filterType != null && filterType.isNotEmpty) 'filter_type': filterType,
        if (status != null && status.isNotEmpty) 'status': status,
      };

      final url = Uri.parse('${Variables.baseUrl}/customer/loaddatacustomer')
          .replace(queryParameters: queryParams);

      final response = await _client.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        return Left('Failed to fetch data: ${response.statusCode}');
      }

      final decoded = json.decode(response.body);

      //  sesuai JSON kamu:
      // { success: true, message: "...", data: { data: [ ... ] } }
      final success = (decoded is Map && decoded['success'] == true);
      if (!success) {
        final msg = (decoded is Map ? decoded['message'] : null)?.toString() ?? 'Unknown error';
        return Left(msg);
      }

      final dataObj = (decoded as Map<String, dynamic>)['data'];
      final list = (dataObj is Map<String, dynamic>) ? (dataObj['data'] as List?) : null;

      final customers = (list ?? [])
          .whereType<Map<String, dynamic>>()
          .map(Customer.fromMap)
          .toList();

      return Right(customers);
    } catch (e) {
      return Left('Failed to fetch data: $e');
    }
  }
}