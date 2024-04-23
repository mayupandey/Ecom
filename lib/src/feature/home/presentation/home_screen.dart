import 'dart:developer';
import 'package:ecom/src/common_widget/app_bar.dart';
import 'package:ecom/src/constant/app_strings.dart';
import 'package:ecom/src/feature/home/controller/home_controller.dart';
import 'package:ecom/src/feature/home/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool isLoading = true;
  bool isEnd = false;
  // final _favBoxs = Hive.box<Products>('favourites');
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
            // leadingIcon: Icons.menu,
            onLeadingButtonTap: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Visibility(
                visible: !isLoading,
                replacement: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.68, crossAxisCount: 2),
                  itemCount: 10,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 200.0,
                      height: 100.0,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor: Colors.white,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                child: data.productList == null
                    ? Container(
                        height: 100,
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "No Data Found",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
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
                          return GestureDetector(
                              // onTap: () async {
                              //   final datas = await Favourites.getInstance();
                              //   datas.addItem(productData);
                              //   log("Data added");
                              // },

                              onTap: () {
                                context.push('/productDetails',
                                    extra: productData);
                              },
                              child: ProductCard(
                                productData: productData,
                              ));
                        })),
          ),
          isEnd == true ? const CircularProgressIndicator() : Container(),
        ],
      ),
    );
  }
}
