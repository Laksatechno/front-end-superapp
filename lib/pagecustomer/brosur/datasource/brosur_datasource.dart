// lib/pagecustomer/brosur/datasource/brosur_datasource.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';
import '../model/brosur_model.dart';

class BrosurDatasource {
  final String baseUrl = 'https://app.yofacorpora.com/api/brosur';

  Future<List<Brosur>> getBrosur({String? search}) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final token = authData?.token;

    final uri = Uri.parse(search != null ? '$baseUrl?search=$search' : baseUrl);
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> data = jsonData['data'];
      return data.map((item) => Brosur.fromJson(item)).toList();
    } else {
      throw Exception('Gagal mengambil data brosur');
    }
  }

  Future<String> downloadBrosur(int id, String fileName) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final token = authData?.token;

    final uri = Uri.parse('$baseUrl/$id/download');
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Simpan file ke local storage
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    } else {
      throw Exception('Gagal mengunduh brosur');
    }
  }
}