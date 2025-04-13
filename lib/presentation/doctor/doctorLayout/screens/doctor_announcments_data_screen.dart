import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/theme/apptheme.dart';
import '../../../manager/provider/main_provider.dart';

class DoctorAnnouncmentsDataScreen extends StatelessWidget {
  const DoctorAnnouncmentsDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MainProvider>(context);
    bool isDark = provider.themeData == AppTheme().darkTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'announcements'.tr(),
          style: GoogleFonts.montserrat(
            textStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dr: Ahmeddd',
                    style: GoogleFonts.montserrat(
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(
                              fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    'Group: 5 ',
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
            ),
            const SizedBox(height: 10),
            Expanded(
              // ✅ This prevents overflow
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
                            const Spacer(),
                            Text(
                              '10:00 Am',
                              style: GoogleFonts.montserrat(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600),
                              ),
                            ),
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == "Delete") {
                                  log('Delete');
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: "Delete",
                                  child: Text("Delete"),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 50.sp, bottom: 10.sp),
                        child: IntrinsicHeight(
                          // ✅ Dynamically adjust height
                          child: Container(
                            width: double.infinity,
                            height: 90.h,
                            constraints: BoxConstraints(
                              maxWidth: 350.w, // ✅ Prevents horizontal overflow
                              minHeight: 80.h, // ✅ Adjust dynamically
                            ),
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
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.sp),
                                child: Text(
                                  'Dr: Ahmed Ahmed Ahmed Ahmed Ahmed Ahmed Ahmed Ahmed Ahmed Ahmed Ahmed Ahmed Ahmed Ahmed Ahmed Ahmed Ahmed Ahmed Ahmed Ahmed Ahmed Ahmed',
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

                                  softWrap: true, // ✅ Allow text wrapping
                                  maxLines: 2, // ✅ No limit on lines
                                  overflow:
                                      TextOverflow.ellipsis, // ✅ Show full text
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
            ),
          ],
        ),
      ),
    );
  }
}
