import 'package:attend_pro/presentation/doctor/doctorLayout/widgets/subject_data_item.dart';
import 'package:attend_pro/presentation/manager/cubit/staff_sub_cubit/staff_subjects_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/app_colors.dart';

class AllSubjectsScreen extends StatelessWidget {
  AllSubjectsScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'allsub'.tr(),
          style: GoogleFonts.montserrat(
            textStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(14.sp),
            child: TextFormField(
              key: _formKey,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.color2,
                suffixIcon: const Icon(Icons.search),
                hintText: 'Search',
                labelStyle: GoogleFonts.montserrat(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w500),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(50.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.r),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => StaffSubjectsCubit()..getStaffSubjects(),
            child: BlocConsumer<StaffSubjectsCubit, StaffSubjectsState>(
              listener: (context, state) {
                if (state is StaffSubjectsFailure) {
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
                var cubit = StaffSubjectsCubit.get(context);
                if (state is StaffSubjectsLoading) {
                  // Return the loading indicator when SubjectsCubit is loading
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.color1,
                    ),
                  );
                }
                if (state is StaffSubjectsSuccess) {
                  // Display the list of subjects when data is successfully loaded
                  return Expanded(
                    child: ListView.builder(
                      itemCount:
                          cubit.staffSubjects.length, // Update to dynamic count
                      itemBuilder: (context, index) {
                        var subject = cubit.staffSubjects[index];
                        return SubjectDataItem(
                          subject:
                              subject.subject.name, // Use actual subject data
                          drname: '', // Update with actual data
                          code: subject.subject.code, // Use actual course code
                          color: index % 2 == 0 ? AppColors.color2 : null,
                        );
                      },
                    ),
                  );
                }
                return const SizedBox(); // Fallback empty widget if no state is matched
              },
            ),
          ),
        ],
      ),
    );
  }
}
