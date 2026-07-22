import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:yofa/core/constants/variables.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';
import 'package:yofa/pagecustomer/summary_home/model/summary_model.dart';


class SummaryDatasource {
  Future<SummaryModel> getSummary() async {

    final authData = await AuthLocalDatasource().getAuthData();
    final token = authData?.token ?? '';

    if (token.isEmpty) {
      throw Exception('Token tidak ditemukan');
    }


    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/selforder/summaryhomeuser'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );



    print(response);

    if (response.statusCode == 200) {

      final jsonData = jsonDecode(response.body);
      print(jsonData);

      return SummaryModel.fromMap(jsonData);

    } else {

      throw Exception(
        'Failed load summary (${response.statusCode}) : ${response.body}',
      );

    }
  }
}