import 'package:ecom/src/feature/category/controller/category_controller.dart';
import 'package:ecom/src/feature/home/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  final String category;
  const ProductsScreen({super.key, required this.category});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
  bool isLoading = true;

  @override
  void initState() {
    ref.read(categoryController.notifier).getCategoryProducts((res) {
      if (res.item1) {
        setState(() {
          isLoading = false;
        });
      }
    }, category: widget.category);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(categoryController);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.category),
        ),
        body: SingleChildScrollView(
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
            child: Container(
              child: data.products == null
                  ? const Text("data")
                  : GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.68, crossAxisCount: 2),
                      // physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.products!.products!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final productData = data.products!.products![index];
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
                      }),
            ),
          ),
        ));
  }
}
