import 'package:attend_pro/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsItem extends StatelessWidget {
  const NotificationsItem(
      {super.key, required this.time, required this.content});
  final String time, content;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.h,
      decoration: BoxDecoration(
        color: AppColors.color2.withOpacity(0.6),
        border: const Border(
          bottom: BorderSide(color: Colors.white),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: Text(
              time,
              style: GoogleFonts.montserrat(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(12.sp),
              child: Text(
                content,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 22.sp, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
