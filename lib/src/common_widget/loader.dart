import 'package:ecom/src/constant/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

buildShowDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return IgnorePointer(
        child: Center(child: Lottie.asset(AppAssets.loadingLottie)),
      );
    },
  );
}
