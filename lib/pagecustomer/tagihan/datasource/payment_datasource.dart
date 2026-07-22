import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:yofa/core/constants/variables.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';
import 'package:yofa/pagecustomer/tagihan/model/payment_model.dart';

class PaymentDatasource {
  final http.Client _client;

  PaymentDatasource({http.Client? client}) : _client = client ?? http.Client();

  Future<PaymentModel> uploadPaymentProof({
    required int id,
    required File file,
  }) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final token = authData?.token ?? '';

    final uri = Uri.parse('${Variables.baseUrl}/selforder/payment/$id');

    try {
      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Accept'] = 'application/json'
        ..files.add(await http.MultipartFile.fromPath('photo', file.path));

      final streamedResponse = await _client.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = json.decode(response.body) as Map<String, dynamic>;

        if (decoded['success'] == true) {
          final data = decoded['data'] as Map<String, dynamic>?;
          if (data != null) {
            return PaymentModel.fromJson(data);
          }
        }

        throw Exception(
          decoded['message']?.toString() ??
              'Gagal mengunggah bukti pembayaran',
        );
      } else {
        throw Exception(
          'Gagal mengunggah bukti pembayaran (${response.statusCode})',
        );
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Terjadi kesalahan saat mengunggah bukti pembayaran');
    }
  }
}
