// ignore_for_file: library_private_types_in_public_api
import 'package:attend_pro/core/app_colors.dart';
import 'package:attend_pro/presentation/student/studentLayout/widget/all_schedule_item.dart';
import 'package:attend_pro/presentation/student/studentLayout/widget/my_schedule_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorFullSheduleScreen extends StatefulWidget {
  const DoctorFullSheduleScreen({super.key});

  @override
  _DoctorFullSheduleScreenState createState() =>
      _DoctorFullSheduleScreenState();
}

class _DoctorFullSheduleScreenState extends State<DoctorFullSheduleScreen> {
  int _selectedDayIndex = 3; // Default selected day (Tuesday)
  bool isAllScedule = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          isAllScedule ? 'yoursc'.tr() : 'allsc'.tr(),
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              width: 160.w,
              height: 48.h,
              child: ElevatedButton(
                onPressed: () {
                  isAllScedule = !isAllScedule;
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.color1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: Text(
                  isAllScedule ? 'allsc'.tr() : 'mysc'.tr(),
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Horizontal Date Selector
            SizedBox(
              height: 60.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDayIndex = index;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Column(
                        children: [
                          Text(
                            [
                              'Sat',
                              'Sun',
                              'Mon',
                              'Tue',
                              'Wed',
                              'Thu',
                              'Fri'
                            ][index],
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: _selectedDayIndex == index
                                    ? AppColors.color2
                                    : AppColors.color1,
                              ),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          SizedBox(height: 5.h),
                          Container(
                            width: 25,
                            height: 5,
                            color: _selectedDayIndex == index
                                ? AppColors.color2
                                : AppColors.color1,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10.h),

            // Schedule List
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  if (!isAllScedule) {
                    return const AllScheduleItem(
                        start: '11:00',
                        end: "12:00",
                        subject: 'netwrok',
                        groub: '6',
                        room: '210');
                  } else {
                    return const MyScheduleItem(
                        startTime: '11:00',
                        endTime: '12:00',
                        title: 'Network',
                        instructor: 'Dr Ahmed',
                        room: '210',
                        color: AppColors.color1);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
