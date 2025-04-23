import 'package:attend_pro/core/app_colors.dart';
import 'package:attend_pro/core/widgets/custom_elevatedButton.dart';
import 'package:attend_pro/presentation/manager/cubit/attendance_cubit/attendance_cubit.dart';
import 'package:attend_pro/presentation/manager/cubit/attendance_cubit/attendance_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';
import '../../widgets/purple_data_log_item.dart';
import '../../widgets/student_data_item.dart';

class AttendanceLogsDataScreen extends StatefulWidget {
  const AttendanceLogsDataScreen({super.key, required this.id});
  final String id;

  @override
  State<AttendanceLogsDataScreen> createState() =>
      _AttendanceLogsDataScreenState();
}

class _AttendanceLogsDataScreenState extends State<AttendanceLogsDataScreen> {
  late AttendanceCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = AttendanceCubit();
    cubit.getGroupAttendance(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
      body: BlocProvider(
        create: (context) => cubit,
        child: BlocConsumer<AttendanceCubit, AttendanceState>(
          listener: (context, state) {
            if (state is AttendanceError) {
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
            if (state is AttendanceLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is AttendanceSuccess) {
              return cubit.data.isEmpty
                  ? const Center(
                      child: Text(
                      'No attendance logs yet.',
                      style: TextStyle(color: AppColors.color1),
                    ))
                  : ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: cubit.data.length,
                      itemBuilder: (context, index) {
                        final week = cubit.data[index];

                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Week ${week.weekNumber ?? 'No Week Number'}',
                                    style: GoogleFonts.montserrat(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Text(
                                    week.records.isNotEmpty
                                        ? week.records.first.createdAt
                                            .toString()
                                        : 'Unknown Date',
                                    style: GoogleFonts.montserrat(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const PurpleDataLogItem(
                                status: 'Status',
                              ),
                              const SizedBox(height: 8),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: week.records.length,
                                itemBuilder: (context, subindex) {
                                  final record = week.records[subindex];
                                  return StudentDataItem(
                                    id: record.student.studentId ?? 'No Id',
                                    name:
                                        record.student.studentName ?? 'No Name',
                                    status: week.records.isNotEmpty
                                        ? week.records.first.status ??
                                            'No Status'
                                        : 'No Status',
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'See More',
                                    style: GoogleFonts.montserrat(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: 145.w,
                                child: CustomElvatedButton(
                                  text: 'Save As Pdf',
                                  backgroundColor: AppColors.color1,
                                  borderSideColor: Colors.transparent,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                  onPressed: () {
                                    // Save PDF logic here
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
            }
            return const Center(child: Text('No data loaded.'));
          },
        ),
      ),
    );
  }
}
