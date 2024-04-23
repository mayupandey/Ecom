import 'package:ecom/src/constant/app_colors.dart';
import 'package:ecom/src/utils/device_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  //---------------- Display ----------------G
  static TextStyle displayLarge = GoogleFonts.raleway(
    fontSize: DeviceInfo.textSize(57),
    fontWeight: FontWeight.normal,
    // color: AppColors.textHigh,
  );

  static TextStyle displayMedium = GoogleFonts.raleway(
    fontSize: DeviceInfo.textSize(45),
    fontWeight: FontWeight.normal,
    // color: AppColors.textHigh,
  );

  static TextStyle displaySmall = GoogleFonts.raleway(
    fontSize: DeviceInfo.textSize(36),
    fontWeight: FontWeight.normal,
    // color: AppColors.textHigh,
  );

  //---------------- Heading ----------------
  static TextStyle headingLarge = GoogleFonts.raleway(
    fontSize: DeviceInfo.textSize(32),
    fontWeight: FontWeight.normal,
    // color: AppColors.textHigh,
  );

  static TextStyle headingMedium = GoogleFonts.raleway(
    fontSize: DeviceInfo.textSize(28),
    fontWeight: FontWeight.normal,
    // color: AppColors.textHigh,
  );

  static TextStyle headingSmall = GoogleFonts.raleway(
    fontSize: DeviceInfo.textSize(24),
    fontWeight: FontWeight.normal,
    // color: AppColors.textHigh,
  );

  //---------------- Title ----------------
  static TextStyle titleLarge = GoogleFonts.raleway(
    fontSize: DeviceInfo.textSize(20),
    letterSpacing: 1.60,
    fontWeight: FontWeight.w800,
    //   color: AppColors.bgPrimary,
  );

  static TextStyle titleMedium = GoogleFonts.raleway(
    fontSize: DeviceInfo.textSize(16),
    fontWeight: FontWeight.w500,
    // color: AppColors.textHigh,
  );

  static TextStyle titleSmall = GoogleFonts.raleway(
    fontSize: DeviceInfo.textSize(14),
    fontWeight: FontWeight.w500,
    //   color: AppColors.textHigh,
  );

  //---------------- Label ----------------
  static TextStyle labelLarge = GoogleFonts.raleway(
    fontSize: DeviceInfo.textSize(14),
    fontWeight: FontWeight.w500,
    // color: AppColors.textHigh,
  );

  static TextStyle labelMedium = GoogleFonts.raleway(
    fontSize: DeviceInfo.textSize(12),
    fontWeight: FontWeight.w500,
    // color: AppColors.textHigh,
  );

  static TextStyle labelSmall = GoogleFonts.raleway(
    fontSize: DeviceInfo.textSize(11),
    fontWeight: FontWeight.w500,
    // color: AppColors.textHigh,
  );

  //---------------- Body ----------------
  static TextStyle bodyLarge = GoogleFonts.raleway(
    fontSize: DeviceInfo.textSize(16),
    fontWeight: FontWeight.normal,
    // color: AppColors.textHigh,
  );

  static TextStyle bodyMedium = GoogleFonts.raleway(
    fontSize: DeviceInfo.textSize(14),
    fontWeight: FontWeight.normal,
    // color: AppColors.textHigh,
  );

  static TextStyle bodySmall = GoogleFonts.raleway(
    fontSize: DeviceInfo.textSize(12),
    fontWeight: FontWeight.normal,
    // color: AppColors.textHigh,
  );

  /// Link text style
  /// TODO: Not used
  static TextStyle link = GoogleFonts.raleway(
    // color: AppColors.primary,
    decoration: TextDecoration.underline,
    fontWeight: FontWeight.w500,
  );
//
// /// Open email text button
// /// /// TODO: Not used
// static TextStyle openEmailText = TextStyle(
//   fontSize: DeviceInfo.textSize(15),
//   color: Colors.blue,
//   fontWeight: FontWeight.w600,
//   letterSpacing: -0.1,
// );

  static TextStyle contentStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(
      color: Color(0xFF282C3F),
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  );

  static TextStyle contentHighlight = GoogleFonts.openSans(
    textStyle: const TextStyle(
      color: Color(0xFF505054),
      fontSize: 12,
      fontWeight: FontWeight.w700,
    ),
  );
}

class Insets {
  /// xxxsmall value is 2.0
  static double xxxsmall = DeviceInfo.responsiveWidth(2.0);

  /// xxsmall value is 4.0
  static double xxsmall = DeviceInfo.responsiveWidth(4.0);

  /// xsmallLow value is 6.0
  static double xsmallLow = DeviceInfo.responsiveWidth(6.0);

  /// xsmall value is 8.0
  static double xsmall = DeviceInfo.responsiveWidth(8.0);

  /// small value is 12.0
  static double small = DeviceInfo.responsiveWidth(12.0);

  /// medium value is 16.0
  static double medium = DeviceInfo.responsiveWidth(16.0);

  /// large value is 24.0
  static double large = DeviceInfo.responsiveWidth(24.0);

  /// xlarge value is 32.0
  static double xlarge = DeviceInfo.responsiveWidth(32.0);

  /// xxlarge value is 40.0
  static double xxlarge = DeviceInfo.responsiveWidth(40.0);

  /// xxxlarge value is 48.0
  static double xxxlarge = DeviceInfo.responsiveWidth(48.0);
}
