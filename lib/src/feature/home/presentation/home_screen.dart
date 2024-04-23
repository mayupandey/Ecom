import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/src/common_widget/app_bar.dart';
import 'package:ecom/src/common_widget/cached_network_image.dart';
import 'package:ecom/src/constant/app_colors.dart';
import 'package:ecom/src/constant/app_strings.dart';
import 'package:ecom/src/feature/authentication/controller/authentication_controller.dart';
import 'package:ecom/src/feature/home/controller/home_controller.dart';
import 'package:ecom/src/feature/home/presentation/widgets/product_card.dart';
import 'package:ecom/src/theme/app_styles.dart';
import 'package:ecom/src/utils/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool isLoading = true;
  bool isEnd = false;
  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    _controller.addListener(_scrollListener);
    ref.read(homeProvider.notifier).getProducts((value) {
      if (value.item1) {
        print("Success");
        setState(() {
          isLoading = false;
        });
      } else {
        print("Error");
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      // You've reached the end of the screen
      print('End of screen reached!');

      if (ref.read(homeProvider).productList!.skip !=
          ref.read(homeProvider).productList!.total) {
        ref.read(homeProvider.notifier).getProducts((value) {
          if (value.item1) {
            setState(() {
              isEnd = true;
            });
            print("Success");
            var dt = ref.read(homeProvider).productList!.skip;
            log("Total Data: $dt");
          }
        });
      } else {
        log("Sdf");
        setState(() {
          isEnd = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final data = ref.read(authProvider);
    final data = ref.watch(homeProvider);

    return SingleChildScrollView(
      controller: _controller,
      child: Column(
        children: [
          CustomAppBar(
            title: AppStrings.appName,
            leadingIcon: Icons.menu,
            onLeadingButtonTap: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Visibility(
                visible: !isLoading,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: data.productList == null
                    ? Container()
                    : GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.68, crossAxisCount: 2),
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.productList!.products!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final productData =
                              data.productList!.products![index];
                          return ProductCard(productData: productData);
                        })),
          ),
          isEnd == true ? const CircularProgressIndicator() : Container(),
        ],
      ),
    );
  }
}
