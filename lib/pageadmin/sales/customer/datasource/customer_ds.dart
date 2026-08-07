import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:yofa/core/constants/variables.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';
import 'package:yofa/pageadmin/sales/customer/model/customer_model.dart';

class CustomerDataSource {
  final http.Client _client;
  CustomerDataSource({http.Client? client}) : _client = client ?? http.Client();

  /// GET /api/v1/customers/{id}  — detail customer + user + area
  Future<Either<String, CustomerDetail>> fetchCustomerDetail(int id) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final token = authData?.token;
      if (token == null || token.isEmpty) {
        return const Left('Authorization token is missing');
      }

      final url = Uri.parse('${Variables.baseUrl1}/v1/customers/$id');
      final response = await _client.get(url, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode != 200) {
        return Left('Gagal memuat detail: ${response.statusCode}');
      }

      final decoded = json.decode(response.body);
      final status = (decoded is Map) ? decoded['status'] : null;
      if (status != 'success') {
        final msg = (decoded is Map ? decoded['message'] : null)?.toString() ?? 'Unknown error';
        return Left(msg);
      }

      final data = (decoded as Map<String, dynamic>)['data'];
      if (data is! Map<String, dynamic>) {
        return const Left('Format data tidak valid');
      }

      return Right(CustomerDetail.fromMap(data));
    } catch (e) {
      return Left('Gagal memuat detail: $e');
    }
  }

  /// PUT /api/v1/customers/{id}  — update data customer
  Future<Either<String, CustomerDetail>> updateCustomer({
    required int id,
    String? name,
    String? phone,
    String? address,
    String? email,
    String? tipePelanggan,
    int? areaId,
  }) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final token = authData?.token;
      if (token == null || token.isEmpty) {
        return const Left('Authorization token is missing');
      }

      final url = Uri.parse('${Variables.baseUrl1}/v1/customers/$id');
      final body = <String, dynamic>{
        if (name != null) 'name': name,
        if (phone != null) 'phone': phone,
        if (address != null) 'address': address,
        if (email != null) 'email': email,
        if (tipePelanggan != null) 'tipe_pelanggan': tipePelanggan,
        if (areaId != null) 'area_id': areaId,
      };

      final response = await _client.put(url, headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }, body: json.encode(body));

      if (response.statusCode != 200) {
        return Left('Gagal memperbarui: ${response.statusCode}');
      }

      final decoded = json.decode(response.body);
      final status = (decoded is Map) ? decoded['status'] : null;
      if (status != 'success') {
        final msg = (decoded is Map ? decoded['message'] : null)?.toString() ?? 'Unknown error';
        return Left(msg);
      }

      final data = (decoded as Map<String, dynamic>)['data'];
      if (data is! Map<String, dynamic>) {
        return const Left('Format data tidak valid');
      }

      return Right(CustomerDetail.fromMap(data));
    } catch (e) {
      return Left('Gagal memperbarui: $e');
    }
  }

  /// POST /api/v1/customers/{id}/link  — tautkan akun user
  Future<Either<String, String>> linkUser(int customerId, int userId) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final token = authData?.token;
      if (token == null || token.isEmpty) {
        return const Left('Authorization token is missing');
      }

      final url = Uri.parse('${Variables.baseUrl1}/v1/customers/$customerId/link');
      final response = await _client.post(url, headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }, body: json.encode({'user_id': userId}));

      final decoded = json.decode(response.body);
      final status = (decoded is Map) ? decoded['status'] : null;
      if (status == 'success') {
        return Right((decoded['message'] ?? 'Berhasil ditautkan').toString());
      }
      return Left((decoded['message'] ?? 'Gagal menautkan akun').toString());
    } catch (e) {
      return Left('Gagal menautkan akun: $e');
    }
  }

  /// DELETE /api/v1/customers/{id}/link  — putuskan tautan
  Future<Either<String, String>> unlinkUser(int customerId) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final token = authData?.token;
      if (token == null || token.isEmpty) {
        return const Left('Authorization token is missing');
      }

      final url = Uri.parse('${Variables.baseUrl1}/v1/customers/$customerId/link');
      final response = await _client.delete(url, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      final decoded = json.decode(response.body);
      final status = (decoded is Map) ? decoded['status'] : null;
      if (status == 'success') {
        return Right((decoded['message'] ?? 'Tautan diputus').toString());
      }
      return Left((decoded['message'] ?? 'Gagal memutus tautan').toString());
    } catch (e) {
      return Left('Gagal memutus tautan: $e');
    }
  }

  /// GET /api/v1/customers/unlinked-users  — daftar user belum ter-link
  Future<Either<String, List<LinkedUser>>> fetchUnlinkedUsers({String? search}) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final token = authData?.token;
      if (token == null || token.isEmpty) {
        return const Left('Authorization token is missing');
      }

      final queryParams = <String, String>{
        if (search != null && search.isNotEmpty) 'search': search,
      };

      final url = Uri.parse('${Variables.baseUrl1}/v1/customers/unlinked-users')
          .replace(queryParameters: queryParams);
      final response = await _client.get(url, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode != 200) {
        return Left('Gagal memuat user: ${response.statusCode}');
      }

      final decoded = json.decode(response.body);
      final dataObj = (decoded is Map<String, dynamic>) ? decoded['data'] : null;
      final list = (dataObj is Map<String, dynamic>) ? (dataObj['data'] as List?) : null;

      final users = (list ?? [])
          .whereType<Map<String, dynamic>>()
          .map(LinkedUser.fromMap)
          .toList();

      return Right(users);
    } catch (e) {
      return Left('Gagal memuat user: $e');
    }
  }

  Future<Either<String, CustomerPageResult>> fetchCustomers({
    int page = 1,
    int perPage = 10,
    String? filterType,
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

      final success = (decoded is Map && decoded['success'] == true);
      if (!success) {
        final msg = (decoded is Map ? decoded['message'] : null)?.toString() ?? 'Unknown error';
        return Left(msg);
      }

      final dataObj = (decoded as Map<String, dynamic>)['data'];
      final list = (dataObj is Map<String, dynamic>) ? (dataObj['data'] as List?) : null;
      final lastPage = (dataObj is Map<String, dynamic>)
          ? (dataObj['last_page'] as int? ?? 1)
          : 1;

      final customers = (list ?? [])
          .whereType<Map<String, dynamic>>()
          .map(Customer.fromMap)
          .toList();

      return Right(CustomerPageResult(customers: customers, lastPage: lastPage));
    } catch (e) {
      return Left('Failed to fetch data: $e');
    }
  }
}