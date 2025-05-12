import 'package:attend_pro/presentation/doctor/doctorLayout/screens/doctor_layout_screen.dart';
import 'package:attend_pro/presentation/manager/cubit/attendance_cubit/attendance_cubit.dart';
import 'package:attend_pro/presentation/manager/cubit/attendance_cubit/attendance_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/widgets/custom_elevatedButton.dart';
import '../../doctorLayout/widgets/purple_data_log_item.dart';
import '../../doctorLayout/widgets/student_check_in_data_item.dart';

class LectureAttendanceScreen extends StatelessWidget {
  const LectureAttendanceScreen({
    super.key,
    required this.id,
    required this.date,
    required this.type,
    required this.time,
  });

  final String id, date, type, time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => AttendanceCubit()..getSessionData(id, time, type),
        child: BlocBuilder<AttendanceCubit, AttendanceState>(
          builder: (context, state) {
            if (state is SessionDataLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SessionDataFailure) {
              return Center(
                  child: Text(
                'Error: ${state.msg} ',
                style: const TextStyle(color: AppColors.color1),
              ));
            } else if (state is SessionDataSuccess) {
              final cubit = context.read<AttendanceCubit>();
              final model = cubit.lectureAttendanceModel!;
              final attended = model.data.attended;
              final pending = model.data.pending;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 80.h),
                    _buildTitle('Attendance', date, context),
                    SizedBox(height: 10.h),
                    const PurpleDataLogItem(status: 'Time'),

                    /// Attended List
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: attended.length,
                      itemBuilder: (context, index) {
                        final item = attended[index];
                        return StudentCheckInDataItem(
                          id: item.student.studentId,
                          name: item.student.studentName,
                          status:
                              item.checkInTime.split('T').last.split('.').first,
                          bColor: index % 2 == 0 ? AppColors.color2 : null,
                        );
                      },
                    ),

                    SizedBox(height: 25.h),
                    _buildTitle('Pending List', date, context),
                    SizedBox(height: 10.h),
                    const PurpleDataLogItem(status: 'Time'),

                    /// Pending List
                    /// Pending List with fixed height
                    SizedBox(
                      height: 300.h, // غيّر هذا الرقم حسب ما يناسبك
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: pending.length,
                        itemBuilder: (context, index) {
                          final item = pending[index];
                          return StudentCheckInDataItem(
                            border: AppColors.color5,
                            id: item.student.studentId,
                            name: item.student.studentName,
                            status: item.checkInTime
                                .split('T')
                                .last
                                .split('.')
                                .first,
                            bColor: index % 2 == 0 ? AppColors.color2 : null,
                          );
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomElvatedButton(
                              text: 'Reject Pending',
                              backgroundColor: AppColors.color5,
                              borderSideColor: Colors.transparent,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const DoctorLayoutScreen(),
                                  ),
                                  (route) => false,
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: CustomElvatedButton(
                              text: 'Accept Pending',
                              backgroundColor: AppColors.color1,
                              borderSideColor: Colors.transparent,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const DoctorLayoutScreen(),
                                  ),
                                  (route) => false,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomElvatedButton(
                      text: 'Return Home',
                      backgroundColor: AppColors.color1,
                      borderSideColor: Colors.transparent,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DoctorLayoutScreen(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Row _buildTitle(String title, String date, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
            textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        Text(
          date,
          style: GoogleFonts.montserrat(
            textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ],
    );
  }
}
