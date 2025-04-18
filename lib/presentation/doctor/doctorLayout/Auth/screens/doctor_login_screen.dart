import 'package:attend_pro/core/app_colors.dart';
import 'package:attend_pro/core/widgets/custom_elevatedButton.dart';
import 'package:attend_pro/presentation/doctor/doctorLayout/screens/doctor_layout_screen.dart';
import 'package:attend_pro/presentation/manager/cubit/auth_cubit/auth_cubit.dart';
import 'package:attend_pro/presentation/student/studentLayout/auth/screen/forget_password_screen.dart';
import 'package:attend_pro/presentation/student/studentLayout/auth/screen/register_screen.dart';
import 'package:attend_pro/presentation/student/studentLayout/auth/widget/custom_divider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toastification/toastification.dart';

class DoctorLoginScreen extends StatefulWidget {
  const DoctorLoginScreen({super.key});

  @override
  State<DoctorLoginScreen> createState() => _DoctorLoginScreenState();
}

class _DoctorLoginScreenState extends State<DoctorLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false; // Manages password visibility
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
              children: [
                // Image.asset('assets/images/onboarding/On1.png'),
                Expanded(child: Container()), // Pushes everything up
              ],
            ),

            /// **Bottom Container (Login Form)**
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
                      if (state is LoginLoading) {
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
                      if (state is LoginStaffSuccess) {
                        Navigator.pop(context);
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return const DoctorLayoutScreen();
                          },
                        ));
                        toastification.show(
                          context:
                              context, // optional if you use ToastificationWrapper
                          type: ToastificationType.success,
                          style: ToastificationStyle.flat,
                          autoCloseDuration: const Duration(seconds: 5),
                          title: const Text('Login Success!'),
                        );
                      }
                      if (state is LoginFailure) {
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
                    },
                    builder: (context, state) {
                    AuthCubit cubit = AuthCubit.get(context);
                      return Padding(
                        padding: EdgeInsets.all(25.sp),
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'login'.tr(),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  'Welcome Doctor',
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
                                SizedBox(height: 10.h),

                                /// **Email Field**
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
                                    hintText: 'name@gmail.com',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: AppColors.color2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: AppColors.color2, width: 2),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your Email';
                                    } 
                                    return null;
                                  },
                                ),

                                SizedBox(height: 15.h),

                                /// **Password Field with Show/Hide Feature**
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
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: AppColors.color2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: AppColors.color2, width: 2),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppColors.color2,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isPasswordVisible =
                                              !_isPasswordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                  obscureText: !_isPasswordVisible,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    } else if (value.length < 7) {
                                      return 'Password must be more than 6 characters';
                                    }
                                    return null;
                                  },
                                ),
                                InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    PageTransition(
                                      child: const ForgetPasswordScreen(),
                                      type: PageTransitionType.theme,
                                      duration:
                                          const Duration(milliseconds: 900),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'forget'.tr(),
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
                                ),

                                SizedBox(height: 32.h),

                                /// **Login Button**
                                CustomElvatedButton(
                                    text: 'login'.tr(),
                                    backgroundColor: AppColors.color1,
                                    borderSideColor: Colors.transparent,
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        // Perform sign-up action
                                        // PasswordResetWidget();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text('Processing Data'),
                                          ),
                                        );
                                        cubit.login();
                                        cubit.email.clear();
                                        cubit.password.clear();
                                      }
                                    }),
                                SizedBox(height: 15.h),

                                /// **OR Divider**
                                const CustomDivider(),
                                SizedBox(height: 15.h),

                                /// **Register Option**
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'dont'.tr(),
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
                                          child: RegisterScreen(),
                                          type: PageTransitionType.theme,
                                          duration: const Duration(seconds: 1),
                                        ),
                                      ),
                                      child: Text(
                                        'register'.tr(),
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
