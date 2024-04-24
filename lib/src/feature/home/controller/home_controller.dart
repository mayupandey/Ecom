import 'dart:developer';
import 'package:tuple/tuple.dart';
import 'package:ecom/src/feature/home/data/product_repository.dart';
import 'package:ecom/src/feature/home/model/product_list_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeState {
  ProductList? productList;
  HomeState({this.productList});
}

class HomeController extends StateNotifier<HomeState> {
  HomeController() : super(HomeState());

  final ProductRepository _productRepository = ProductRepository();

  Future<void> getProducts(ValueSetter<Tuple2<bool, String>> onResponse) async {
    try {
      if (state.productList != null) {
        log("Skip: ${state.productList!.skip}");
      }
      final res = await _productRepository.getProducts(
          limit: state.productList == null ? 10 : state.productList!.limit!,
          skip: state.productList == null ? 0 : state.productList!.skip!);

      res.skip = res.skip! + res.limit!;

      if (state.productList != null) {
        res.products!.insertAll(0, state.productList!.products!);
      }

      state = HomeState(productList: res);
      onResponse(const Tuple2(true, "Success"));
    } catch (e) {
      log(e.toString());
      onResponse(const Tuple2(false, "Failed"));
    }

    // final res = await _productRepository.getProducts(limit: 10, skip: 0);
    // setProductList(res);
  }
}

final homeProvider = StateNotifierProvider<HomeController, HomeState>((ref) {
  // ref.onDispose(() {
  //   print("Home Provider Disposed");
  //   HomeState().productList = null;
  // });

  return HomeController();
});
