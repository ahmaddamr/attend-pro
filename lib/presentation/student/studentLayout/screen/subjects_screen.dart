import 'package:attend_pro/presentation/student/studentLayout/widget/subject_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        title: Text(
          'subject'.tr(),
          style: GoogleFonts.montserrat(
            textStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.sp),
                child: Text(
                  'Your Subjects',
                  style: GoogleFonts.montserrat(
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(
                height: 1000.h,
                child: ListView.builder(
                  // shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return const SubjectItem(
                      subject: 'Ai',
                        lectDay: 'sunaday',
                        dr: 'Ahmed',
                        lecTime: '10:00',
                        lectRoom: '211',
                        secDay: 'sun',
                        eng: 'sara',
                        secTime: '11:00',
                        secRoom: '210');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
