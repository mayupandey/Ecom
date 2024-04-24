import 'package:ecom/src/feature/category/controller/category_controller.dart';
import 'package:ecom/src/feature/category/presentation/products_screen.dart';
import 'package:ecom/src/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  bool isLoading = true;

  @override
  void initState() {
    ref.read(categoryController.notifier).getCategory((res) {
      if (res.item1) {
        setState(() {
          isLoading = false;
        });
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final category = ref.watch(categoryController);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Category"),
        ),
        body: Visibility(
            visible: !isLoading,
            //TODO: SHIMMER EFFECT
            replacement: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.95, crossAxisCount: 2),
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return SizedBox(
                  // width: 200.0,
                  // height: 100.0,
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
            child: category.category == null
                ? const Text("data")
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.95,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemCount: category.category!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductsScreen(
                                          category: category.category![index],
                                        )));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                category.category![index],
                                style: TextStyles.bodyMedium.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ))),
                        ),
                      );
                    })));
  }
}
