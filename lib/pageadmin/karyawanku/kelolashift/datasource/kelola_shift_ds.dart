import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:yofa/core/constants/variables.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';
import 'package:yofa/pageadmin/karyawanku/kelolashift/models/shift_model.dart';

class KelolaShiftRemoteDatasource {
  Future<Either<String, ShiftModel>> fetchShift() async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();

      if (authData?.token == null) {
        return const Left('Authorization token is missing');
      }

      final url = Uri.parse('${Variables.baseUrl}/shift');

      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authData?.token}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return Right(ShiftModel.fromMap(responseData));
      } else {
        return Left('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Failed to get data: $e');
    }
  }
}
