import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordResetWidget extends StatelessWidget {
  const PasswordResetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFF333333),
      ),
      padding: const EdgeInsets.fromLTRB(10, 13, 22, 31),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 40.sp),
                    child: Image.asset(
                      'assets/images/icons/success.png',
                      width: 64.w,
                      height: 64.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40.sp),
                    child: const Text(
                      'successeful',
                      style: TextStyle(
                        color: Color(0xFF58287F),
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 6.w),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 14),
            child: Text(
              'congratulations your password changed successfully click continue to login',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF9B9B9B),
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF58287F),
                borderRadius: BorderRadius.circular(3),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 12,
              ),
              constraints: const BoxConstraints(
                minHeight: 40,
              ),
              child: const Text(
                'Continue',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
