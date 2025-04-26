// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:developer';
import 'package:attend_pro/core/app_colors.dart';
import 'package:attend_pro/core/widgets/custom_elevatedButton.dart';
import 'package:attend_pro/presentation/doctor/doctorLayout/screens/lecture_attendance_screen.dart';
import 'package:attend_pro/presentation/doctor/doctorLayout/widgets/purple_data_log_item.dart';
import 'package:attend_pro/presentation/doctor/doctorLayout/widgets/student_check_in_data_item.dart';
import 'package:attend_pro/presentation/manager/cubit/halls_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toastification/toastification.dart';
import '../widgets/socket_io.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen(
      {super.key,
      required this.id,
      required this.date,
      required this.type,
      required this.hallId});
  final String id, date, type, hallId;

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  final List<Map<String, dynamic>> students = [];
  late SocketService socketService;
  String? sessionDate;

  @override
  void initState() {
    super.initState();
    socketService = SocketService();

    socketService.connectAndJoinSession(widget.id, (data) {
      log("📥 Received data: $data");
      sessionDate = data['sessionDate'];
      log(" date is${data['sessionDate']}");

      setState(() {
        students.add({
          'id': data['student']['student_id'],
          'name': data['student']['fullName'],
          'status': data['status'],
        });
      });
    });
  }
// Student Checked In: {_id: 680bc6de910fd76dd95b4b8c, student: {_id: 68066cb854b21fa07747d62d, fullName: ahmed amr, student_id: 42021106}, status: checked-in, checkInTime: 2025-04-25T17:48:46.596Z, sessionDate: 2025-04-25T00:00:00.000Z}
// [log] 📥 Received data: {_id: 680bc6de910fd76dd95b4b8c, student: {_id: 68066cb854b21fa07747d62d, fullName: ahmed amr, student_id: 42021106}, status: checked-in, checkInTime: 2025-04-25T17:48:46.596Z, sessionDate: 2025-04-25T00:00:00.000Z}

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
          BlocProvider(
            create: (context) => HallsCubit(),
            child: BlocConsumer<HallsCubit, HallsState>(
              listener: (context, state) {
                if (state is EndCheckSuccess) {
                  toastification.show(
                    context:
                        context, // optional if you use ToastificationWrapper
                    type: ToastificationType.success,
                    style: ToastificationStyle.flat,
                    autoCloseDuration: const Duration(seconds: 5),
                    title: const Text('Check-In End Success!'),
                  );
                  // أو أي اجراء آخر (navigate, etc)
                } else if (state is EndCheckFailure) {
                  toastification.show(
                    context:
                        context, // optional if you use ToastificationWrapper
                    type: ToastificationType.error,
                    style: ToastificationStyle.flat,
                    autoCloseDuration: const Duration(seconds: 5),
                    title: const Text('check in Error!'),
                  );
                }
              },
              builder: (context, state) {
                var endCubit = HallsCubit.get(context);

                // هنا الإخفاء لو الحالة نجاح
                if (state is EndCheckSuccess) {
                  return const SizedBox.shrink();
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(width: 15.w),
                      Expanded(
                        child: CustomElvatedButton(
                          text: 'End Check-In',
                          backgroundColor: AppColors.color5,
                          borderSideColor: Colors.transparent,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                          onPressed: state is! EndCheckLoading
                              ? () {
                                  endCubit.endCheck(widget.hallId);
                                  // socketService.disconnect();
                                }
                              : null, // لو loading خلى الزرار disabled
                        ),
                      ),
                      if (state is EndCheckLoading)
                        const Padding(
                          padding: EdgeInsets.only(left: 12.0),
                          child: SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10.h),
          const PurpleDataLogItem(status: 'Status'),
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
          BlocProvider(
            create: (context) => HallsCubit(),
            child: BlocConsumer<HallsCubit, HallsState>(
              listener: (context, state) {
                if (state is StartCheckOutSuccess) {
                  toastification.show(
                    context: context,
                    type: ToastificationType.success,
                    style: ToastificationStyle.flat,
                    autoCloseDuration: const Duration(seconds: 5),
                    title: const Text('Check-Out Started Successfully!'),
                  );
                } else if (state is StartCheckOutFailure) {
                  toastification.show(
                    context: context,
                    type: ToastificationType.error,
                    style: ToastificationStyle.flat,
                    autoCloseDuration: const Duration(seconds: 5),
                    title: const Text('Please End check-in First'),
                  );
                } else if (state is EndCheckOutSuccess) {
                  toastification.show(
                    context: context,
                    type: ToastificationType.success,
                    style: ToastificationStyle.flat,
                    autoCloseDuration: const Duration(seconds: 5),
                    title: const Text('Ended CheckOut Successfully!'),
                  );
                  Navigator.push(
                    context,
                    PageTransition(
                      child: LectureAttendanceScreen(
                        id: widget.id,
                        date: widget.date,
                        type: widget.type,
                        time: sessionDate??'',
                      ),
                      type: PageTransitionType.theme,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                } else if (state is EndCheckOutFailure) {
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
                var cubit = HallsCubit.get(context);

                // شرط خاص لإظهار زر End Check-Out فقط بعد نجاح Start Check-Out
                if (state is StartCheckOutSuccess ||
                    state is EndCheckOutLoading ||
                    state is EndCheckOutFailure) {
                  return CustomElvatedButton(
                    text: (state is EndCheckOutLoading)
                        ? 'Ending...'
                        : 'End Check-Out',
                    backgroundColor: AppColors.color1,
                    borderSideColor: Colors.transparent,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                    onPressed: (state is EndCheckOutLoading)
                        ? null
                        : () {
                            cubit.endCheckOut(widget.hallId);
                          },
                  );
                }

                // زر Start Check-Out يظهر اذا لم يتم start أو بعد نجاح End أو أول مرة
                return CustomElvatedButton(
                  text: (state is StartCheckOutLoading)
                      ? "Starting..."
                      : 'Start Check-Out',
                  backgroundColor: AppColors.color1,
                  borderSideColor: Colors.transparent,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                  onPressed: (state is StartCheckOutLoading)
                      ? null
                      : () {
                          cubit.startCheckOut(widget.hallId);
                        },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
