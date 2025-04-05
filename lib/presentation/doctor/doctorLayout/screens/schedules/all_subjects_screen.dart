import 'package:attend_pro/presentation/doctor/doctorLayout/widgets/subject_data_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/app_colors.dart';

class AllSubjectsScreen extends StatelessWidget {
  AllSubjectsScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'allsub'.tr(),
          style: GoogleFonts.montserrat(
            textStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(14.sp),
            child: TextFormField(
              key: _formKey,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.color2,
                suffixIcon: const Icon(Icons.search),
                hintText: 'Search',
                labelStyle: GoogleFonts.montserrat(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w500),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(50.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.r),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return SubjectDataItem(
                  subject: 'DataBase',
                  drname: 'Dr. Ali',
                  code: 'Csc114',
                  color: index % 2 == 0 ? AppColors.color2 : null,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
