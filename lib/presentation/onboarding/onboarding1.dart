import 'package:attend_pro/core/app_colors.dart';
import 'package:attend_pro/core/widgets/custom_elevatedButton.dart';
import 'package:attend_pro/presentation/onboarding/onboarding2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animate_do/animate_do.dart';

class Onboarding1 extends StatefulWidget {
  const Onboarding1({super.key});

  @override
  State<Onboarding1> createState() => _Onboarding1State();
}

class _Onboarding1State extends State<Onboarding1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _imageAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _imageAnimation = Tween<Offset>(
      begin: const Offset(0, -0.02),
      end: const Offset(0, 0.02),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 85.sp,horizontal: 25.sp),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: 0.05 * _controller.value,
                      child: SlideTransition(
                        position: _imageAnimation,
                        child: child,
                      ),
                    );
                  },
                  child: Image.asset('assets/images/onboarding/on0.png'),
                ),
              ),
            ],
          ),
          Image.asset('assets/images/onboarding/On2.png',color: AppColors.color5,),

          /// **Fade-in text animation**
          Positioned(
            bottom: 220.sp,
            child: FadeInUp(
              duration: const Duration(milliseconds: 1100),
              child: const Text(
                'Keep your Attendance With\n Smart System Attendance',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          /// **Fade-in button animation**
          Positioned(
            bottom: 160.sp,
            child: FadeInUp(
              duration: const Duration(milliseconds: 1300),
              child: CustomElvatedButton(
                text: 'start'.tr(),
                backgroundColor: AppColors.color1,
                borderSideColor: Colors.transparent,
                style: TextStyle(color: Colors.white, fontSize: 24.sp),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: const Onboarding2(),
                      type: PageTransitionType.rightToLeft,
                      duration: const Duration(milliseconds: 600),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
