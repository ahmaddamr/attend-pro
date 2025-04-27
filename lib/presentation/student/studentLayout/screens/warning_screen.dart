import 'package:attend_pro/presentation/manager/cubit/attendance_cubit/attendance_cubit.dart';
import 'package:attend_pro/presentation/manager/cubit/attendance_cubit/attendance_state.dart';
import 'package:attend_pro/presentation/student/studentLayout/widget/warning_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class WarningScreen extends StatelessWidget {
  const WarningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.transparent,
          title: Text(
            'Academic Warnings',
            style: GoogleFonts.montserrat(
              textStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        body: BlocProvider(
          create: (context) => AttendanceCubit()..getWarnings(),
          child: BlocConsumer<AttendanceCubit, AttendanceState>(
            listener: (context, state) {
              // if (state is WarningFailure) {
              //   toastification.show(
              //     context: context,
              //     type: ToastificationType.error,
              //     style: ToastificationStyle.flat,
              //     autoCloseDuration: const Duration(seconds: 5),
              //     title: Text(state.msg),
              //   );
              // }
            },
            builder: (context, state) {
              var cubit = AttendanceCubit.get(context);
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 1000.h,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return WarningItem(
                              text: cubit.warning?.message ??
                                  "\nAcademic Warning: You have been issued with an absence academic warning in the Image Processing group \"Group A\".\n      Your current absence count is 1 days.\n      This warning has been issued by your instructor.\n      Please contact your instructor or reach out for students adminstaration for more information.\n    ");
                        },
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }
}
