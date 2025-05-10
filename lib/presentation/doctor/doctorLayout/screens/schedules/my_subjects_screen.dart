import 'package:attend_pro/core/app_colors.dart';
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
    return BlocProvider(
      create: (context) => StaffSubjectsCubit()..getStaffSubjects(),
      child: Scaffold(
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
        body: BlocConsumer<StaffSubjectsCubit, StaffSubjectsState>(
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
            final cubit = StaffSubjectsCubit.get(context);

            if (state is StaffSubjectsLoading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.color1,));
            }

            if (state is StaffSubjectsSuccess) {
              if (cubit.staffSubjects.isEmpty) {
                return Center(
                  child: Text(
                    'no_subjects'.tr(), // make sure this is translated
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                itemCount: cubit.staffSubjects.length,
                itemBuilder: (context, index) {
                  final item = cubit.staffSubjects[index];
                  return SubjectItem(
                    subject: item.subject.name,
                    code: item.subject.code,
                    lectDay: item.schedule?.day ?? "",
                    group: item.group.name,
                    lecTime: '10:00', // Consider fetching real time if possible
                    lectRoom: item.schedule?.location ?? "M203",
                    secDay: 'sun',    // Static: consider linking real data
                    eng: 'sara',
                    secTime: '11:00',
                    secRoom: '210',
                  );
                },
              );
            }

            if (state is StaffSubjectsFailure) {
              return Center(
                child: Text(
                  'error_occurred'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }

            return const SizedBox(); // fallback in case of unexpected state
          },
        ),
      ),
    );
  }
}
