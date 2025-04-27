import 'dart:developer';

import 'package:attend_pro/core/app_colors.dart';
import 'package:attend_pro/presentation/doctor/doctorLayout/screens/choose_announce_group_screen.dart';
import 'package:attend_pro/presentation/manager/cubit/subjects_cubit/subjects_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class DoctorAnnouncmentsScreen extends StatefulWidget {
  const DoctorAnnouncmentsScreen({super.key});

  @override
  State<DoctorAnnouncmentsScreen> createState() =>
      _DoctorAnnouncmentsScreenState();
}

class _DoctorAnnouncmentsScreenState extends State<DoctorAnnouncmentsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _announcementController = TextEditingController();

  @override
  void dispose() {
    _announcementController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'announcements'.tr(),
            style: GoogleFonts.montserrat(
              textStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
            ),
          ),
          BlocProvider(
            create: (context) => SubjectsCubit()..getCourses(),
            child: BlocConsumer<SubjectsCubit, SubjectsState>(
              listener: (context, state) {},
              builder: (context, state) {
                var coursesCubit = SubjectsCubit.get(context);
                return Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Container(
                    padding: EdgeInsets.all(20.sp),
                    decoration: BoxDecoration(
                      color: AppColors.color2, // Dark background
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _announcementController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: "What's On Your Mind ?",
                              hintStyle: TextStyle(color: Colors.white54),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your announcement';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.color1,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final announcementText =
                                      _announcementController.text;
                                      log('announcementText: $announcementText');
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Choose Subject',
                                          style: GoogleFonts.montserrat(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    fontSize: 24.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                        ),
                                        content: SizedBox(
                                          height: 200.h,
                                          width: double.maxFinite,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                coursesCubit.courses.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      Navigator.push(
                                                        context,
                                                        PageTransition(
                                                          child:
                                                              ChooseAnnounceGroupScreen(
                                                            id: coursesCubit
                                                                .courses[index]
                                                                .id,
                                                            announcementText:
                                                                announcementText, // تمرير النص هنا
                                                          ),
                                                          type:
                                                              PageTransitionType
                                                                  .theme,
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      900),
                                                        ),
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 8.0),
                                                      child: Text(
                                                        coursesCubit
                                                            .courses[index]
                                                            .name,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          textStyle: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodySmall!
                                                              .copyWith(
                                                                  fontSize:
                                                                      18.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const Divider(),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text("Close"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: const Text(
                                "Send To",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
