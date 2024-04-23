import 'package:flutter/material.dart';

class DeviceInfo {

  static late MediaQueryData? mediaQueryData;

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

  }

  //static late ThemeData theme;

  /// Check if the device has top notch and require safe area from top
  static bool isNeedSafeAreaTop = mediaQueryData!.viewPadding.top > 0;

  /// Check if the device has bottom notch and require safe area from bottom
  static bool isNeedSafeAreaBottom = mediaQueryData!.viewPadding.bottom > 0;

  /// Get shortest side width of the device
  static double getWidth({double divideBy = 1}) => mediaQueryData!.size.shortestSide / divideBy;

  /// Get longest side height of the device
  static double getHeight({double divideBy = 1}) => mediaQueryData!.size.longestSide / divideBy;

  /// [responsiveWidth] is calculated by dividing given value by mockup device
  /// width(375.0) and then multiply by the device actual width.
  ///
  /// * For example, [responsiveWidth(50)] will be:
  ///  50 / 375.0 * getWidth()
  static double responsiveWidth(double value) {
    return value / 375.0 * getWidth();
  }

  /// [responsiveHeight] is calculated by dividing given value by mockup device
  /// height(812.0) and then multiply by the device actual height.
  ///
  /// * For example, [responsiveHeight(50)] will be:
  ///  50 / 812.0 * getHeight()
  static double responsiveHeight(double value) {
    return value / 812.0 * getHeight();
  }

  static double textSize(double size) {
    //TODO: Check if text is rendering correct with width or height
    return mediaQueryData == null ? size : (size * getWidth() / 375.0);
  }

}
