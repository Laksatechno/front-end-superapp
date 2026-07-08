import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yofa/core/constants/variables.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';
import 'package:yofa/pageadmin/karyawanku/kelolapresensi/models/presensi_model.dart';

class KelolaPresensiRemoteDatasource {
Future<Either<String, HistoryBulananPresensiModel>> fetchRiwayatPresensi({
    String? filterType,
    DateTimeRange? dateRange,
    String? status,
  }) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();

      if (authData?.token == null) {
        return const Left('Authorization token is missing');
      }

      final url = Uri.parse('${Variables.baseUrl}/presensi/loadsemua/admin');

      final Map<String, String> queryParams = {};

      if (filterType != null) {
        queryParams['filter_type'] = filterType;
      }

      if (dateRange != null) {
        queryParams['start_date'] = dateRange.start.toIso8601String();
        queryParams['end_date'] = dateRange.end.toIso8601String();
      }
      print(queryParams);
      // if (status != null) {
      //   queryParams['status'] = status;
      // }

      final response = await http.get(
        url.replace(queryParameters: queryParams),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authData?.token}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return Right(HistoryBulananPresensiModel.fromMap(responseData));
      } else {
        return Left('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Failed to get data: $e');
    }
  }

  Future<Either<String, String>> updateRiwayatPresensi(HistoryBulananPresensi riwayatPresensi) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();

      if (authData?.token == null) {
        return const Left('Authorization token is missing');
      }

      final url = Uri.parse('${Variables.baseUrl}/presensi/update');

      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authData?.token}',
        },
        body: json.encode(riwayatPresensi.toMap()),
      );

      if (response.statusCode == 200) {
        return const Right('Riwayat presensi updated successfully');
      } else {
        return Left('Failed to update data: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Failed to update data: $e');
    }
  }
}