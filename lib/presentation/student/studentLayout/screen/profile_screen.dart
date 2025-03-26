import 'package:attend_pro/core/widgets/custom_elevatedButton.dart';
import 'package:attend_pro/presentation/student/studentLayout/screen/settings_screen.dart';
import 'package:attend_pro/presentation/student/studentLayout/widget/settings_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../core/app_colors.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'profile'.tr(),
          style: GoogleFonts.montserrat(
            textStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 31.sp, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.sp),
                child: CircleAvatar(
                  radius: 40.r,
                  backgroundColor: AppColors.color2,
                  child: Icon(
                    Icons.person,
                    size: 40.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ahmed miahmed mohamed',
                    style: GoogleFonts.montserrat(
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(
                              fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    '42020106',
                    style: GoogleFonts.montserrat(
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(
                              fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          SettingsItem(
              title: 'edprofile'.tr(),
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const EditProfileScreen(),
                        type: PageTransitionType.rightToLeft));
              }),
          SizedBox(
            height: 15.h,
          ),
          SettingsItem(
              title: 'settings'.tr(),
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const SettingsScreen(),
                        type: PageTransitionType.rightToLeft));
              }),
          SizedBox(
            height: 15.h,
          ),
          SettingsItem(title: 'help'.tr(), onTap: () {}),
          SizedBox(
            height: 15.h,
          ),
          SettingsItem(title: 'contact'.tr(), onTap: () {}),
          SizedBox(
            height: 300.h,
          ),
          CustomElvatedButton(
              text: 'logout'.tr(),
              backgroundColor: AppColors.color1,
              borderSideColor: Colors.transparent,
              style: GoogleFonts.montserrat(
                textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 21.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),
              onPressed: () {
                // log out action
              })
        ],
      ),
    );
  }
}
