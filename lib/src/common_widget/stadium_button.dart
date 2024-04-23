import 'package:ecom/src/constant/app_colors.dart';
import 'package:ecom/src/theme/app_styles.dart';
import 'package:ecom/src/utils/device_info.dart';
import 'package:flutter/material.dart';

class StadiumButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Color bgColor;
  final Color textColor;
  final double width;
  final double height;
  final double? radius;
  final TextStyle? textStyle;
  final double elevation;
  final BorderSide? borderSide;
  final bool hasBorder;

  const StadiumButton({
    super.key,
    required this.title,
    this.onTap,
    this.bgColor = AppColors.brandColor,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.height = 56,
    this.elevation = 1,
    this.textStyle,
    this.hasBorder = false,
    this.borderSide,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DeviceInfo.responsiveHeight(height),
      width: width,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: Colors.grey.withOpacity(0.2),
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 25)),
          elevation: elevation,

          ///INFO:No shadow added in UI
          // shadowColor: Colors.grey.shade200,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.zero,
          side: hasBorder
              ? borderSide ??
                  const BorderSide(color: AppColors.border, width: 1)
              : BorderSide.none,
        ),
        child: Text(
          title,
          textScaleFactor: 1.0,
          style: textStyle ??
              TextStyles.titleSmall.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
        ),
      ),
    );
  }
}
