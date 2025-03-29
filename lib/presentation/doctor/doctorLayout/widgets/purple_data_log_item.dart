import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_colors.dart';

class PurpleDataLogItem extends StatelessWidget {
  const PurpleDataLogItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 30.h,
      decoration: const BoxDecoration(color: AppColors.color1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Id',
            style: GoogleFonts.montserrat(
              textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Text(
            'Name',
            style: GoogleFonts.montserrat(
              textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Text(
            'Status',
            style: GoogleFonts.montserrat(
              textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
