import 'dart:developer';
import 'package:attend_pro/core/app_colors.dart';
import 'package:attend_pro/core/widgets/custom_elevatedButton.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/purple_data_log_item.dart';
import '../widgets/student_data_item.dart';

class AttendanceLogsDataScreen extends StatelessWidget {
  const AttendanceLogsDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'logs'.tr(),
          style: GoogleFonts.montserrat(
            textStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            // Fix: Wrap ListView.builder with Expanded
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  // height: 50, // Give it a height
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'week 1',
                              style: GoogleFonts.montserrat(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w700),
                              ),
                            ),
                            Text(
                              '1/1/2025',
                              style: GoogleFonts.montserrat(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const PurpleDataLogItem(),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, subindex) {
                          return const StudentDataItem(
                            id: '42021105',
                            name: 'Ahmed mohamed',
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'See More',
                              style: GoogleFonts.montserrat(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 145.w,
                        child: CustomElvatedButton(
                            text: 'Save As Pdf',
                            backgroundColor: AppColors.color1,
                            borderSideColor: Colors.transparent,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                            onPressed: () {}),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
