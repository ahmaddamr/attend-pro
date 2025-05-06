import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_colors.dart';

class SubjectItem extends StatelessWidget {
  const SubjectItem({
    super.key,
    required this.lectDay,
    required this.group,
    required this.lecTime,
    required this.lectRoom,
    required this.secDay,
    required this.eng,
    required this.secTime,
    required this.secRoom,
    required this.subject,
    required this.code,
  });

  final String subject,
      lectDay,
      group,
      lecTime,
      lectRoom,
      secDay,
      eng,
      secTime,
      code,
      secRoom;

  @override
  Widget build(BuildContext context) {
    final textStyle = GoogleFonts.montserrat(
      textStyle: Theme.of(context)
          .textTheme
          .bodySmall!
          .copyWith(fontSize: 17.sp, fontWeight: FontWeight.w400),
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.sp),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.color2, width: 2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subject,
              style: GoogleFonts.montserrat(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Code: $code', style: textStyle),
                      Text('Group: $group', style: textStyle),
                      Text('Lecture Day: $lectDay', style: textStyle),
                      Text('Time: $lecTime', style: textStyle),
                      Text('Room: $lectRoom', style: textStyle),
                    ],
                  ),
                ),

                /// Optional section part — still commented as requested
                // Padding(
                //   padding: EdgeInsets.all(8.sp),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text('Section Day: $secDay', style: textStyle),
                //       Text('Eng: $eng', style: textStyle),
                //       Text('Time: $secTime', style: textStyle),
                //       Text('Room: $secRoom', style: textStyle),
                //     ],
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
