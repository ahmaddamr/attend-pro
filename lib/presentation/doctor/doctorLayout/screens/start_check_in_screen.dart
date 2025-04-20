import 'dart:developer';

import 'package:attend_pro/presentation/doctor/doctorLayout/screens/check_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/widgets/custom_elevatedButton.dart';

class StartCheckInScreen extends StatelessWidget {
  const StartCheckInScreen({super.key, required this.hall, required this.id});
  final String hall, id;

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomElvatedButton(
                    text: 'Cancel Selection',
                    backgroundColor: AppColors.color5,
                    borderSideColor: Colors.transparent,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: CustomElvatedButton(
                    text: 'Start Check-In',
                    backgroundColor: AppColors.color1,
                    borderSideColor: Colors.transparent,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: CheckInScreen(
                            id: id,
                            
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
          ),
        ],
      ),
    );
  }
}
