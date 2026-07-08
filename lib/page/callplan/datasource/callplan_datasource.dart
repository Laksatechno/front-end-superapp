import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yofa/core/constants/variables.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';
import 'package:yofa/page/callplan/model/callplan_models.dart';

class CallplanRemoteDatasource {

  /// ===========================
  /// FETCH
  /// ===========================
  Future<Either<String, List<CallplanItem>>> fetchCallplan({
    String? filterType,
    DateTimeRange? dateRange,
  }) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();

      if (authData == null || authData.token == null) {
        return const Left('Authorization token is missing');
      }

      final Map<String, String> queryParams = {};

      if (filterType != null && filterType.isNotEmpty) {
        queryParams['filter_type'] = filterType;
      }

      if (dateRange != null) {
        queryParams['start_date'] = dateRange.start.toIso8601String();
        queryParams['end_date'] = dateRange.end.toIso8601String();
      }

      final uri = Uri.parse(
        '${Variables.baseUrl}/callplan/data-callplan',
      ).replace(
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );

      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final List dataList = decoded['data'] ?? [];

        final result = dataList
            .map<CallplanItem>((e) => CallplanItem.fromMap(e))
            .toList();

        return Right(result);
      } else {
        return Left(decoded['message'] ?? 'Failed fetch data');
      }
    } catch (e) {
      return Left('Exception: $e');
    }
  }

  /// ===========================
  /// CREATE
  /// ===========================
  Future<Either<String, String>> createCallplan({
    required DateTime tanggalCp,
    required String outlet,
    required String description,
  }) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();

      if (authData == null || authData.token == null) {
        return const Left('Authorization token is missing');
      }

      final response = await http.post(
        Uri.parse('${Variables.baseUrl}/callplan/tambah-data-callplan'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
        body: {
          'tanggal_cp': tanggalCp.toIso8601String(),
          'nama_outlet': outlet,
          'description': description,
        },
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return Right(decoded['message'] ?? 'Success');
      } else {
        return Left(decoded['message'] ?? 'Failed create data');
      }
    } catch (e) {
      return Left('Exception: $e');
    }
  }

  /// ===========================
  /// UPDATE
  /// ===========================
  Future<Either<String, String>> updateCallplan({
    required int id,
    required DateTime tanggalCp,
    required String outlet,
    required String description,
  }) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();

      if (authData == null || authData.token == null) {
        return const Left('Authorization token is missing');
      }

      final response = await http.put(
        Uri.parse('${Variables.baseUrl}/callplan/edit-data-callplan/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
        body: {
          'tanggal_cp': tanggalCp.toIso8601String(),
          'nama_outlet': outlet,
          'description': description,
        },
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return Right(decoded['message'] ?? 'Berhasil update');
      } else {
        return Left(decoded['message'] ?? 'Gagal update');
      }
    } catch (e) {
      return Left('Exception: $e');
    }
  }

  Future<Either<String, String>> deleteCallplan({
    required int id,
  }) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();

      if (authData == null || authData.token == null) {
        return const Left('Authorization token is missing');
      }

      final response = await http.delete(
        Uri.parse('${Variables.baseUrl}/callplan/hapus-data-callplan'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
        body: {
          'callplan_id': id.toString(), 
        },
      );

      print(id);

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return Right(decoded['message'] ?? 'Berhasil hapus');
      } else {
        return Left(decoded['message'] ?? 'Gagal hapus');
      }
    } catch (e) {
      return Left('Exception: $e');
    }
  }
}