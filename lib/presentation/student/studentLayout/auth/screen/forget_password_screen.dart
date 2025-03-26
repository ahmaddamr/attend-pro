import 'package:attend_pro/presentation/student/studentLayout/auth/screen/login_screen.dart';
import 'package:attend_pro/presentation/student/studentLayout/auth/screen/verification_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../../core/app_colors.dart';
import '../../../../../core/widgets/custom_elevatedButton.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

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
                child: const LoginScreen(),
                type: PageTransitionType.rightToLeft,
                duration: const Duration(milliseconds: 900),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        toolbarHeight: 80.h,
        title: Text(
          'Forget Password',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 32.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.color2,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/splashIcons/bro.png'),
            SizedBox(
              height: 91.h,
            ),
            SizedBox(
              width: 358.w,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(color: AppColors.color2),
                  hintText: 'user@gmail.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColors.color2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: AppColors.color2, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Email';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 35.h,
            ),
            CustomElvatedButton(
                text: 'Send',
                backgroundColor: AppColors.color1,
                borderSideColor: Colors.transparent,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: const VerificationCodeScreen(),
                      type: PageTransitionType.leftToRight,
                      duration: const Duration(milliseconds: 900),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
