import 'dart:io';

import 'package:ecom/src/constant/app_colors.dart';
import 'package:ecom/src/theme/app_styles.dart';
import 'package:ecom/src/utils/device_info.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.leadingIcon,
    this.bgColor = AppColors.backgroundColor,
    this.onLeadingButtonTap,
    this.removeHorizontalPadding = false,
  });

  final String title;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingButtonTap;

  final Color bgColor;
  final bool removeHorizontalPadding;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        margin: EdgeInsets.only(
          left: removeHorizontalPadding ? 0 : Insets.medium,
          right: removeHorizontalPadding ? 0 : Insets.medium,
          top: Platform.isAndroid ? Insets.xsmall : 0,
        ),
        color: bgColor,
        height: preferredSize.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            onLeadingButtonTap != null
                ? IconButton(
                    onPressed: onLeadingButtonTap,
                    icon: Icon(leadingIcon),
                  )
                : SizedBox(width: Insets.medium),
            SizedBox(width: Insets.small),
            Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: DeviceInfo.textSize(20),
                fontWeight: FontWeight.w600,
                // color: AppColors.bgPrimary
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
