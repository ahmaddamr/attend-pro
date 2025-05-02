import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_colors.dart';

class SubjectItem extends StatelessWidget {
  const SubjectItem(
      {super.key,
      required this.lectDay,
      required this.group,
      required this.lecTime,
      required this.lectRoom,
      required this.secDay,
      required this.eng,
      required this.secTime,
      required this.secRoom,
      required this.subject,
      required this.code});
  final String subject,
      lectDay,
      group,
      lecTime,
      lectRoom,
      secDay,
      eng,
      secTime,
      code,
      secRoom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 351.w,
        height: 155.h,
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.color2, width: 2)),
          // borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          children: [
            Text(
              subject,
              style: GoogleFonts.montserrat(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.all(15.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Code: $code',
                        style: GoogleFonts.montserrat(
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontSize: 17.sp, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Text(
                        'Group: $group',
                        style: GoogleFonts.montserrat(
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontSize: 17.sp, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Text(
                        'Lecture Day: $lectDay',
                        style: GoogleFonts.montserrat(
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontSize: 17.sp, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Text(
                        'Room: $lectRoom',
                        style: GoogleFonts.montserrat(
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontSize: 17.sp, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.all(15.sp),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         'Section: $secDay',
                //         style: GoogleFonts.montserrat(
                //           textStyle: Theme.of(context)
                //               .textTheme
                //               .bodySmall!
                //               .copyWith(
                //                   fontSize: 17.sp, fontWeight: FontWeight.w400),
                //         ),
                //       ),
                //       Text(
                //         'Eng, $eng',
                //         style: GoogleFonts.montserrat(
                //           textStyle: Theme.of(context)
                //               .textTheme
                //               .bodySmall!
                //               .copyWith(
                //                   fontSize: 17.sp, fontWeight: FontWeight.w400),
                //         ),
                //       ),
                //       Text(
                //         'Time: $secTime',
                //         style: GoogleFonts.montserrat(
                //           textStyle: Theme.of(context)
                //               .textTheme
                //               .bodySmall!
                //               .copyWith(
                //                   fontSize: 17.sp, fontWeight: FontWeight.w400),
                //         ),
                //       ),
                //       Text(
                //         'Room: $secRoom',
                //         style: GoogleFonts.montserrat(
                //           textStyle: Theme.of(context)
                //               .textTheme
                //               .bodySmall!
                //               .copyWith(
                //                   fontSize: 17.sp, fontWeight: FontWeight.w400),
                //         ),
                //       ),
                //     ],
                //   ),
                // )
              ],
            )
          ],
        ),
      ),
    );
  }
}
