import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/src/constant/app_assets.dart';
import 'package:ecom/src/constant/app_colors.dart';
import 'package:ecom/src/utils/device_info.dart';
import 'package:flutter/material.dart';

class CustomNetworkCacheImage extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final fit;
  const CustomNetworkCacheImage(
      {super.key, required this.imageUrl, this.height, this.width, this.fit});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      fit: fit ?? BoxFit.cover,
      height: height ?? MediaQuery.of(context).size.height,
      width: width ?? double.infinity,
      errorWidget: (context, url, error) => const Center(
          child: Center(
        child: Icon(
          Icons.error,
        ),
      )),
    );
  }
}
