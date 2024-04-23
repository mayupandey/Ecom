import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom/src/common_widget/cached_network_image.dart';
import 'package:ecom/src/constant/app_colors.dart';
import 'package:ecom/src/feature/home/model/product_list_modal.dart';
import 'package:ecom/src/theme/app_styles.dart';
import 'package:ecom/src/utils/device_info.dart';
import 'package:ecom/src/utils/favourites.dart';
import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

class ProductDetails extends StatefulWidget {
  final Products product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final List<Products> _items = [];
  void openBox() async {
    final fav = await Favourites.getInstance();
    setState(() {
      _items.addAll(fav.box!.values.toList());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openBox();
  }

  bool isFavoriteProduct(int productId) {
    return _items.any((product) => product.id == productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(
              onPressed: () async {
                final fav = await Favourites.getInstance();
                if (isFavoriteProduct(widget.product.id!)) {
                  fav.removeFavourite(widget.product.id!);
                  _items.removeWhere(
                      (element) => element.id == widget.product.id);
                } else {
                  fav.addFavourite(widget.product);
                }
                openBox();
              },
              icon: Icon(isFavoriteProduct(widget.product.id!)
                  ? Icons.favorite
                  : Icons.favorite_border))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: widget.product.id!,
                child: CarouselSlider(
                    items: widget.product.images!
                        .map((e) => CustomNetworkCacheImage(
                              imageUrl: e,
                              fit: BoxFit.contain,
                            ))
                        .toList(),
                    options: CarouselOptions(
                      height: DeviceInfo.responsiveHeight(300),
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                    )),
              ),
              SizedBox(
                height: DeviceInfo.responsiveHeight(10),
              ),
              SizedBox(
                width: Insets.small,
              ),
              Row(
                children: [
                  SizedBox(
                    width: DeviceInfo.responsiveWidth(250),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.title!,
                          maxLines: 2,
                          style: TextStyles.headingSmall.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: DeviceInfo.responsiveHeight(20)),
                        ),
                        Text(
                          '${widget.product.brand}',
                          style: TextStyles.headingSmall.copyWith(
                              // fontWeight: FontWeight.bo,
                              fontSize: DeviceInfo.responsiveHeight(16)),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Text(
                        '\$ ${widget.product.price}',
                        style: TextStyles.headingSmall.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: DeviceInfo.responsiveHeight(20)),
                      ),
                      Text(
                        ' ${widget.product.discountPercentage}%',
                        style: TextStyles.headingSmall.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor2,
                            fontSize: DeviceInfo.responsiveHeight(16)),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Text(
                    '${widget.product.rating}',
                    style: TextStyles.headingSmall.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: DeviceInfo.responsiveHeight(22)),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${widget.product.description}'),
              ),
              FilterChip(
                  label: Text(widget.product.category!),
                  onSelected: (value) {}),
            ],
          ),
        ),
      ),
    );
  }
}
