import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yofa/datasources/auth/auth_local_datasource.dart';
import 'package:yofa/pagecustomer/history/model/history_order_model.dart';

class HistoryOrderDataSource {
  final String baseUrl = 'https://app.yofacorpora.com/api/yf/selforder/pesananuser';


  HistoryOrderDataSource();

  Future<List<CustomerOrderHistory>> fetchOrders({
    String? search,
    String? status,
    int page = 1,
    int perPage = 10,
  }) async {
      final authData = await AuthLocalDatasource().getAuthData();
      final token = authData?.token;
    final uri = Uri.parse(baseUrl).replace(
      queryParameters: {
        if (search != null) 'search': search,
        if (status != null) 'status': status,
        'page': page.toString(),
        'per_page': perPage.toString(),
      },
    );
    print('Fetching orders from: $uri'); // Debugging line

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    print ('Response status: ${response.statusCode}'); // Debugging line
    print ('Response body: ${response.body}'); // Debugging line

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] == 'success') {
        final data = jsonResponse['data'] as List<dynamic>;
        return data.map((item) => CustomerOrderHistory.fromJson(item)).toList();
      } else {
        throw Exception(jsonResponse['message'] ?? 'Gagal memuat data pesanan');
      }
    } else if (response.statusCode == 404) {
      final jsonResponse = json.decode(response.body);
      throw Exception(jsonResponse['message'] ?? 'Data tidak ditemukan');
    } else {
      throw Exception('Gagal memuat data pesanan');
    }
  }
}