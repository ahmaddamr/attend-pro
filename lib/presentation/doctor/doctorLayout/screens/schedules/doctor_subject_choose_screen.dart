import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../../core/app_colors.dart';
import '../../../../../core/widgets/custom_elevatedButton.dart';
import 'all_subjects_screen.dart';

class DoctorSubjectChooseScreen extends StatelessWidget {
  const DoctorSubjectChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100.h,
          ),
          CustomElvatedButton(
              text: 'allsub'.tr(),
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
                    child:  AllSubjectsScreen(),
                    type: PageTransitionType.theme,
                    duration: const Duration(milliseconds: 900),
                  ),
                );
              }),
          SizedBox(
            height: 20.h,
          ),
          CustomElvatedButton(
              text: 'mysub'.tr(),
              backgroundColor: AppColors.color2,
              borderSideColor: Colors.transparent,
              style: GoogleFonts.montserrat(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w600),
              ),
              onPressed: () {})
        ],
      ),
    );
  }
}
