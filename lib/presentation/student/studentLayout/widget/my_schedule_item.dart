import 'package:attend_pro/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyScheduleItem extends StatelessWidget {
  const MyScheduleItem(
      {super.key,
      required this.startTime,
      required this.endTime,
      required this.title,
      required this.instructor,
      required this.room,
      required this.color, required this.session});
  final String startTime, endTime, title, instructor, room,session;
  final Color color;
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
                startTime,
                style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w700),
                ),
              ),
              // SizedBox(height: 50.h),
              Text(
                endTime,
                style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey),
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
                  color: color,
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
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  // Text(
                  //   ' $instructor',
                  //   style: GoogleFonts.montserrat(
                  //     textStyle:
                  //         TextStyle(fontSize: 18.sp, color: Colors.white),
                  //   ),
                  // ),
                  if (room.isNotEmpty)
                    Text(
                      'Room: $room',
                      style: GoogleFonts.montserrat(
                        textStyle:
                            TextStyle(fontSize: 18.sp, color: Colors.white),
                      ),
                    ),
                    Text(
                      'Session: $session',
                      style: GoogleFonts.montserrat(
                        textStyle:
                            TextStyle(fontSize: 18.sp, color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
