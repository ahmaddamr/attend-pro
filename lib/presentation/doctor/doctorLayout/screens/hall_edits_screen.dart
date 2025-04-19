// ignore_for_file: must_be_immutable
import 'dart:developer';
import 'package:attend_pro/core/widgets/custom_elevatedButton.dart';
import 'package:attend_pro/presentation/doctor/doctorLayout/screens/check_in_screen.dart';
import 'package:attend_pro/presentation/doctor/doctorLayout/screens/start_check_in_screen.dart';
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
  HallEditsScreen({super.key, required this.location});
  final String location;

  @override
  State<HallEditsScreen> createState() => _HallEditsScreenState();
}

class _HallEditsScreenState extends State<HallEditsScreen> {
  final _formKey = GlobalKey<FormState>();
  CourseSubject? selectedCourse;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubjectsCubit()..getCourses(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'hall'.tr(),
            style: GoogleFonts.montserrat(
              textStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
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
                    SizedBox(height: 30.h),
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
                      const Text("No courses available.")
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
                          });
                          log("Selected course: ${value?.name}");
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
                    // if (selectedCourse != null) ...[
                    //   SizedBox(height: 20.h),
                    //   Text("Course Code: ${selectedCourse!.code}"),
                    //   Text("Year: ${selectedCourse!.year}"),
                    //   Text("Department: ${selectedCourse!.department.name}"),
                    // ],
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'group'.tr(),
                            style: GoogleFonts.montserrat(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w700),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.color2,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide:
                                        BorderSide(color: AppColors.color2),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Group Number';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomElvatedButton(
                                text: 'Cancel',
                                backgroundColor: AppColors.color5,
                                borderSideColor: Colors.transparent,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700),
                                onPressed: () {}),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Expanded(
                            child: CustomElvatedButton(
                                text: 'Start',
                                backgroundColor: AppColors.color1,
                                borderSideColor: Colors.transparent,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    log('valid');
                                  } else {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          child: const StartCheckInScreen(),
                                          type: PageTransitionType.theme,
                                          duration: const Duration(seconds: 1),
                                        ));
                                    log('invalid');
                                  }
                                }),
                          )
                        ],
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
