import 'package:ecom/src/feature/home/model/product_list_modal.dart';
import 'package:ecom/src/feature/home/presentation/widgets/product_card.dart';
import 'package:ecom/src/utils/favourites.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  List<Products> favouriteList = [];
  Future<void> openHive() async {
    final data = await Favourites.getInstance();
    setState(() {
      favouriteList = data.box!.values.toList();
    });

    print(data.box!.values.length);
  }

  @override
  void didChangeDependencies() {
    openHive();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.68, crossAxisCount: 2),
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: favouriteList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final productData = favouriteList[index];
                      return GestureDetector(
                          onTap: () {
                            context.push('/productDetails', extra: productData);
                          },
                          child: ProductCard(
                            productData: productData,
                          ));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
