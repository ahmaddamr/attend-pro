

import 'package:attend_pro/presentation/doctor/doctorLayout/screens/attendanceLogs/attendance_logs_groups_screen.dart';
import 'package:attend_pro/presentation/doctor/doctorLayout/widgets/attendance_logs_item.dart';
import 'package:attend_pro/presentation/manager/cubit/subjects_cubit/subjects_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/app_colors.dart';

class AttendanceLogsScreen extends StatelessWidget {
  const AttendanceLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        create: (context) => SubjectsCubit()..getCourses(),
        child: BlocConsumer<SubjectsCubit, SubjectsState>(
          listener: (context, state) {
            if (state is CoursesFailure) {
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
            var cubit = SubjectsCubit.get(context);

            if (state is CoursesLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.color1,
                ),
              );
            }

            if (state is CoursesSuccess && cubit.courses.isEmpty) {
              return Center(
                child: Text(
                  "No courses available".tr(),
                  style: TextStyle(fontSize: 16.sp),
                ),
              );
            }

            return GridView.builder(
              itemCount: cubit.courses.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 10.w,
              ),
              padding: EdgeInsets.all(10.sp),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: AttendanceLogsGroupsScreen(
                          id: cubit.courses[index].id,
                          
                        ),
                        type: PageTransitionType.theme,
                        duration: const Duration(seconds: 1),
                      ),
                      
                    );
                  },
                  child: AttendanceLogsItem(
                    subject: cubit.courses[index].name,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
