import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_colors.dart';

class HallItem extends StatelessWidget {
  const HallItem({super.key, required this.hall, required this.status});
  final String hall, status;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7, // درجة الارتفاع (يمكنك تعديلها حسب الحاجة)
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      // color: AppColors.color1,
      child: Container(
        height: 105.h,
        width: 180.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.color2,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              hall,
              style: GoogleFonts.montserrat(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              status,
              style: GoogleFonts.montserrat(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }
}
