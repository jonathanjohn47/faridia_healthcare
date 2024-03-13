import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../core/app_colors.dart';

class StandardButton extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final IconData? icon;

  const StandardButton(
      {super.key, required this.onPressed, required this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary.shade200,
          foregroundColor: AppColors.secondary,
          elevation: 1.h),
      onPressed: onPressed,
      child: icon == null
          ? Text(title)
          : Row(
              children: [
                Icon(icon),
                SizedBox(
                  width: 5.sp,
                ),
                Text(title)
              ],
            ),
    );
  }
}
