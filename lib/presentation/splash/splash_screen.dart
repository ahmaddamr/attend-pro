import 'package:attend_pro/core/app_colors.dart';
import 'package:attend_pro/presentation/onboarding/onboarding1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_fonts/google_fonts.dart';

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
            duration: const Duration(seconds: 1),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF705D9C),   // Deep purple
              Color(0xFFBFA5E3),   // Soft lavender
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/images/splashIcons/image1.png',
              width: 300.w,
              height: 150.h,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 32),
            // App Title
            Text(
              "Attend Pro",
              style: GoogleFonts.montserrat(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 24),
            // Subtle progress indicator for style
            // const CircularProgressIndicator(
            //   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            //   strokeWidth: 3,
            // ),
          ],
        ),
      ),
    );
  }
}