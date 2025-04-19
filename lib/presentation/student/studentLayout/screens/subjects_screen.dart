import 'package:attend_pro/data/models/subjects_model.dart';
import 'package:attend_pro/presentation/manager/cubit/subjects_cubit/subjects_cubit.dart';
import 'package:attend_pro/presentation/student/studentLayout/widget/subject_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/app_colors.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        title: Text(
          'subject'.tr(),
          style: GoogleFonts.montserrat(
            textStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.sp),
                child: Text(
                  'Your Subjects',
                  style: GoogleFonts.montserrat(
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              BlocProvider(
                create: (context) => SubjectsCubit()..getSubjects(),
                child: BlocConsumer<SubjectsCubit, SubjectsState>(
                  listener: (context, state) {
                    if (state is SubjectsLoading) {
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
                    if (state is SubjectsSuccess) {}
                    if (state is SubjectsFailure) {
                      Navigator.pop(context);
                      toastification.show(
                        context:
                            context, // optional if you use ToastificationWrapper
                        type: ToastificationType.error,
                        style: ToastificationStyle.flat,
                        autoCloseDuration: const Duration(seconds: 5),
                        title: Text(state.msg),
                      );
                    }
                  },
                  builder: (context, state) {
                    var cubit = SubjectsCubit.get(context);
                    return SizedBox(
                      height: 1000.h,
                      child: ListView.builder(
                        // shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: cubit.subjects.length,
                        itemBuilder: (context, index) {
                          return SubjectItem(
                              subject: cubit.subjects[index].name,
                              code: cubit.subjects[index].code,
                              lectDay: 'sunaday',
                              dr: 'Ahmed',
                              lecTime: '10:00',
                              lectRoom: '211',
                              secDay: 'sun',
                              eng: 'sara',
                              secTime: '11:00',
                              secRoom: '210');
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
