// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_colors.dart';

class StudentDataItem extends StatelessWidget {
  StudentDataItem(
      {super.key, required this.id, required this.name, this.status});
  final String id, name;
  String? status;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.color2, width: 2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          Text(
            name,
            style: GoogleFonts.montserrat(
              textStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w700),
            ),
          ),
          Text(
            status!,
            style: GoogleFonts.montserrat(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w700)),
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
    );
  }
}
