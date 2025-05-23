import 'package:attend_pro/core/app_colors.dart';
import 'package:attend_pro/core/widgets/custom_elevatedButton.dart';
import 'package:attend_pro/presentation/doctor/doctorLayout/Auth/screens/doctor_login_screen.dart';
import 'package:attend_pro/presentation/manager/cubit/auth_cubit/auth_cubit.dart';
import 'package:attend_pro/presentation/student/studentLayout/auth/widget/custom_divider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toastification/toastification.dart';

class DoctorRegisterScreen extends StatelessWidget {
  DoctorRegisterScreen({super.key});
  final _doctorformKey = GlobalKey<FormState>();
  final RegExp _htiEmailRegex = RegExp(r'^[0-9]+@hti\.edu\.eg$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color1,
      resizeToAvoidBottomInset: true, // Prevents overflow when keyboard appears
      body: SafeArea(
        child: Stack(
          children: [
            /// **Main Content (Background or Logo)**
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 100.h),
                  child: Text(
                    'ATTEND PRO',
                    style: GoogleFonts.montserrat(
                      color: const Color(
                          0xFF7AD9E7), // Blue-ish color like in the image
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                // Image.asset('assets/images/onboarding/On1.png'),
                Expanded(child: Container()), // Pushes everything up
              ],
            ),

            /// **Bottom Container (Registration Form)**
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                  height: 550.h,
                  width: double.infinity,
                  duration: const Duration(seconds: 1),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is StaffSignLoading) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              content: Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.color1,
                                ),
                              ),
                            );
                          },
                        );
                      }
                      if (state is StaffSignFailure) {
                        Navigator.pop(context);
                        toastification.show(
                          context:
                              context, // optional if you use ToastificationWrapper
                          type: ToastificationType.error,
                          style: ToastificationStyle.flat,
                          autoCloseDuration: const Duration(seconds: 5),
                          title: Text(state.msg),
                        );
                      }
                      if (state is StaffSignSuccess) {
                        Navigator.pop(context);
                        toastification.show(
                          context:
                              context, // optional if you use ToastificationWrapper
                          type: ToastificationType.success,
                          style: ToastificationStyle.flat,
                          autoCloseDuration: const Duration(seconds: 5),
                          title: const Text('Email Sent Success!'),
                        );
                      }
                    },
                    builder: (context, state) {
                      var cubit = BlocProvider.of<AuthCubit>(context);
                      return Padding(
                        padding: EdgeInsets.all(25.sp),
                        child: SingleChildScrollView(
                          // Allows only form scrolling
                          child: Form(
                            key: _doctorformKey,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'create'.tr(),
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w600,
                                          // color: AppColors.color2,
                                        ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    'Welcome To Your App!\n Start Your Journey Now',
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff919191),
                                        ),
                                  ),
                                  SizedBox(height: 10.h),

                                  TextFormField(
                                    controller: cubit.email,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: 18.sp,
                                          ),
                                      hintText: 'user@gmail.com',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: AppColors
                                                .color2), // Default border color
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: AppColors.color2,
                                            width: 2), // When focused
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your Email';
                                      }
                                      // else if (!_htiEmailRegex.hasMatch(value)) {
                                      //   return 'Invalid Hti Email';
                                      // }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 10.h),

                                  /// **Email Field**
                                  TextFormField(
                                    controller: cubit.uniEmail,
                                    decoration: InputDecoration(
                                      labelText: 'Uni Email',
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: 18.sp,
                                          ),
                                      hintText: 'user@gmail.com',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: AppColors
                                                .color2), // Default border color
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: AppColors.color2,
                                            width: 2), // When focused
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your Email';
                                      } else if (!_htiEmailRegex
                                          .hasMatch(value)) {
                                        return 'Invalid Hti Email';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 15.h),

                                  TextFormField(
                                    controller: cubit.password,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: 18.sp,
                                          ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: AppColors.color2)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: AppColors.color2,
                                            width: 2), // When focused
                                      ),
                                    ),
                                    obscureText: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      } else if (value.length < 7) {
                                        return 'Password must be more than 6 characters';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        width: 175.w,
                                        child: TextFormField(
                                          controller: cubit.firstName,
                                          decoration: InputDecoration(
                                            labelText: 'First Name',
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  fontSize: 18.sp,
                                                ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  color: AppColors
                                                      .color2), // Default border color
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  color: AppColors.color2,
                                                  width: 2), // When focused
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your Email';
                                            }
                                            // else if (!_htiEmailRegex.hasMatch(value)) {
                                            //   return 'Invalid Hti Email';
                                            // }
                                            return null;
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 175.w,
                                        child: TextFormField(
                                          controller: cubit.lastName,
                                          decoration: InputDecoration(
                                            labelText: 'Last Name',
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  fontSize: 18.sp,
                                                ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  color: AppColors
                                                      .color2), // Default border color
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  color: AppColors.color2,
                                                  width: 2), // When focused
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your Email';
                                            }
                                            // else if (!_htiEmailRegex.hasMatch(value)) {
                                            //   return 'Invalid Hti Email';
                                            // }
                                            return null;
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 15.h),

                                  /// **Phone Number Field**
                                  TextFormField(
                                    controller: cubit.phone,
                                    decoration: InputDecoration(
                                      labelText: 'Phone Number',
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: 18.sp,
                                          ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: AppColors.color2)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: AppColors.color2,
                                            width: 2), // When focused
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your phone number';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 15.h),
                                  // **Password Field**

                                  SizedBox(
                                    height: 32.h,
                                  ),
                                  CustomElvatedButton(
                                      text: 'register'.tr(),
                                      backgroundColor: AppColors.color1,
                                      borderSideColor: Colors.transparent,
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                      onPressed: () {
                                        // Navigator.pushReplacement(
                                        //   context,
                                        //   PageTransition(
                                        //     child: const LayoutScreen(),
                                        //     type:
                                        //         PageTransitionType.topToBottom,
                                        //     duration: const Duration(
                                        //         milliseconds: 900),
                                        //   ),
                                        // );
                                        if (_doctorformKey.currentState!
                                            .validate()) {
                                          // Perform sign-up action
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text('Processing Data'),
                                            ),
                                          );
                                          cubit.staffSignUp();
                                        }
                                      }),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  const CustomDivider(),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'already'.tr(),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xff919191),
                                            ),
                                      ),
                                      InkWell(
                                        onTap: () => Navigator.pushReplacement(
                                          context,
                                          PageTransition(
                                            child:
                                                const DoctorLoginScreen(), // Replace with your login screen
                                            type: PageTransitionType.theme,
                                            duration:
                                                const Duration(seconds: 1),
                                          ),
                                        ),
                                        child: Text(
                                          'login'.tr(),
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
