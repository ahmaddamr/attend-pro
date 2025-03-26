import 'package:attend_pro/core/app_colors.dart';
import 'package:attend_pro/presentation/onboarding/onboarding1.dart';
import 'package:flutter/material.dart';
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
            duration: const Duration(seconds: 1),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color1,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/images/splashIcons/S1.png'),
          ),
          Image.asset('assets/images/splashIcons/S4.png')
        ],
      ),
    );
  }
}
