import 'dart:developer';

import 'package:ecom/src/feature/home/data/product_repository.dart';
import 'package:ecom/src/feature/home/model/product_list_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

class CategoryState {
  List<dynamic>? category;
  ProductList? products;
  CategoryState({this.category, this.products});
}

class CategoryController extends StateNotifier<CategoryState> {
  CategoryController() : super(CategoryState());
  final ProductRepository _productRepository = ProductRepository();

  Future<void> getCategory(ValueSetter<Tuple2<bool, String>> onResponse) async {
    try {
      final res =
          await _productRepository.getProductsCategory(limit: "10", skip: "0");
      state.category = res;
      state = CategoryState(category: res);
      onResponse(const Tuple2(true, "Success"));
    } catch (e) {
      onResponse(const Tuple2(false, "Something went wrong"));
    }
  }

  Future<void> getCategoryProducts(ValueSetter<Tuple2<bool, String>> onResponse,
      {required String category}) async {
    try {
      final res = await _productRepository.getProductByCategory(
          category: category, limit: 10, skip: 0);
      state.products = res;
      state = CategoryState(products: res, category: state.category);
      onResponse(const Tuple2(true, "Success"));
    } catch (e) {
      onResponse(const Tuple2(false, "Something went wrong"));
    }
  }
}

final categoryController =
    StateNotifierProvider<CategoryController, CategoryState>((ref) {
  ref.onDispose(() {
    print("Category Provider Disposed");
    CategoryState().category = null;
  });

  return CategoryController();
});
