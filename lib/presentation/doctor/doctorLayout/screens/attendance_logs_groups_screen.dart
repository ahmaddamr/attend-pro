import 'package:attend_pro/presentation/doctor/doctorLayout/widgets/attendance_logs_group_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'attendance_logs_data_screen.dart';

class AttendanceLogsGroupsScreen extends StatelessWidget {
  const AttendanceLogsGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        title: Text(
          'logs'.tr(),
          style: GoogleFonts.montserrat(
            textStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: GridView.builder(
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 10.h, crossAxisSpacing: 10.w),
        padding: EdgeInsets.all(10.sp),
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () => Navigator.push(
                    context,
                    PageTransition(
                      child: const AttendanceLogsDataScreen(),
                      type: PageTransitionType.theme,
                      duration: const Duration(seconds: 1),
                    ),
                  ),
              child: const AttendanceLogsGroupItem(gNum: '5'));
        },
      ),
    );
  }
}
