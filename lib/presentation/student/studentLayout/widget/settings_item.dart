import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_colors.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({super.key, required this.title, required this.onTap});
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
        child: Row(
          children: [
            Text(
              title,
              style: GoogleFonts.montserrat(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 23.sp, fontWeight: FontWeight.w600),
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_sharp,
              color: AppColors.color2,
            )
          ],
        ),
      ),
    );
  }
}
