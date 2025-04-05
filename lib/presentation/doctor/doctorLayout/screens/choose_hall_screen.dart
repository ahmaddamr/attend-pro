import 'package:attend_pro/core/app_colors.dart';
import 'package:attend_pro/presentation/doctor/doctorLayout/screens/hall_edits_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../widgets/hall_item.dart';

class ChooseHallScreen extends StatelessWidget {
   ChooseHallScreen({super.key});
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'hall'.tr(),
          style: GoogleFonts.montserrat(
            textStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 800.h,
                child: GridView.builder(
                  itemCount: 10,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10.h,
                      crossAxisSpacing: 10.w),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.push(
                          context,
                          PageTransition(
                            child:  HallEditsScreen(),
                            type: PageTransitionType.theme,
                            duration: const Duration(seconds: 1),
                          )),
                      child: const HallItem(
                        hall: 'M103',
                        status: 'empty',
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
