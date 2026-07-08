import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:yofa/core/constants/variables.dart';
import 'package:yofa/models/response/auth_response_model.dart';
import 'package:yofa/models/response/notification_response_model.dart';
import 'package:yofa/page/register/model/resgister_model.dart';
import 'auth_local_datasource.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      String username, String password) async {
    final url = Uri.parse('${Variables.baseUrl}/login');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': username,
        'password': password,
      }),
    );

    print( 'LOGIN STATUS: ${response.statusCode} - ${response.body}'); // <-- debug response.body);
    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    }else if(response.statusCode == 404){
      return const Left('Email salah');
    }else if (response.statusCode == 401){
      return const Left('Password salah');
    }
     else {
      return const Left('Gagal Login');
    }
  }

  //logout
Future<Either<String, String>> logout() async {
  try {
    final local = AuthLocalDatasource();
    final authData = await local.getAuthData();

    // Kalau token tidak ada, tetap bersihkan local dan selesai
    final token = authData?.token;
    if (token == null || token.isEmpty) {
      await local.clearAuthData();
      return const Right('Logout success');
    }

    final url = Uri.parse('${Variables.baseUrl}/logout');

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      await local.clearAuthData();
      return const Right('Logout success');
    }

    // Kalau token sudah tidak valid (401), tetap bersihkan local biar user bisa login ulang
    if (response.statusCode == 401) {
      await local.clearAuthData();
      return const Right('Session expired. Please login again.');
    }

    return Left('Failed to logout (${response.statusCode})');
  } catch (e) {
    return Left('Logout error: $e');
  }
}


  Future<Either<String, String >> updateuser() async {
    final authData = await AuthLocalDatasource().getAuthData();
    if (authData == null || authData.token == null) {
      return const Left('No auth data found');
    }

    final url = Uri.parse('${Variables.baseUrl}/update-user');
    final headers = {
      'Authorization': 'Bearer ${authData.token}',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return Right(responseData['message']);
      } else {
        final responseData = json.decode(response.body);
        return Left(responseData['message']);
      }
    } catch (e) {
      return Left('Error updating user: $e');
    }
  }




  Future<void> updateFcmToken(String fcmToken) async {
    final authData = await AuthLocalDatasource().getAuthData();
    if (authData == null || authData.token == null) {
      print('No auth data found');
      return;
    }

    final url = Uri.parse('${Variables.baseUrl}/update-fcm-token');
    final headers = {
      'Authorization': 'Bearer ${authData.token}',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode({
          'fcm_token': fcmToken,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('FCM token updated successfully: ${responseData['message']}');
      } else {
        final responseData = json.decode(response.body);
        print('Failed to update FCM token: ${responseData['message']}');
      }
    } catch (e) {
      print('Error updating FCM token: $e');
    }
  }

    Future<Either<String, NotificationResponseModel>> getNotification() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/notifikasi');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
    );

    if (response.statusCode == 200) {
      return Right(NotificationResponseModel.fromJson(response.body));
    } else {
      return const Left('Gagal Memuat Notifikasi');
    }
  }
  
  // countnotifikasi 
  Future<Either<String, CountNotificationResponseModel>> countNotification() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/countnotifikasi');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
    );

    if (response.statusCode == 200) {
      print(response.body); 
      return Right(CountNotificationResponseModel.fromJson(response.body));
    } else {
      return const Left('Gagal Memuat Jumlah Notifikasi');
    }      
  }

  Future<Either<String, RegisterModel>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String noHp,
    required String alamat,
    required String tipePelanggan,
    required String jenisInstitusi,
    required int marketingId,
  }) async {
    try {
      final url = Uri.parse('${Variables.baseUrl}/register');

      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'no_hp': noHp,
          'alamat': alamat,
          'tipe_pelanggan': tipePelanggan,
          'jenis_institusi': jenisInstitusi,
          'marketing_id': marketingId,
        }),
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        final userData = body['user'];

        if (userData == null || userData is! Map<String, dynamic>) {
          return const Left('User data not found');
        }

        return Right(RegisterModel.fromMap(userData));
      }

      if (response.statusCode == 422) {
        final errors = body['errors'];

        if (errors is Map && errors.isNotEmpty) {
          final firstError = errors.values.first;

          if (firstError is List && firstError.isNotEmpty) {
            return Left(firstError.first.toString());
          }
        }

        return Left(body['message']?.toString() ?? 'Validasi gagal');
      }

      return Left(body['message']?.toString() ?? 'Registration failed');
    } catch (e) {
      return Left('Registration failed: $e');
    }
  }

}