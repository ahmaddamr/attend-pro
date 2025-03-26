import 'package:attend_pro/presentation/student/studentLayout/auth/screen/forget_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../../core/app_colors.dart';
class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 17.sp),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 35,
              color: AppColors.color2,
            ),
            onPressed: () => Navigator.pop(
              context,
              PageTransition(
                child: const ForgetPasswordScreen(),
                type: PageTransitionType.rightToLeft,
                duration: const Duration(milliseconds: 900),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        toolbarHeight: 80.h,
        title: Text(
          'Verification',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 32.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.color2,
              ),
        ),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        OtpTextField(
          numberOfFields: 5,
          borderColor: Colors.transparent,
          enabledBorderColor: Colors.transparent,
          focusedBorderColor: Colors.transparent,
          filled: true,
          fillColor: AppColors.color2,
          //set to true to show as box or false to show as dash
          showFieldAsBox: true,
          //runs when a code is typed in
          onCodeChanged: (String code) {
            //handle validation or checks here
          },
          //runs when every textfield is filled
          onSubmit: (String verificationCode) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Verification Code"),
                    content: Text('Code entered is $verificationCode'),
                  );
                });
          }, // end onSubmit
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Didn’t Recieve Code?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff919191),
                    ),
              ),
              InkWell(
                onTap: () => {},
                child: Text(
                  ' Resend',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.color2,
                      ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
