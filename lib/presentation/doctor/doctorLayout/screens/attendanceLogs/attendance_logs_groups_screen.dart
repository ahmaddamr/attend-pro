import 'dart:developer';

import 'package:attend_pro/presentation/doctor/doctorLayout/widgets/attendance_logs_group_item.dart';
import 'package:attend_pro/presentation/manager/cubit/groups_cubit/groups_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toastification/toastification.dart';
import '../../../../../core/app_colors.dart';
import 'attendance_logs_data_screen.dart';

class AttendanceLogsGroupsScreen extends StatelessWidget {
  const AttendanceLogsGroupsScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    log('g Id is: $id');
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
      body: BlocProvider(
        create: (context) => GroupsCubit()..getGroups(id),
        child: BlocConsumer<GroupsCubit, GroupsState>(
          listener: (context, state) {
            if (state is GroupsLoading) {
              showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    content: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.color1,
                      ),
                    ),
                  );
                },
              );
            }
            if (state is GroupsSuccess) {}
            if (state is GroupsFailure) {
              Navigator.pop(context);
              toastification.show(
                context: context, // optional if you use ToastificationWrapper
                type: ToastificationType.error,
                style: ToastificationStyle.flat,
                autoCloseDuration: const Duration(seconds: 5),
                title: Text(state.msg),
              );
            }
          },
          builder: (context, state) {
            var cubit = GroupsCubit.get(context);
            return GridView.builder(
              itemCount: cubit.groups.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.w),
              padding: EdgeInsets.all(10.sp),
              itemBuilder: (context, index) {
                log('group id: ${cubit.groups[index].id}');
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    PageTransition(
                      child:  AttendanceLogsDataScreen(id: cubit.groups[index].id,),
                      type: PageTransitionType.theme,
                      duration: const Duration(seconds: 1),
                    ),
                  ),
                  child:
                      AttendanceLogsGroupItem(gNum: cubit.groups[index].name),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
