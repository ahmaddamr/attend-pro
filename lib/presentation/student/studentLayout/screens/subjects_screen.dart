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
    return BlocProvider(
      create: (context) => SubjectsCubit()..getSubjects(),
      child: Scaffold(
        appBar: AppBar(
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
        body: Padding(
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
              Expanded(
                child: BlocConsumer<SubjectsCubit, SubjectsState>(
                  listener: (context, state) {
                    if (state is SubjectsFailure) {
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
                    if (state is SubjectsLoading) {
                      return const Center(
                        child:
                            CircularProgressIndicator(color: AppColors.color1),
                      );
                    } else if (state is SubjectsSuccess) {
                      var subjects = SubjectsCubit.get(context).subjects;
                      if (subjects.isEmpty) {
                        return const Center(
                            child: Text("No subjects available"));
                      }
                      return ListView.builder(
                        itemCount: subjects.length,
                        itemBuilder: (context, index) {
                          final model = subjects[index];
                          return SubjectItem(
                            subject: model.subject.name,
                            code: model.subject.code,
                            lectDay: model.schedule.day,
                            group: model.group.name,
                            lecTime: '10:00',
                            lectRoom: model.schedule.location,
                            secDay: 'sun',
                            eng: 'sara',
                            secTime: '11:00',
                            secRoom: '210',
                          );
                        },
                      );
                    } else if (state is SubjectsFailure) {
                      return const Center(
                          child: Text("Failed to load subjects"));
                    } else {
                      return const SizedBox.shrink();
                    }
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
