import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/app_colors.dart';

class WarningItem extends StatelessWidget {
  const WarningItem({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.sp),
      child: Container(
        width: 370.w,
        height: 80.h,
        decoration: BoxDecoration(
          border:
              const Border.fromBorderSide(BorderSide(color: AppColors.color2)),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Image.asset('assets/images/icons/warning.png',),
            Icon(
              Icons.warning,
              size: 35.sp,
            ),
            SizedBox(
              width: 290.w,
              child: Text(
                text,
                maxLines: 4,
                overflow: TextOverflow.clip,
                style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 15.sp, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
