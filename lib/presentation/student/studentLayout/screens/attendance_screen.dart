import 'package:attend_pro/main.dart';
import 'package:attend_pro/presentation/manager/cubit/attendance_cubit/attendance_cubit.dart';
import 'package:attend_pro/presentation/manager/cubit/attendance_cubit/attendance_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

import '../widget/attendace_item.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentId = prefs.getString('studentId');

    if (studentId == null) {
      return const Scaffold(
        body: Center(child: Text('No student ID found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'attendance'.tr(),
          style: GoogleFonts.montserrat(
            textStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => AttendanceCubit()..getStudentAttendance(studentId),
        child: BlocConsumer<AttendanceCubit, AttendanceState>(
          listener: (context, state) {
            if (state is StudentAttendanceFailure) {
              toastification.show(
                context: context,
                type: ToastificationType.error,
                style: ToastificationStyle.flat,
                autoCloseDuration: const Duration(seconds: 5),
                title: Text(state.msg),
              );
            }
          },
          builder: (context, state) {
            var cubit = AttendanceCubit.get(context);
            if (state is StudentAttendanceLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StudentAttendanceSuccess) {
              return ListView.builder(
                padding: EdgeInsets.all(16.sp),
                itemCount: cubit.attendance.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: AttendaceItem(
                      txt: cubit.attendance[index].subjecta.name,
                      date:
                          cubit.attendance[index].sessionDate.substring(0, 10),
                      status: cubit.attendance[index]
                          .status, // Replace with actual date if available
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text("Something went wrong."));
            }
          },
        ),
      ),
    );
  }
}
