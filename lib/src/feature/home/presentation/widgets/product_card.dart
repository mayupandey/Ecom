import 'package:ecom/src/common_widget/cached_network_image.dart';
import 'package:ecom/src/constant/app_colors.dart';
import 'package:ecom/src/feature/home/model/product_list_modal.dart';
import 'package:ecom/src/theme/app_styles.dart';
import 'package:ecom/src/utils/device_info.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Products? productData;
  const ProductCard({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CustomNetworkCacheImage(
              imageUrl: productData!.images![0].toString(),
              height: DeviceInfo.responsiveHeight(100),
              fit: BoxFit.fill,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "-${productData!.discountPercentage}%",
                  style: TextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              const Icon(Icons.favorite_border, color: Colors.red),
            ],
          ),
          SizedBox(
            height: DeviceInfo.responsiveHeight(10),
          ),
          Text(productData!.title!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.headingLarge.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: DeviceInfo.textSize(16)),
              textAlign: TextAlign.start),
          Flexible(
            child: Text(productData!.description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.bodySmall.copyWith(
                    // fontWeight: FontWeight.w900,
                    fontSize: DeviceInfo.textSize(12)),
                textAlign: TextAlign.start),
          ),
          Text("\$${productData!.price}",
              style:
                  TextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.start),
        ],
      ),
    );
  }
}
