
import 'package:attend_pro/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHomeContainer extends StatelessWidget {
  const CustomHomeContainer({
    super.key, this.child,
  });
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400.w,
      height: 155.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.color2),
      ),
      child: child,
    );
  }
}
