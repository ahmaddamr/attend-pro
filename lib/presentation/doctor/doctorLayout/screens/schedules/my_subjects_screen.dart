import 'package:attend_pro/presentation/manager/cubit/staff_sub_cubit/staff_subjects_cubit.dart';
import 'package:attend_pro/presentation/student/studentLayout/widget/subject_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

class MySubjectsScreen extends StatelessWidget {
  const MySubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'mysub'.tr(),
          style: GoogleFonts.montserrat(
            textStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => StaffSubjectsCubit()..getStaffSubjects(),
        child: BlocConsumer<StaffSubjectsCubit, StaffSubjectsState>(
          listener: (context, state) {
            if (state is StaffSubjectsFailure) {
              toastification.show(
                context: context,
                type: ToastificationType.error,
                style: ToastificationStyle.flat,
                autoCloseDuration: const Duration(seconds: 3),
                title: Text(state.msg),
              );
            }
          },
          builder: (context, state) {
            var cubit = StaffSubjectsCubit.get(context);
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cubit.staffSubjects.length,
                    itemBuilder: (context, index) {
                      return SubjectItem(
                          subject: cubit.staffSubjects[index].subject.name,
                          code: cubit.staffSubjects[index].subject.code,
                          lectDay:
                              cubit.staffSubjects[index].schedule?.day ?? "",
                          group: cubit.staffSubjects[index].group.name,
                          lecTime: '10:00',
                          lectRoom:
                              cubit.staffSubjects[index].schedule?.location ??
                                  "M203",
                          secDay: 'sun',
                          eng: 'sara',
                          secTime: '11:00',
                          secRoom: '210');
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
