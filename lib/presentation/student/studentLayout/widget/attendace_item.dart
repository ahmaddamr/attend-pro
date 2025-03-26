import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/app_colors.dart';

class AttendaceItem extends StatelessWidget {
  const AttendaceItem({super.key, required this.txt, required this.date});
  final String txt, date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Container(
        width: 370.w,
        height: 80.h,
        decoration: BoxDecoration(
          color: AppColors.color2,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  txt,
                  style: GoogleFonts.montserrat(
                    textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                Text(
                  'Date: $date',
                  style: GoogleFonts.montserrat(
                    textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
              ],
            ),
            Image.asset('assets/images/icons/done.png')
          ],
        ),
      ),
    );
  }
}
