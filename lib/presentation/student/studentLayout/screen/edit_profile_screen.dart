import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/widgets/custom_elevatedButton.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios,
                size: 35.sp, color: AppColors.color1)),
        backgroundColor: Colors.transparent,
        title: Text(
          'edprofile'.tr(),
          style: GoogleFonts.montserrat(
            textStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 31.sp, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 60.r,
                      backgroundColor: AppColors.color1,
                      child: Icon(
                        Icons.person,
                        size: 40.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 160.w,
                    child: InkWell(
                        onTap: () {
                          // Handle image selection
                        },
                        child: Image.asset('assets/images/icons/addPhoto.png')),
                  ),
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
              Text(
                'First Name',
                style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
                ),
              ),
              TextFormField(decoration: const InputDecoration()),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Last Name',
                style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
                ),
              ),
              TextFormField(decoration: const InputDecoration()),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'E-Mail',
                style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
                ),
              ),
              TextFormField(decoration: const InputDecoration()),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Phone Number',
                style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
                ),
              ),
              TextFormField(decoration: const InputDecoration()),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Password',
                style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
                ),
              ),
              TextFormField(decoration: const InputDecoration()),
              SizedBox(
                height: 80.h,
              ),
              CustomElvatedButton(
                  text: 'save'.tr(),
                  backgroundColor: AppColors.color1,
                  borderSideColor: Colors.transparent,
                  style: GoogleFonts.montserrat(
                    textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 21.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                  onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
