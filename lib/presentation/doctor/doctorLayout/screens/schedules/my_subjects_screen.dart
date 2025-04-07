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
                return const SubjectItem(
                    lectDay: 'sunday',
                    dr: 'Ahmed',
                    lecTime: '12:30',
                    lectRoom: '108',
                    secDay: 'saturday',
                    eng: 'ali',
                    secTime: '1:30',
                    secRoom: '112',
                    subject: 'DataBase');
              },
            ),
          )
        ],
      ),
    );
  }
}
