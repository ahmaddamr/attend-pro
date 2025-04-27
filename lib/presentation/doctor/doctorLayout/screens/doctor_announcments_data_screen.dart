import 'dart:developer';

import 'package:attend_pro/presentation/manager/cubit/announcements_cubit/announcements_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/theme/apptheme.dart';
import '../../../manager/provider/main_provider.dart';

class DoctorAnnouncmentsDataScreen extends StatelessWidget {
  const DoctorAnnouncmentsDataScreen({super.key, required this.groupId});
  final String groupId;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MainProvider>(context);
    bool isDark = provider.themeData == AppTheme().darkTheme;

    return BlocProvider(
      create: (context) => AnnouncementsCubit()..getGroupAnnouncements(groupId),
      child: BlocConsumer<AnnouncementsCubit, AnnouncementsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AnnouncementsCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'announcements'.tr(),
                style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(8.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await cubit.getGroupAnnouncements(groupId);
                      },
                      child: Builder(
                        builder: (context) {
                          if (state is GetAnnouncementsLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is GetAnnouncementsFailure) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Error: ${state.msg}',
                                      style:
                                          const TextStyle(color: Colors.red)),
                                  SizedBox(height: 20.h),
                                  ElevatedButton(
                                    onPressed: () {
                                      cubit.getGroupAnnouncements(groupId);
                                    },
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            );
                          } else if (state is GetAnnouncementsSuccess) {
                            if (cubit.announcements.isEmpty) {
                              return const Center(
                                  child: Text('No announcements available'));
                            }
                            return ListView.builder(
                              itemCount: cubit.announcements.length,
                              itemBuilder: (context, index) {
                                final announcement = cubit.announcements[index];
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.sp),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 25.r,
                                            backgroundColor: AppColors.color2,
                                            child: const Icon(Icons.person),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.sp),
                                            child: Text(
                                              'Dr: ${announcement.createdBy.staffName}',
                                              style: GoogleFonts.montserrat(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            DateFormat('yyyy-MM-dd')
                                                .format(announcement.createdAt),
                                            style: GoogleFonts.montserrat(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                          ),
                                          PopupMenuButton<String>(
                                            onSelected: (value) {
                                              if (value == "Delete") {
                                                log('Delete');
                                              }
                                            },
                                            itemBuilder: (context) => [
                                              const PopupMenuItem(
                                                value: "Delete",
                                                child: Text("Delete"),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 50.sp, bottom: 10.sp),
                                      child: IntrinsicHeight(
                                        child: Container(
                                          width: double.infinity,
                                          constraints: BoxConstraints(
                                            maxWidth: 350.w,
                                            minHeight: 80.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isDark
                                                ? const Color(0xff515151)
                                                : const Color(0xffD7D7D7),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topRight: Radius.circular(40),
                                              bottomRight: Radius.circular(40),
                                              bottomLeft: Radius.circular(40),
                                            ),
                                            boxShadow: const [
                                              BoxShadow(
                                                spreadRadius: 0.1,
                                                blurRadius: 3,
                                              )
                                            ],
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.sp),
                                              child: Text(
                                                announcement.content,
                                                style: GoogleFonts.montserrat(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                          color: isDark
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                                softWrap: true,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            return const Center(
                                child: Text('No announcements available'));
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
