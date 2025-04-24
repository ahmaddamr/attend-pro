import 'dart:developer';
import 'package:attend_pro/core/app_colors.dart';
import 'package:attend_pro/core/widgets/custom_elevatedButton.dart';
import 'package:attend_pro/presentation/doctor/doctorLayout/screens/lecture_attendance_screen.dart';
import 'package:attend_pro/presentation/doctor/doctorLayout/widgets/purple_data_log_item.dart';
import 'package:attend_pro/presentation/doctor/doctorLayout/widgets/student_check_in_data_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

import '../widgets/socket_io.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen(
      {super.key, required this.id, required this.date, required this.type});
  final String id, date, type;

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  final List<Map<String, dynamic>> students = [];
  late SocketService socketService;

  @override
  void initState() {
    super.initState();
    socketService = SocketService();

    socketService.connectAndJoinSession(widget.id, (data) {
      log("📥 Received data: $data");

      setState(() {
        students.add({
          'id': data['student']['student_id'],
          'name': data['student']['fullName'],
          'status': data['checkInTime'],
        });
      });
    });
  }

  @override
  void dispose() {
    socketService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100.h),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(width: 15.w),
                Expanded(
                  child: CustomElvatedButton(
                    text: 'End Check-In',
                    backgroundColor: AppColors.color5,
                    borderSideColor: Colors.transparent,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                    onPressed: () {
                      socketService.disconnect(); // Optional cleanup
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          const PurpleDataLogItem(status: 'Time'),
          SizedBox(
            height: 450.h,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return StudentCheckInDataItem(
                  id: student['id'],
                  name: student['name'],
                  status: student['status'],
                  bColor: index % 2 == 0 ? AppColors.color2 : null,
                );
              },
            ),
          ),
          Expanded(
            child: CustomElvatedButton(
              text: 'Start Check-Out',
              backgroundColor: AppColors.color1,
              borderSideColor: Colors.transparent,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: LectureAttendanceScreen(
                      id: widget.id,
                      date: widget.date,
                      type: widget.type,
                    ),
                    type: PageTransitionType.theme,
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
