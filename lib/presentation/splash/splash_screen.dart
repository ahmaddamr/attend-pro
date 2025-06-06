import 'package:attend_pro/presentation/onboarding/onboarding1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          PageTransition(
            child: const Onboarding1(),
            type: PageTransitionType.bottomToTop,
            duration: const Duration(milliseconds: 600),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF582C83), // Matches the purple in the screenshot
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            Image.asset(
              'assets/images/splashIcons/logo.png',
              width: 400.w,
              height: 400.h,
            ),
            const SizedBox(height: 16),
            // App Name
            // Text(
            //   'ATTEND PRO',
            //   style: GoogleFonts.montserrat(
            //     color: const Color(0xFF7AD9E7), // Blue-ish color like in the image
            //     fontWeight: FontWeight.bold,
            //     fontSize: 24,
            //     letterSpacing: 2,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
