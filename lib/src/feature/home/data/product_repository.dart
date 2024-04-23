import 'dart:convert';
import 'dart:developer';

import 'package:ecom/src/config/network/dio/dio_client.dart';
import 'package:ecom/src/config/network/endpoints.dart';
import 'package:ecom/src/feature/home/model/product_list_modal.dart';

class ProductRepository {
  final _dio = DioClient();

  Future<ProductList> getProducts(
      {required int limit, required int skip}) async {
    try {
      log("tapped me");
      final res =
          await _dio.dio.get(Endpoints.fetchProductsEndpoint, queryParameters: {
        'limit': limit,
        'skip': skip,
      });

      if (res.statusCode == 200) {
        // log(res.data.toString(), name: "ProductRepository");
        return ProductList.fromJson(res.data);
      }
      throw Exception("Failed to load data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getProductsCategory(
      {required String limit, required String skip}) async {
    try {
      final res = await _dio.dio.get(Endpoints.fetchCategoriesEndpoint);
      return jsonDecode(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductList> getProductByCategory(
      {required String category, required int limit, required int skip}) async {
    try {
      final res = await _dio.dio.get(
          "${Endpoints.fetchProductsByCategoryEndpoint}/$category",
          queryParameters: {
            'category': category,
            'limit': limit,
            'skip': skip,
          });
      return ProductList.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}
