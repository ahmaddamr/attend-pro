// ignore_for_file: must_be_immutable
import 'dart:developer';
import 'package:attend_pro/core/widgets/custom_elevatedButton.dart';
import 'package:attend_pro/data/models/groups_model.dart';
import 'package:attend_pro/presentation/doctor/doctorLayout/screens/start_check_in_screen.dart';
import 'package:attend_pro/presentation/manager/cubit/groups_cubit/groups_cubit.dart';
import 'package:attend_pro/presentation/manager/cubit/halls_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/app_colors.dart';
import '../../../../data/models/courses_model.dart';
import '../../../manager/cubit/subjects_cubit/subjects_cubit.dart';

class HallEditsScreen extends StatefulWidget {
  const HallEditsScreen(
      {super.key, required this.location, required this.hallId});
  final String location, hallId;

  @override
  State<HallEditsScreen> createState() => _HallEditsScreenState();
}

class _HallEditsScreenState extends State<HallEditsScreen> {
  final _formKey = GlobalKey<FormState>();
  CourseSubject? selectedCourse;
  GroupData? selectedGroup;
  late GroupsCubit groupsCubit;

  // Controllers for TextFormFields
  final _sessionDateController = TextEditingController();
  final _sessionTypeController = TextEditingController();
  final weekNumber = TextEditingController();
  final RegExp sessionTypeRegex = RegExp(r'^(lecture|lab)$'); // غير حساس للأحرف

  @override
  void initState() {
    super.initState();
    groupsCubit = GroupsCubit();
  }

  @override
  void dispose() {
    groupsCubit.close();
    _sessionDateController.dispose();
    _sessionTypeController.dispose();
    weekNumber.dispose();
    super.dispose();
  }

  // Function to show date picker for sessionDate
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _sessionDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SubjectsCubit()..getCourses()),
        BlocProvider(create: (context) => groupsCubit),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'hall'.tr(),
            style: GoogleFonts.montserrat(
              textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ),
        body: Form(
          key: _formKey,
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
              final cubit = SubjectsCubit.get(context);
              return SingleChildScrollView(
                padding: EdgeInsets.all(20.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        widget.location,
                        style: GoogleFonts.montserrat(
                          textStyle:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 26.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25.h),
                    Text(
                      'course'.tr(),
                      style: GoogleFonts.montserrat(
                        textStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    if (state is CoursesLoading)
                      const Center(
                        child:
                            CircularProgressIndicator(color: AppColors.color1),
                      )
                    else if (cubit.courses.isEmpty)
                      const Text(
                        "No courses available.",
                        style: TextStyle(color: AppColors.color1),
                      )
                    else
                      DropdownButtonFormField<CourseSubject>(
                        value: selectedCourse,
                        items: cubit.courses
                            .map(
                              (course) => DropdownMenuItem<CourseSubject>(
                                value: course,
                                child: Text(course.name),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCourse = value;
                            selectedGroup = null;
                          });
                          if (value != null) {
                            groupsCubit.getGroups(value.id.toString());
                            log(value.id);
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 10.h),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide:
                                const BorderSide(color: AppColors.color1),
                          ),
                        ),
                        hint: const Text("Select a course"),
                      ),
                    SizedBox(height: 25.h),
                    Text(
                      'group'.tr(),
                      style: GoogleFonts.montserrat(
                        textStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    BlocBuilder<GroupsCubit, GroupsState>(
                      builder: (context, state) {
                        if (state is GroupsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                                color: AppColors.color1),
                          );
                        }

                        if (groupsCubit.groups.isEmpty) {
                          return const Text(
                            "No groups available!",
                            style: TextStyle(color: AppColors.color1),
                          );
                        }

                        return DropdownButtonFormField<GroupData>(
                          value: selectedGroup,
                          items: groupsCubit.groups
                              .map(
                                (group) => DropdownMenuItem<GroupData>(
                                  value: group,
                                  child: Text(group.name),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedGroup = value;
                            });
                            log("Selected group: ${value?.name}");
                            log("Selected group id: ${value?.id}");
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 10.h),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r)),
                          ),
                          hint: const Text("Select a Group"),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a group';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    SizedBox(height: 25.h),
                    // Session Date TextFormField with Date Picker
                    Text(
                      'Session Date'.tr(),
                      style: GoogleFonts.montserrat(
                        textStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      controller: _sessionDateController,
                      readOnly: true, // Prevent manual editing
                      onTap: () => _selectDate(context),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(color: AppColors.color1),
                        ),
                        hintText: 'Select Session Date',
                        suffixIcon: const Icon(Icons.calendar_today),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a session date';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 25.h),
                    // Session Type TextFormField
                    Text(
                      'Session Type'.tr(),
                      style: GoogleFonts.montserrat(
                        textStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      controller: _sessionTypeController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(color: AppColors.color1),
                        ),
                        hintText: 'Enter Session Type (lecture, lab)',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a session type';
                        }
                        final regex =
                            RegExp(r'^(lecture|lab)$', caseSensitive: false);
                        if (!regex.hasMatch(value.trim())) {
                          return 'Type must be "lecture" or "lab" only';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 25.h),

                    Text(
                      'Week Number'.tr(),
                      style: GoogleFonts.montserrat(
                        textStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: weekNumber,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(color: AppColors.color1),
                        ),
                        hintText: 'Enter Week Number',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Week Number';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 25.h),
                    BlocProvider(
                      create: (context) => HallsCubit(),
                      child: BlocConsumer<HallsCubit, HallsState>(
                        listener: (context, state) {
                          if (state is SelectHallsFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.msg),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }

                          if (state is SelectHallsSuccess) {
                            Navigator.push(
                              context,
                              PageTransition(
                                child: StartCheckInScreen(
                                  hallId: widget.hallId,
                                  hall: widget.location,
                                  id: selectedGroup?.id ?? 'no id',
                                  date: _sessionDateController.text,
                                  type: _sessionTypeController.text,
                                ),
                                type: PageTransitionType.theme,
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          var selectCubit = HallsCubit.get(context);

                          return Row(
                            children: [
                              SizedBox(width: 15.w),
                              Expanded(
                                child: CustomElvatedButton(
                                  text: state is SelectHallsLoading
                                      ? 'Loading...'
                                      : 'Start',
                                  backgroundColor: AppColors.color1,
                                  borderSideColor: Colors.transparent,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                  onPressed: state is SelectHallsLoading
                                      ? null
                                      : () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            log('valid');
                                            selectCubit.selectHall(
                                              widget.hallId,
                                              subjectId:
                                                  selectedCourse?.id ?? 'no id',
                                              groupId:
                                                  selectedGroup?.id ?? 'no id',
                                              weekNumber: 1,
                                              sessionType:
                                                  _sessionTypeController.text,
                                            );
                                          } else {
                                            log('invalid');
                                          }
                                        },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
