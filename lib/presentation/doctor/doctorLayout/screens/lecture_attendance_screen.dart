import 'package:attend_pro/presentation/doctor/doctorLayout/widgets/purple_data_log_item.dart';
import 'package:attend_pro/presentation/doctor/doctorLayout/widgets/student_check_in_data_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/widgets/custom_elevatedButton.dart';

class LectureAttendanceScreen extends StatelessWidget {
  const LectureAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 80.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Attendance',
                  style: GoogleFonts.montserrat(
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
                  ),
                ),
                Text(
                  '1/1/2025',
                  style: GoogleFonts.montserrat(
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            const PurpleDataLogItem(status: 'Time'),

            /// **Make ListView.builder scrollable inside SingleChildScrollView**
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true, // Allow ListView to fit inside ScrollView
              physics:
                  const NeverScrollableScrollPhysics(), // Prevent nested scrolling
              itemCount: 7,
              itemBuilder: (context, index) {
                return StudentCheckInDataItem(
                    id: '42021106',
                    name: 'Ahmed Mohamed',
                    status: '10:00',
                    bColor: index % 2 == 0 ? AppColors.color2 : null);
              },
            ),

            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Pending List',
                  style: GoogleFonts.montserrat(
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
                  ),
                ),
                Text(
                  '1/1/2025',
                  style: GoogleFonts.montserrat(
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            const PurpleDataLogItem(status: 'Time'),

            /// **Second ListView.builder (Pending List)**
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return StudentCheckInDataItem(
                  id: '42021106',
                  name: 'Ahmed Mohamed',
                  status: '10:00',
                  bColor: index % 2 == 0 ? AppColors.color2 : null,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomElvatedButton(
                      text: 'Reject',
                      backgroundColor: AppColors.color5,
                      borderSideColor: Colors.transparent,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: CustomElvatedButton(
                      text: 'Accept',
                      backgroundColor: AppColors.color1,
                      borderSideColor: Colors.transparent,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
