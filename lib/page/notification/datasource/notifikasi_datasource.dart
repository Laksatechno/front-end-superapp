import 'dart:convert';
import 'package:yofa/core/constants/variables.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';
import 'package:yofa/page/notification/model/notifikasi_model.dart';
import 'package:http/http.dart' as http;

class NotifikasiDataSource {
  final String baseUrl = '${Variables.baseUrl}/notifikasi';

  Future<List<NotifikasiModel>> getNotifikasi() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final token = authData?.token ?? '';

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    print('Notifikasi Response status: ${response.statusCode}');
    print('Notifikasi Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] == 'success') {
        final data = jsonResponse['data'] as List<dynamic>;
        return data
            .map((item) => NotifikasiModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(jsonResponse['message'] ?? 'Gagal memuat data notifikasi');
      }
    } else if (response.statusCode == 401) {
      throw Exception('Sesi telah berakhir, silakan login ulang');
    } else if (response.statusCode == 404) {
      final jsonResponse = json.decode(response.body);
      throw Exception(jsonResponse['message'] ?? 'Data tidak ditemukan');
    } else {
      throw Exception('Gagal memuat data notifikasi (Status: ${response.statusCode})');
    }
  }
}
