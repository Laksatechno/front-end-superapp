import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yofa/core/constants/variables.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';
import 'package:yofa/pagecustomer/tagihan/model/tagihan_model.dart';

class TagihanDatasource {
  final http.Client _client;

  TagihanDatasource({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Tagihan>> getTagihan({
    String? search,
    int page = 1,
    int perPage = 10,
  }) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final token = authData?.token;

    final uri = Uri.parse('${Variables.baseUrl}/selforder/tagihanpesanan').replace(
      queryParameters: {
        'page': '$page',
        'per_page': '$perPage',
        if (search != null && search.trim().isNotEmpty) 'search': search.trim(),
      },
    );

    try {
      final response = await _client.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded is Map<String, dynamic> && decoded['status'] == 'success') {
          final data = decoded['data'];
          if (data is List) {
            return data
                .whereType<Map>()
                .map((e) => Tagihan.fromJson(Map<String, dynamic>.from(e)))
                .toList();
          }
        }
      }
    } catch (_) {
      // No fallback; data must come from the API.
    }

    throw Exception('Gagal memuat data tagihan dari server');
  }

  Future<List<Tagihan>> refreshTagihan({String? search}) async {
    return getTagihan(search: search, page: 1, perPage: 10);
  }

  Future<List<Tagihan>> loadMoreTagihan({
    String? search,
    required int page,
    int perPage = 10,
  }) async {
    return getTagihan(search: search, page: page, perPage: perPage);
  }
}