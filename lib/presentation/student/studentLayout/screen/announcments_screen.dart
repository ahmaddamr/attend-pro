import 'package:attend_pro/core/app_colors.dart';
import 'package:attend_pro/core/theme/apptheme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../manager/provider/main_provider.dart';

class AnnouncmentsScreen extends StatelessWidget {
  const AnnouncmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MainProvider>(context);
    bool isDark;
    if (provider.themeData == AppTheme().darkTheme) {
      isDark = true;
    } else {
      isDark = false;
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'announcements'.tr(),
                style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 1000.h,
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.sp),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25.r,
                                backgroundColor: AppColors.color2,
                                child: const Icon(Icons.person),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.sp),
                                child: Text(
                                  'Dr: Ahmed',
                                  style: GoogleFonts.montserrat(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 50.sp, bottom: 10.sp),
                          child: Container(
                            width: 327.w,
                            height: 101.h,
                            decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xff515151)
                                    : const Color(0xffD7D7D7),
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(40),
                                    bottomRight: Radius.circular(40),
                                    bottomLeft: Radius.circular(40)),
                                boxShadow: const [
                                  BoxShadow(spreadRadius: 0.1, blurRadius: 3)
                                ]),
                            child: Padding(
                              padding: EdgeInsets.all(8.sp),
                              child: Center(
                                child: Text(
                                  'Dr: Ahmed AhmedAhmedAhmedAhmedAhmedAhmedAhmedAhmedAhmed',
                                  style: GoogleFonts.montserrat(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: isDark
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
