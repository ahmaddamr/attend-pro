import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_colors.dart';

class StudentCheckInDataItem extends StatelessWidget {
  const StudentCheckInDataItem(
      {super.key,
      required this.id,
      required this.name,
      required this.status,
      this.bColor});
  final String id, name;
  final String status;
  final Color? bColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bColor,
        border:
            const Border(bottom: BorderSide(color: AppColors.color2, width: 2)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Row(
          children: [
            Text(
              id,
              style: GoogleFonts.montserrat(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(width: 20.w), // Space between id and name
            Text(
              name,
              style: GoogleFonts.montserrat(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w700),
              ),
            ),
            const Spacer(), // Pushes status to the right
            Text(
              status,
              style: GoogleFonts.montserrat(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w700),
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == "Edit status") {
                  log('Edit');
                } else if (value == "Send Warning") {
                  log('Send Warning');
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: "Edit status",
                  child: Text("Edit status"),
                ),
                const PopupMenuItem(
                  value: "Send Warning",
                  child: Text("Send Warning"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
