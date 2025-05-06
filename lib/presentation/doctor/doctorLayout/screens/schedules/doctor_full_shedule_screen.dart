import 'package:attend_pro/core/app_colors.dart';
import 'package:attend_pro/data/models/new_all_schedules_model.dart';
import 'package:attend_pro/data/models/my_schedule_model.dart';
import 'package:attend_pro/presentation/manager/cubit/schedules/schedules_cubit.dart';
import 'package:attend_pro/presentation/student/studentLayout/widget/new_all_schedule_item.dart';
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
  bool isAllSchedule = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          isAllSchedule ? 'allsc'.tr() : 'yoursc'.tr(),
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: SizedBox(
              width: 160.w,
              height: 48.h,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isAllSchedule = !isAllSchedule;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.color1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  isAllSchedule ? 'mysc'.tr() : 'allsc'.tr(),
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 14.sp,
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
          ..getMySchedules()
          ..getNewSchedules(),
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

              // Determine the data to render based on the schedule type
              return isAllSchedule
                  ? _buildAllSchedulesView(cubit)
                  : _buildMySchedulesView(cubit);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAllSchedulesView(SchedulesCubit cubit) {
    final allSchedulesModel = cubit.model; // or cubit.newSchedules
    final allDays = allSchedulesModel?.data.keys.toList() ?? [];

    if (allDays.isEmpty) {
      return const Center(
        child: Text(
          "Loading...",
          style: TextStyle(color: AppColors.color1),
        ),
      );
    }

    _selectedDayIndex = _selectedDayIndex.clamp(0, allDays.length - 1);
    final selectedDay = allDays[_selectedDayIndex];
    final dayScheduleData = allSchedulesModel?.data[selectedDay] ?? {};

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDaySelector(allDays),
        SizedBox(height: 10.h),
        Expanded(
          child: ListView.builder(
            itemCount: dayScheduleData.length,
            itemBuilder: (context, timeSlotIndex) {
              final timeSlot = dayScheduleData.keys.elementAt(timeSlotIndex);
              final scheduleItems = dayScheduleData[timeSlot];

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: NewAllScheduleItem(
                  start: timeSlot.split('-').first,
                  end: timeSlot.split('-').last,
                  list: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: scheduleItems?.length ?? 0,
                    itemBuilder: (context, index) {
                      final item = scheduleItems![index];

                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              item.subjectName,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.sp),
                            ),
                            Text(
                              "${item.groupName}",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.sp),
                            ),
                            Text(
                              "Room: ${item.location}",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.sp),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMySchedulesView(SchedulesCubit cubit) {
    final mySchedules = cubit.mySchedules;
    final myDays = mySchedules.map((item) => item.day).toSet().toList();

    if (myDays.isEmpty) {
      return const Center(
        child: Text(
          "Loading...",
          style: TextStyle(color: AppColors.color1),
        ),
      );
    }

    _selectedDayIndex = _selectedDayIndex.clamp(0, myDays.length - 1);
    final selectedDay = myDays[_selectedDayIndex];
    final myDayScheduleData =
        mySchedules.where((item) => item.day == selectedDay).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDaySelector(myDays),
        SizedBox(height: 10.h),
        Expanded(
          child: ListView.builder(
            itemCount: myDayScheduleData.length,
            itemBuilder: (context, index) {
              final item = myDayScheduleData[index];

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: MyScheduleItem(
                  session: item.sessionType,
                  startTime: item.startTime,
                  endTime: item.endTime,
                  title: item.subject.name,
                  instructor: "",
                  room: item.location,
                  color: AppColors.color1,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDaySelector(List<String> days) {
    return SizedBox(
      height: 60.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
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
                    days[index],
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: _selectedDayIndex == index
                            ? AppColors.color1
                            : AppColors.color2,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Container(
                    width: 25.w,
                    height: 5.h,
                    color: _selectedDayIndex == index
                        ? AppColors.color1
                        : AppColors.color2,
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
