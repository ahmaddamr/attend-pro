import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_colors.dart';

class AttendanceLogsItem extends StatelessWidget {
  const AttendanceLogsItem(
      {super.key, required this.subject, required this.groupNum});
  final String subject, groupNum;
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
              subject,
              style: GoogleFonts.montserrat(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Group: $groupNum',
                style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
