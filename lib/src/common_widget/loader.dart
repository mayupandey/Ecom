import 'package:ecom/const/resource.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

//KAAM AAYEGA
/*
CELEBRATION LOTTIE
ASSETS_LOTTIE_CONFETTI_CELEBRATION_JSON
ASSETS_LOTTIE_CELEBRATION_FIREWORK_JSON
*/

buildShowDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return IgnorePointer(
        child: Center(
            child: Lottie.asset(AppAssets.ASSETS_LOTTIE_VOUCHERANIMATION_JSON)),
      );
    },
  );
}
