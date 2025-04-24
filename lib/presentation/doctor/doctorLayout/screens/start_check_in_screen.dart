import 'dart:developer';

import 'package:attend_pro/presentation/doctor/doctorLayout/screens/check_in_screen.dart';
import 'package:attend_pro/presentation/manager/cubit/halls_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/widgets/custom_elevatedButton.dart';

class StartCheckInScreen extends StatelessWidget {
  const StartCheckInScreen(
      {super.key,
      required this.hall,
      required this.id,
      required this.date,
      required this.type,
      required this.hallId});
  final String hall, id, date, type, hallId;

  @override
  Widget build(BuildContext context) {
    log("latest $id");
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            hall,
            style: GoogleFonts.montserrat(
              textStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 60.sp, fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            'Check-In',
            style: GoogleFonts.montserrat(
              textStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 26.sp, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 30.h),
          BlocProvider(
            create: (context) => HallsCubit(),
            child: BlocConsumer<HallsCubit, HallsState>(
              listener: (context, state) {
                if (state is CancelHallsFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.msg),
                      backgroundColor: Colors.red,
                    ),
                  );
                }

                if (state is CancelHallsSuccess) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                var cancelCubit = HallsCubit.get(context);

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      /// Cancel Selection Button
                      Expanded(
                        child: CustomElvatedButton(
                          text: state is CancelHallsLoading
                              ? 'Cancelling...'
                              : 'Cancel Selection',
                          backgroundColor: AppColors.color5,
                          borderSideColor: Colors.transparent,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                          onPressed: state is CancelHallsLoading
                              ? null
                              : () {
                                  cancelCubit.cancelHall(hallId);
                                },
                        ),
                      ),
                      SizedBox(width: 15.w),

                      /// Start Check-In Button
                      Expanded(
                        child: CustomElvatedButton(
                          text: 'Start Check-In',
                          backgroundColor: AppColors.color1,
                          borderSideColor: Colors.transparent,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                child: CheckInScreen(
                                  id: id,
                                  date: date,
                                  type: type,
                                ),
                                type: PageTransitionType.rightToLeft,
                                duration: const Duration(milliseconds: 600),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
