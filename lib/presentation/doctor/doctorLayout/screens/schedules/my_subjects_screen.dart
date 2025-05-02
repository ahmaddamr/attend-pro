import 'package:attend_pro/presentation/student/studentLayout/widget/subject_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MySubjectsScreen extends StatelessWidget {
  const MySubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'mysub'.tr(),
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
          Expanded(
            child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                // return SubjectItem(
                //     subject: cubit.subjects[index].subject.name,
                //     code: cubit.subjects[index].subject.code,
                //     lectDay: cubit.subjects[index].schedule.day,
                //     group: cubit.subjects[index].group.name,
                //     lecTime: '10:00',
                //     lectRoom: '211',
                //     secDay: 'sun',
                //     eng: 'sara',
                //     secTime: '11:00',
                //     secRoom: '210');
              },
            ),
          )
        ],
      ),
    );
  }
}
