import 'package:cosmetics/core/theme/app_colors/light_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_texts/app_text_styles.dart';

void showCustomSnackBar(
  BuildContext context,
  String message, {
  Color? backgroundColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      action: SnackBarAction(
        label: 'حسناً',
        textColor: LightAppColors.grey0,
        onPressed: () {},
      ),
      backgroundColor: backgroundColor ?? LightAppColors.primary800,
      content: Text(
        message,
        style: AppTextStyles.font14SemiBold.copyWith(
          color: LightAppColors.grey0,
        ),
      ),
    ),
  );
}
