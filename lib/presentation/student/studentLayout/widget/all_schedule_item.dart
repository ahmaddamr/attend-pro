import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_colors.dart';

class AllScheduleItem extends StatelessWidget {
  const AllScheduleItem(
      {super.key,
      required this.start,
      required this.end,
      required this.subject,
      required this.groub,
      required this.room});
  final String start, end, subject, groub, room;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time Column
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

          // Schedule Card
          Expanded(
            child: Container(
              height: 130.h,
              padding: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                color: AppColors.color1,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontSize: 22.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    groub,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontSize: 22.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    'Room: $room',
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontSize: 22.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(height: 5.h),

                  // if (room.isNotEmpty)
                  //   Text(
                  //     room,
                  //     style: GoogleFonts.montserrat(
                  //       textStyle:
                  //           TextStyle(fontSize: 14.sp, color: Colors.white),
                  //     ),
                  //   ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
