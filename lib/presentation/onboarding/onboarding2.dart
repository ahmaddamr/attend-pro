import 'package:attend_pro/core/app_colors.dart';
import 'package:attend_pro/core/widgets/custom_elevatedButton.dart';
import 'package:attend_pro/presentation/onboarding/onboarding3.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

class Onboarding2 extends StatefulWidget {
  const Onboarding2({super.key});

  @override
  State<Onboarding2> createState() => _Onboarding2State();
}

class _Onboarding2State extends State<Onboarding2> {
  double _opacity = 0;
  double _imagePosition = 50;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1;
        _imagePosition = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: _opacity,
              child: Text(
                'A Modern Smart Attendance For Smart People',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            SizedBox(height: 16.h),
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              transform: Matrix4.translationValues(0, _imagePosition, 0),
              child: Padding(
                padding: EdgeInsets.all(8.sp),
                child: Image.asset('assets/images/onboarding/amico.png'),
              ),
            ),
            SizedBox(height: 28.h),
            AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: _opacity,
              child: Text(
                'choose'.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            SizedBox(height: 28.h),
            AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: _opacity,
              child: CustomElvatedButton(
                text: 'english'.tr(),
                backgroundColor: AppColors.color1,
                borderSideColor: Colors.transparent,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                onPressed: () {
                  context.setLocale(const Locale('en'));
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: const Onboarding3(),
                      type: PageTransitionType.rightToLeftWithFade,
                      duration: const Duration(milliseconds: 1000),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),
            AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: _opacity,
              child: CustomElvatedButton(
                text: 'arabic'.tr(),
                backgroundColor: AppColors.color5,
                borderSideColor: Colors.transparent,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                onPressed: () {
                  context.setLocale(const Locale('ar'));
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: const Onboarding3(),
                      type: PageTransitionType.rightToLeftWithFade,
                      duration: const Duration(milliseconds: 1000),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
