import 'dart:developer';

import 'package:attend_pro/core/app_colors.dart';
import 'package:attend_pro/presentation/doctor/doctorLayout/screens/doctor_announcments_data_screen.dart';
import 'package:attend_pro/presentation/doctor/doctorLayout/widgets/attendance_logs_group_item.dart';
import 'package:attend_pro/presentation/manager/cubit/announcements_cubit/announcements_cubit.dart';
import 'package:attend_pro/presentation/manager/cubit/groups_cubit/groups_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toastification/toastification.dart';

class ChooseAnnounceGroupScreen extends StatelessWidget {
  const ChooseAnnounceGroupScreen({
    super.key,
    required this.id,
    required this.announcementText,
  });

  final String id, announcementText;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AnnouncementsCubit()),
        BlocProvider(create: (context) => GroupsCubit()..getGroups(id)),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Choose Group'.tr(),
            style: GoogleFonts.montserrat(
              textStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        body: BlocListener<AnnouncementsCubit, AnnouncementsState>(
          listener: (context, state) {
            if (state is AnnouncementsLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
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
            if (state is AnnouncementsSuccess) {
              Navigator.pop(context); // Close the loading dialog
              toastification.show(
                context: context,
                type: ToastificationType.success,
                style: ToastificationStyle.flat,
                autoCloseDuration: const Duration(seconds: 3),
                title: Text('Announcement sent successfully!'),
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return DoctorAnnouncmentsDataScreen();
                  },
                ),
              );
              // Navigator.pop(context); // Close ChooseAnnounceGroupScreen
            }
            if (state is AnnouncementsFailure) {
              Navigator.pop(context); // Close the loading dialog
              toastification.show(
                context: context,
                type: ToastificationType.error,
                style: ToastificationStyle.flat,
                autoCloseDuration: const Duration(seconds: 5),
                title: Text(state.msg),
              );
            }
          },
          child: BlocBuilder<GroupsCubit, GroupsState>(
            builder: (context, state) {
              var groupsCubit = GroupsCubit.get(context);

              if (state is GroupsLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.color1),
                );
              }

              if (state is GroupsFailure) {
                return Center(
                  child: Text(
                    'Failed to load groups',
                    style: TextStyle(color: Colors.red, fontSize: 18.sp),
                  ),
                );
              }

              return GridView.builder(
                itemCount: groupsCubit.groups.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.w,
                ),
                padding: EdgeInsets.all(10.sp),
                itemBuilder: (context, index) {
                  final group = groupsCubit.groups[index];
                  return InkWell(
                    onTap: () {
                      AnnouncementsCubit.get(context).createAnnouncement(
                        content: announcementText,
                        groupId: group.id,
                        subjectId: id,
                      );
                    },
                    child: AttendanceLogsGroupItem(gNum: group.name),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
