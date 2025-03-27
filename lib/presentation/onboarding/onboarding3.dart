import 'package:attend_pro/presentation/doctor/doctorLayout/doctorAuth/screens/doctor_register_screen.dart';
import 'package:attend_pro/presentation/student/studentLayout/auth/screen/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import '../../core/app_colors.dart';
import '../../core/widgets/custom_elevatedButton.dart';

class Onboarding3 extends StatefulWidget {
  const Onboarding3({super.key});

  @override
  State<Onboarding3> createState() => _Onboarding3State();
}

class _Onboarding3State extends State<Onboarding3>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _buttonSlideAnimation;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Fade-in animation for text
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Scale animation for image
    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Slide-in animation for buttons
    _buttonSlideAnimation = Tween<Offset>(
            begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward(); // Start animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Fade-in effect for title
            FadeTransition(
              opacity: _fadeInAnimation,
              child: Text(
                'Smart System Attendance',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            SizedBox(height: 70.h),

            // Scale-in animation for image
            ScaleTransition(
              scale: _scaleAnimation,
              child: Padding(
                padding: EdgeInsets.all(8.sp),
                child: Image.asset('assets/images/onboarding/pana.png'),
              ),
            ),
            SizedBox(height: 28.h),

            // Fade-in effect for subtitle
            FadeTransition(
              opacity: _fadeInAnimation,
              child: Text(
                'continue'.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            SizedBox(height: 28.h),

            // Slide-in effect for buttons
            SlideTransition(
              position: _buttonSlideAnimation,
              child: CustomElvatedButton(
                text: 'staff'.tr(),
                backgroundColor: AppColors.color1,
                borderSideColor: Colors.transparent,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                onPressed: () 
                {
                    Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child:  DoctorRegisterScreen(),
                      type: PageTransitionType.rightToLeftWithFade,
                      duration: const Duration(milliseconds: 1000),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),

            SlideTransition(
              position: _buttonSlideAnimation,
              child: CustomElvatedButton(
                text: 'student'.tr(),
                backgroundColor: AppColors.color5,
                borderSideColor: Colors.transparent,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: const LoginScreen(),
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
