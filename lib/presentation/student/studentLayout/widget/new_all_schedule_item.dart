import 'package:attend_pro/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NewAllScheduleItem extends StatelessWidget {
  const NewAllScheduleItem(
      {super.key, required this.start, required this.end, required this.list});
  final String start, end;
  final Widget list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                start,
                style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w700),
                ),
              ),
              // SizedBox(height: 50.h),
              Text(
                end,
                style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          SizedBox(width: 15.w),
          // Vertical Line & Dot
          Column(
            children: [
              Container(
                width: 20.w,
                height: 15.h,
                decoration: BoxDecoration(
                  color: AppColors.color2,
                  borderRadius: BorderRadius.circular(160),
                ),
              ),
              Container(width: 2.w, height: 35.h, color: AppColors.color2),
              Container(width: 2.w, height: 80.h, color: AppColors.color2),
            ],
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Container(
              height: 130.h,
              padding: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                color: AppColors.color1,
                borderRadius: BorderRadius.circular(12),
              ),
              child: list,
            ),
          )
        ],
      ),
    );
  }
}
