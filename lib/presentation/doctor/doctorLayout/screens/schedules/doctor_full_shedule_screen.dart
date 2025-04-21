// ignore_for_file: library_private_types_in_public_api

import 'package:attend_pro/core/app_colors.dart';
import 'package:attend_pro/data/models/my_schedule_model.dart';
import 'package:attend_pro/presentation/manager/cubit/schedules/schedules_cubit.dart';
import 'package:attend_pro/presentation/student/studentLayout/widget/all_schedule_item.dart';
import 'package:attend_pro/presentation/student/studentLayout/widget/my_schedule_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

class DoctorFullSheduleScreen extends StatefulWidget {
  const DoctorFullSheduleScreen({super.key});

  @override
  _DoctorFullSheduleScreenState createState() =>
      _DoctorFullSheduleScreenState();
}

class _DoctorFullSheduleScreenState extends State<DoctorFullSheduleScreen> {
  int _selectedDayIndex = 0;
  bool isAllScedule = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          isAllScedule ? 'allsc'.tr() : 'yoursc'.tr(),
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              width: 160.w,
              height: 48.h,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isAllScedule = !isAllScedule;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.color1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  isAllScedule ? 'mysc'.tr() : 'allsc'.tr(),
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => SchedulesCubit()
          ..getAllSchedules()
          ..getMySchedules(),
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: BlocConsumer<SchedulesCubit, SchedulesState>(
            listener: (context, state) {
              if (state is SchedulesFailure || state is MySchedulesFailure) {
                toastification.show(
                  context: context,
                  type: ToastificationType.error,
                  style: ToastificationStyle.flat,
                  autoCloseDuration: const Duration(seconds: 5),
                  title: Text(
                    state is SchedulesFailure
                        ? state.msg
                        : (state as MySchedulesFailure).msg,
                  ),
                );
              }
            },
            builder: (context, state) {
              var cubit = SchedulesCubit.get(context);

              if (state is SchedulesLoading || state is MySchedulesLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.color1),
                );
              }

              // Extract unique days from data
              final allDays = isAllScedule
                  ? cubit.schedules
                      .expand((group) => group.schedule.map((item) => item.day))
                      .toSet()
                      .toList()
                  : cubit.mySchedules.map((item) => item.day).toSet().toList();

              if (allDays.isEmpty) {
                return const Center(
                  child: Text(
                    "No schedules found!",
                    style: TextStyle(color: AppColors.color1),
                  ),
                );
              }

              _selectedDayIndex =
                  _selectedDayIndex.clamp(0, allDays.length - 1);
              final selectedDay = allDays[_selectedDayIndex];

              final daySchedules = isAllScedule
                  ? cubit.schedules
                      .expand((group) => group.schedule.map((item) => {
                            'day': item.day,
                            'startTime': item.startTime,
                            'endTime': item.endTime,
                            'subject': item.subject.name,
                            'group': group.groupName,
                            'room': item.location,
                          }))
                      .where((item) => item['day'] == selectedDay)
                      .toList()
                  : cubit.mySchedules
                      .where((item) => item.day == selectedDay)
                      .toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Horizontal day selector
                  SizedBox(
                    height: 60.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: allDays.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDayIndex = index;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Column(
                              children: [
                                Text(
                                  allDays[index],
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                      color: _selectedDayIndex == index
                                          ? AppColors.color2
                                          : AppColors.color1,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Container(
                                  width: 25,
                                  height: 5,
                                  color: _selectedDayIndex == index
                                      ? AppColors.color2
                                      : AppColors.color1,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),

                  // Schedule List
                  Expanded(
                    child: ListView.builder(
                      itemCount: daySchedules.length,
                      itemBuilder: (context, index) {
                        if (isAllScedule) {
                          final schedule =
                              daySchedules[index] as Map<String, dynamic>;
                          return AllScheduleItem(
                            start: schedule['startTime'] ?? '',
                            end: schedule['endTime'] ?? '',
                            subject: schedule['subject'] ?? '',
                            groub: schedule['group'] ?? '',
                            room: schedule['room'] ?? '',
                          );
                        } else {
                          final item = daySchedules[index] as ScheduleItems;
                          return MyScheduleItem(
                            startTime: item.startTime,
                            endTime: item.endTime,
                            title: item.subject.name,
                            instructor: "", // Add real data if you have it
                            room: item.location,
                            color: AppColors.color1,
                          );
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
