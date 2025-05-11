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
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toastification/toastification.dart';
import '../widgets/socket_io.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({
    super.key,
    required this.id,
    required this.date,
    required this.type,
    required this.hallId,
  });

  final String id, date, type, hallId;

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  final List<Map<String, dynamic>> students = [];
  late SocketService socketService;
  String? sessionDate;

  bool isCheckInEnded = false;
  bool showStartCheckInButton = false;

  @override
  void initState() {
    super.initState();
    socketService = SocketService();

    socketService.connectAndJoinSession(
      widget.id,
      (data) {
        log("📥 Received check-in data: $data");
        sessionDate = data['sessionDate'];

        final existingIndex = students
            .indexWhere((s) => s['id'] == data['student']['student_id']);
        final newEntry = {
          'id': data['student']['student_id'],
          'name': data['student']['fullName'],
          'status': data['status'],
        };

        setState(() {
          if (existingIndex != -1) {
            students[existingIndex] = newEntry;
          } else {
            students.add(newEntry);
          }
        });
      },
      (data) {
        log("📤 Received check-out data: $data");

        final index = students
            .indexWhere((s) => s['id'] == data['student']['student_id']);
        if (index != -1) {
          setState(() {
            students[index]['status'] = data['status'];
          });
        } else {
          setState(() {
            students.add({
              'id': data['student']['student_id'],
              'name': data['student']['fullName'],
              'status': data['status'],
            });
          });
        }
      },
    );
  }

  @override
  void dispose() {
    socketService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HallsCubit(),
      child: BlocConsumer<HallsCubit, HallsState>(
        listener: (context, state) {
          if (state is EndCheckSuccess) {
            setState(() {
              isCheckInEnded = true; // Allowing Check-Out to start
              showStartCheckInButton = true;
            });
            toastification.show(
              context: context,
              type: ToastificationType.success,
              title: const Text('Check-In End Success!'),
            );
          } else if (state is EndCheckFailure) {
            toastification.show(
              context: context,
              type: ToastificationType.error,
              title: const Text('Check-In Error!'),
            );
          } else if (state is StartCheckOutSuccess) {
            toastification.show(
              context: context,
              type: ToastificationType.success,
              title: const Text('Check-Out Started Successfully!'),
            );
          } else if (state is StartCheckOutFailure) {
            toastification.show(
              context: context,
              type: ToastificationType.error,
              title: const Text('Please End Check-In First'),
            );
          } else if (state is EndCheckOutSuccess) {
            toastification.show(
              context: context,
              type: ToastificationType.success,
              title: const Text('Ended Check-Out Successfully!'),
            );
            Navigator.push(
              context,
              PageTransition(
                child: LectureAttendanceScreen(
                  id: widget.id,
                  date: widget.date,
                  type: widget.type,
                  time: sessionDate ??
                      DateFormat('yyyy-MM-dd').format(DateTime.now()),
                ),
                type: PageTransitionType.theme,
                duration: const Duration(seconds: 1),
              ),
            );
          } else if (state is EndCheckOutFailure) {
            toastification.show(
              context: context,
              type: ToastificationType.error,
              title: Text(state.msg),
            );
          }
        },
        builder: (context, state) {
          final cubit = HallsCubit.get(context);
          return Scaffold(
            body: Column(
              children: [
                SizedBox(height: 100.h),

                /// End Check-In Button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(width: 15.w),
                      Expanded(
                        child: CustomElvatedButton(
                          text: (state is EndCheckLoading)
                              ? "Ending..."
                              : 'End Check-In',
                          backgroundColor: AppColors.color5,
                          borderSideColor: Colors.transparent,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                          onPressed:
                              (!isCheckInEnded && state is! EndCheckLoading)
                                  ? () => cubit.endCheck(widget.hallId)
                                  : null,
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

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                  child: Column(
                    children: [
                      if (!isCheckInEnded)
                        CustomElvatedButton(
                          text: 'Start Check-Out',
                          backgroundColor: AppColors.color1,
                          borderSideColor: Colors.transparent,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                          onPressed:
                              null, // Disable Start Check-Out until check-in ends
                        )
                      else
                        Column(
                          children: [
                            (state is StartCheckOutSuccess ||
                                    state is EndCheckOutLoading ||
                                    state is EndCheckOutFailure)
                                ? CustomElvatedButton(
                                    text: (state is EndCheckOutLoading)
                                        ? 'Ending...'
                                        : 'End Check-Out',
                                    backgroundColor: AppColors.color1,
                                    borderSideColor: Colors.transparent,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                    onPressed: (state is EndCheckOutLoading)
                                        ? null
                                        : () =>
                                            cubit.endCheckOut(widget.hallId),
                                  )
                                : CustomElvatedButton(
                                    text: (state is StartCheckOutLoading)
                                        ? "Starting..."
                                        : 'Start Check-Out',
                                    backgroundColor: AppColors.color1,
                                    borderSideColor: Colors.transparent,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                    onPressed: (state is StartCheckOutLoading)
                                        ? null
                                        : () =>
                                            cubit.startCheckOut(widget.hallId),
                                  ),
                            if (showStartCheckInButton) ...[
                              const SizedBox(height: 8),
                              CustomElvatedButton(
                                text: (state is StartCheckLoading)
                                    ? 'Starting...'
                                    : 'Rejoin Check-In',
                                backgroundColor: AppColors.color1,
                                borderSideColor: Colors.transparent,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                onPressed: (state is StartCheckLoading)
                                    ? null
                                    : () {
                                        cubit.startCheck(widget.hallId);
                                        setState(() {
                                          isCheckInEnded = false;
                                          showStartCheckInButton = false;
                                        });
                                      },
                              ),
                            ]
                          ],
                        ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

// // ignore_for_file: prefer_typing_uninitialized_variables
// import 'dart:developer';
// import 'package:attend_pro/core/app_colors.dart';
// import 'package:attend_pro/core/widgets/custom_elevatedButton.dart';
// import 'package:attend_pro/presentation/doctor/doctorLayout/screens/lecture_attendance_screen.dart';
// import 'package:attend_pro/presentation/doctor/doctorLayout/widgets/purple_data_log_item.dart';
// import 'package:attend_pro/presentation/doctor/doctorLayout/widgets/student_check_in_data_item.dart';
// import 'package:attend_pro/presentation/manager/cubit/halls_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:toastification/toastification.dart';
// import '../widgets/socket_io.dart';

// class CheckInScreen extends StatefulWidget {
//   const CheckInScreen(
//       {super.key,
//       required this.id,
//       required this.date,
//       required this.type,
//       required this.hallId});
//   final String id, date, type, hallId;

//   @override
//   State<CheckInScreen> createState() => _CheckInScreenState();
// }

// class _CheckInScreenState extends State<CheckInScreen> {
//   final List<Map<String, dynamic>> students = [];
//   late SocketService socketService;
//   String? sessionDate;

//   bool isCheckInEnded = false; // Track if End Check-In succeeded

//   @override
//   void initState() {
//     super.initState();
//     socketService = SocketService();

//     socketService.connectAndJoinSession(
//       widget.id,
//       (data) {
//         log("📥 Received check-in data: $data");
//         sessionDate = data['sessionDate'];

//         final existingIndex = students
//             .indexWhere((s) => s['id'] == data['student']['student_id']);
//         final newEntry = {
//           'id': data['student']['student_id'],
//           'name': data['student']['fullName'],
//           'status': data['status'], // should be 'checked-in'
//         };

//         setState(() {
//           if (existingIndex != -1) {
//             students[existingIndex] = newEntry;
//           } else {
//             students.add(newEntry);
//           }
//         });
//       },
//       (data) {
//         log("📤 Received check-out data: $data");

//         final index = students
//             .indexWhere((s) => s['id'] == data['student']['student_id']);
//         if (index != -1) {
//           setState(() {
//             students[index]['status'] = data['status']; // should be 'attended'
//           });
//         } else {
//           setState(() {
//             students.add({
//               'id': data['student']['student_id'],
//               'name': data['student']['fullName'],
//               'status': data['status'],
//             });
//           });
//         }
//       },
//     );
//   }

//   @override
//   void dispose() {
//     socketService.disconnect();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => HallsCubit(),
//       child: BlocConsumer<HallsCubit, HallsState>(
//         listener: (context, state) {
//           if (state is EndCheckSuccess) {
//             setState(() => isCheckInEnded = true);
//             toastification.show(
//               context: context,
//               type: ToastificationType.success,
//               style: ToastificationStyle.flat,
//               autoCloseDuration: const Duration(seconds: 5),
//               title: const Text('Check-In End Success!'),
//             );
//           } else if (state is EndCheckFailure) {
//             toastification.show(
//               context: context,
//               type: ToastificationType.error,
//               style: ToastificationStyle.flat,
//               autoCloseDuration: const Duration(seconds: 5),
//               title: const Text('check in Error!'),
//             );
//           } else if (state is StartCheckOutSuccess) {
//             toastification.show(
//               context: context,
//               type: ToastificationType.success,
//               style: ToastificationStyle.flat,
//               autoCloseDuration: const Duration(seconds: 5),
//               title: const Text('Check-Out Started Successfully!'),
//             );
//           } else if (state is StartCheckOutFailure) {
//             toastification.show(
//               context: context,
//               type: ToastificationType.error,
//               style: ToastificationStyle.flat,
//               autoCloseDuration: const Duration(seconds: 5),
//               title: const Text('Please End check-in First'),
//             );
//           } else if (state is EndCheckOutSuccess) {
//             toastification.show(
//               context: context,
//               type: ToastificationType.success,
//               style: ToastificationStyle.flat,
//               autoCloseDuration: const Duration(seconds: 5),
//               title: const Text('Ended CheckOut Successfully!'),
//             );
//             Navigator.push(
//               context,
//               PageTransition(
//                 child: LectureAttendanceScreen(
//                   id: widget.id,
//                   date: widget.date,
//                   type: widget.type,
//                   time: sessionDate ??
//                       DateFormat('yyyy-MM-dd').format(DateTime.now()),
//                 ),
//                 type: PageTransitionType.theme,
//                 duration: const Duration(seconds: 1),
//               ),
//             );
//           } else if (state is EndCheckOutFailure) {
//             toastification.show(
//               context: context,
//               type: ToastificationType.error,
//               style: ToastificationStyle.flat,
//               autoCloseDuration: const Duration(seconds: 5),
//               title: Text(state.msg),
//             );
//           }
//         },
//         builder: (context, state) {
//           final cubit = HallsCubit.get(context);
//           return Scaffold(
//             body: Column(
//               children: [
//                 SizedBox(height: 100.h),

//                 // --- END CHECK IN BUTTON ---
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       SizedBox(width: 15.w),
//                       Expanded(
//                         child: CustomElvatedButton(
//                           text: (state is EndCheckLoading)
//                               ? "Ending..."
//                               : 'End Check-In',
//                           backgroundColor: AppColors.color5,
//                           borderSideColor: Colors.transparent,
//                           style:
//                               Theme.of(context).textTheme.bodySmall!.copyWith(
//                                     fontSize: 20.sp,
//                                     fontWeight: FontWeight.w700,
//                                     color: Colors.white,
//                                   ),
//                           // Only allow pressed if not already ended & not loading
//                           onPressed:
//                               (!isCheckInEnded && state is! EndCheckLoading)
//                                   ? () {
//                                       cubit.endCheck(widget.hallId);
//                                     }
//                                   : null,
//                         ),
//                       ),
//                       if (state is EndCheckLoading)
//                         const Padding(
//                           padding: EdgeInsets.only(left: 12.0),
//                           child: SizedBox(
//                             width: 18,
//                             height: 18,
//                             child: CircularProgressIndicator(strokeWidth: 2),
//                           ),
//                         )
//                     ],
//                   ),
//                 ),

//                 SizedBox(height: 10.h),
//                 const PurpleDataLogItem(status: 'Status'),

//                 SizedBox(
//                   height: 450.h,
//                   child: ListView.builder(
//                     padding: EdgeInsets.zero,
//                     itemCount: students.length,
//                     itemBuilder: (context, index) {
//                       final student = students[index];
//                       return StudentCheckInDataItem(
//                         id: student['id'],
//                         name: student['name'],
//                         status: student['status'],
//                         bColor: index % 2 == 0 ? AppColors.color2 : null,
//                       );
//                     },
//                   ),
//                 ),

//                 // --- CHECK OUT BUTTONS CONTROLLED HERE ---
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
//                   child: Column(
//                     children: [
//                       if (!isCheckInEnded)
//                         // Both buttons disabled before End Check-In
//                         Column(
//                           children: [
//                             CustomElvatedButton(
//                               text: 'Start Check-Out',
//                               backgroundColor:
//                                   AppColors.color1.withOpacity(0.5),
//                               borderSideColor: Colors.transparent,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodySmall!
//                                   .copyWith(
//                                     fontSize: 20.sp,
//                                     fontWeight: FontWeight.w700,
//                                     color: Colors.white,
//                                   ),
//                               onPressed: null,
//                             ),
//                             const SizedBox(height: 8),
//                             CustomElvatedButton(
//                               text: 'End Check-Out',
//                               backgroundColor:
//                                   AppColors.color1.withOpacity(0.5),
//                               borderSideColor: Colors.transparent,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodySmall!
//                                   .copyWith(
//                                     fontSize: 20.sp,
//                                     fontWeight: FontWeight.w700,
//                                     color: Colors.white,
//                                   ),
//                               onPressed: null,
//                             ),
//                           ],
//                         )
//                       else
//                         // After End Check-In, normal check out logic
//                         (state is StartCheckOutSuccess ||
//                                 state is EndCheckOutLoading ||
//                                 state is EndCheckOutFailure)
//                             ? CustomElvatedButton(
//                                 text: (state is EndCheckOutLoading)
//                                     ? 'Ending...'
//                                     : 'End Check-Out',
//                                 backgroundColor: AppColors.color1,
//                                 borderSideColor: Colors.transparent,
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodySmall!
//                                     .copyWith(
//                                       fontSize: 20.sp,
//                                       fontWeight: FontWeight.w700,
//                                       color: Colors.white,
//                                     ),
//                                 onPressed: (state is EndCheckOutLoading)
//                                     ? null
//                                     : () => cubit.endCheckOut(widget.hallId),
//                               )
//                             : CustomElvatedButton(
//                                 text: (state is StartCheckOutLoading)
//                                     ? "Starting..."
//                                     : 'Start Check-Out',
//                                 backgroundColor: AppColors.color1,
//                                 borderSideColor: Colors.transparent,
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodySmall!
//                                     .copyWith(
//                                       fontSize: 20.sp,
//                                       fontWeight: FontWeight.w700,
//                                       color: Colors.white,
//                                     ),
//                                 onPressed: (state is StartCheckOutLoading)
//                                     ? null
//                                     : () => cubit.startCheckOut(widget.hallId),
//                               ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
