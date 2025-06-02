
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_colors.dart';

class StudentCheckInDataItem extends StatelessWidget {
  StudentCheckInDataItem(
      {super.key,
      required this.id,
      required this.name,
      required this.status,
      this.bColor,
      this.border});
  final String id, name;
  final String status;
  final Color? bColor;
  Color? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      decoration: BoxDecoration(
        color: bColor,
        border: Border(
            bottom: BorderSide(color: border ?? Colors.transparent, width: 4)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Row(
          children: [
            Text(
              id,
              style: GoogleFonts.montserrat(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 15.sp, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(width: 30.w), // Space between id and name
            Text(
              name,
              style: GoogleFonts.montserrat(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 15.sp, fontWeight: FontWeight.w700),
              ),
            ),
            const Spacer(), // Pushes status to the right
            Text(
              status,
              style: GoogleFonts.montserrat(
                textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.color1),
              ),
            ),
            // PopupMenuButton<String>(
            //   onSelected: (value) {
            //     if (value == "Edit status") {
            //       log('Edit');
            //     } else if (value == "Send Warning") {
            //       log('Send Warning');
            //     }
            //   },
            //   itemBuilder: (context) => [
            //     const PopupMenuItem(
            //       value: "Edit status",
            //       child: Text("Edit status"),
            //     ),
            //     const PopupMenuItem(
            //       value: "Send Warning",
            //       child: Text("Send Warning"),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
