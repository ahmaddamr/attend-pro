import 'package:attend_pro/core/app_colors.dart';
import 'package:attend_pro/core/theme/apptheme.dart';
import 'package:attend_pro/presentation/manager/cubit/announcements_cubit/announcements_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../manager/provider/main_provider.dart';

class AnnouncmentsScreen extends StatelessWidget {
  const AnnouncmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MainProvider>(context);
    bool isDark = provider.themeData == AppTheme().darkTheme;

    return BlocProvider(
      create: (context) => AnnouncementsCubit()..getStudentAnnouncements(),
      child: BlocConsumer<AnnouncementsCubit, AnnouncementsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AnnouncementsCubit.get(context);

          return Scaffold(
            body: Padding(
              padding: EdgeInsets.all(20.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'announcements'.tr(),
                    style: GoogleFonts.montserrat(
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(
                              fontSize: 24.sp, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: _buildContent(context, state, cubit, isDark),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, AnnouncementsState state,
      AnnouncementsCubit cubit, bool isDark) {
    if (state is GetAnnouncementsLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is GetAnnouncementsFailure) {
      return const Center(child: Text('Something went wrong. Try again.'));
    } else if (cubit.announcements.isEmpty) {
      return const Center(child: Text('No announcements found.'));
    } else {
      return ListView.builder(
        itemCount: cubit.announcements.length,
        itemBuilder: (context, index) {
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
                        'Dr: ${cubit.announcements[index].createdBy.staffName}',
                        style: GoogleFonts.montserrat(
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontSize: 16.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 50.sp, bottom: 10.sp),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.sp),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xff515151)
                        : const Color(0xffD7D7D7),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        spreadRadius: 0.1,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Text(
                    cubit.announcements[index].content,
                    style: GoogleFonts.montserrat(
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(
                              color: isDark ? Colors.white : Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      );
    }
  }
}
