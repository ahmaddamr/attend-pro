import 'package:attend_pro/core/app_colors.dart';
import 'package:attend_pro/core/widgets/custom_elevatedButton.dart';
import 'package:attend_pro/presentation/doctor/doctorLayout/screens/schedules/doctor_full_shedule_screen.dart';
import 'package:attend_pro/presentation/doctor/doctorLayout/screens/schedules/doctor_subject_choose_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class DoctorShedulesScreen extends StatelessWidget {
  const DoctorShedulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50.h,
        ),
        CustomElvatedButton(
            text: 'subject'.tr(),
            backgroundColor: AppColors.color2,
            borderSideColor: Colors.transparent,
            style: GoogleFonts.montserrat(
              textStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  child: const DoctorSubjectChooseScreen(),
                  type: PageTransitionType.theme,
                  duration: const Duration(milliseconds: 900),
                ),
              );
            }),
        SizedBox(
          height: 20.h,
        ),
        CustomElvatedButton(
            text: 'schedule'.tr(),
            backgroundColor: AppColors.color2,
            borderSideColor: Colors.transparent,
            style: GoogleFonts.montserrat(
              textStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w600),
            ),
            onPressed: () 
            {
              Navigator.push(
                context,
                PageTransition(
                  child: const DoctorFullSheduleScreen(),
                  type: PageTransitionType.theme,
                  duration: const Duration(milliseconds: 900),
                ),
              );
            })
      ],
    );
  }
}
