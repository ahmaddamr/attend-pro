// ignore_for_file: must_be_immutable
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/app_colors.dart';

class SubjectDataItem extends StatelessWidget {
  const SubjectDataItem(
      {super.key,
      required this.subject,
      required this.drname,
      required this.code,
      this.color});
  final String subject, drname, code;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        border:
            const Border(bottom: BorderSide(color: AppColors.color2, width: 2)),
      ),
      child: Padding(
        padding: EdgeInsets.all(2.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Text(
                subject,
                style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Text(
              drname,
              style: GoogleFonts.montserrat(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w700),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            Text(
              code,
              style: GoogleFonts.montserrat(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w700),
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == "Details") {
                  log('Details');
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: "Details",
                  child: Text("Details"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
