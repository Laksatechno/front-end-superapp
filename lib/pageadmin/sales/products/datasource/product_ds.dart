import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:yofa/core/constants/variables.dart';

import 'package:yofa/datasources/auth/auth_local_datasource.dart';
import 'package:yofa/pageadmin/sales/products/model/products_model.dart';
import 'package:yofa/pageadmin/sales/products/model/product_page_response.dart';

class ProductRemoteDatasource {
  final http.Client _client;
  ProductRemoteDatasource({http.Client? client}) : _client = client ?? http.Client();

  Future<Either<String, ProductPageResponse>> fetchProducts({
    int page = 1,
    int perPage = 10,
    String? search,
  }) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final token = authData?.token;
      if (token == null || token.isEmpty) {
        return const Left('Authorization token is missing');
      }

      final queryParams = <String, String>{
        'page': '$page',
        'per_page': '$perPage',
        if (search != null && search.trim().isNotEmpty) 'search': search.trim(),
      };

      final url = Uri.parse('${Variables.baseUrl}/products').replace(queryParameters: queryParams);

      final response = await _client.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        return Left('Failed to fetch products: ${response.statusCode}');
      }

      final decoded = json.decode(response.body);

      final ok = (decoded is Map && decoded['status'] == 'success');
      if (!ok) {
        final msg = (decoded is Map ? decoded['message'] : null)?.toString() ?? 'Unknown error';
        return Left(msg);
      }

      final dataObj = (decoded as Map<String, dynamic>)['data'];
      if (dataObj is! Map<String, dynamic>) {
        return const Left('Invalid response: data is not an object');
      }

      final currentPage = (dataObj['current_page'] as num?)?.toInt() ?? page;
      final lastPage = (dataObj['last_page'] as num?)?.toInt() ?? 1;
      final perPageResp = (dataObj['per_page'] as num?)?.toInt() ?? perPage;
      final total = (dataObj['total'] as num?)?.toInt() ?? 0;

      final list = (dataObj['data'] as List?) ?? const [];

      return Right(ProductPageResponse(
        currentPage: currentPage,
        lastPage: lastPage,
        perPage: perPageResp,
        total: total,
        items: list.map((e) => Product.fromJson(e)).toList(),
      )) ;
    } catch (e) {
      return Left('Failed to fetch products: $e');
    }
  }

  Future<Either<String, Product>> fetchProductDetail({required int id}) async {
    try {
      final first = await fetchProducts(page: 1, perPage: 50);

      return await first.fold(
        (err) async => Left(err),
        (res) async {
          final found = res.items.where((p) => p.id == id).toList();
          if (found.isNotEmpty) return Right(found.first);

          final lastPage = res.lastPage;
          for (int p = 2; p <= lastPage; p++) {
            final next = await fetchProducts(page: p, perPage: 50);

            final r = next.fold<Either<String, Product>>(
              (err) => Left(err),
              (resp) {
                final f = resp.items.where((x) => x.id == id).toList();
                if (f.isNotEmpty) return Right(f.first);
                return const Left('__NOT_FOUND__');
              },
            );

            if (r.isLeft()) {
              final msg = r.swap().getOrElse(() => '');
              if (msg != '__NOT_FOUND__') return Left(msg);
            } else {
              return r;
            }
          }

          return Left('Product not found (id=$id)');
        },
      );
    } catch (e) {
      return Left('Failed to fetch product detail: $e');
    }
  }

  Future <Either<String, String>> deleteProduct({required int id}) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final token = authData?.token;
      if (token == null || token.isEmpty) {
        return const Left('Authorization token is missing');
      }

      final url = Uri.parse('${Variables.baseUrl}/products/$id');

      final response = await _client.delete(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        return Left('Failed to delete product: ${response.statusCode}');
      }

      final decoded = json.decode(response.body);

      final ok = (decoded is Map && decoded['status'] == 'success');
      if (!ok) {
        final msg = (decoded is Map ? decoded['message'] : null)?.toString() ?? 'Unknown error';
        return Left(msg);
      }

      return Right('Product deleted successfully');
    } catch (e) {
      return Left('Failed to delete product: $e');
    }
  }

  // create product 
  Future<Either<String, Product>> addProduct({
    required CreateProductRequest request,
  }) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final token = authData?.token;

      if (token == null || token.isEmpty) {
        return const Left('Authorization token is missing');
      }

      final url = Uri.parse('${Variables.baseUrl}/products');

      final response = await _client.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(request.toJson()),
      );
      print('Response body product: ${response.body}'); // Add this line to print the response bodyresponse.body);

      if (response.statusCode != 200 && response.statusCode != 201) {
        return Left('Failed to create product');
      }

      final decoded = json.decode(response.body);

      if (decoded['status'] != 'success') {
        return Left(decoded['message'] ?? 'Unknown error');
      }

      return Right(Product.fromJson(decoded['data']));
    } catch (e) {
      return Left('Failed to create product: $e');
    }
  }

  // create batch 
  Future<Either<String, String>> createBatch({
    required CreateBatchRequest request,
  }) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final token = authData?.token;

      if (token == null || token.isEmpty) {
        return const Left('Authorization token is missing');
      }

      final url = Uri.parse('${Variables.baseUrl}/batches/${request.productId}');

      final response = await _client.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(request.toJson()),
      );

      print('Response body batch: ${response.body}');

      if (response.statusCode != 200 && response.statusCode != 201) {
        return Left('Failed to create batch (${response.statusCode})');
      }

      final decoded = json.decode(response.body);

      if (decoded['status'] != 'success') {
        return Left(decoded['message'] ?? 'Unknown error');
      }

      return Right(decoded['message'] ?? 'Batch created');
    } catch (e) {
      return Left('Failed to create batch: $e');
    }
  }
}