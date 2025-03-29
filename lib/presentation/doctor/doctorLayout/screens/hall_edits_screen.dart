import 'dart:developer';

import 'package:attend_pro/core/widgets/custom_elevatedButton.dart';
import 'package:attend_pro/presentation/doctor/doctorLayout/screens/check_in_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/app_colors.dart';

class HallEditsScreen extends StatelessWidget {
  HallEditsScreen({super.key});
  var selectedValue;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'hall'.tr(),
          style: GoogleFonts.montserrat(
            textStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                'M103',
                style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 26.sp, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'course'.tr(),
                      style: GoogleFonts.montserrat(
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(
                                fontSize: 24.sp, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: AppColors.color2,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: AppColors.color2),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'group'.tr(),
                      style: GoogleFonts.montserrat(
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(
                                fontSize: 24.sp, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: AppColors.color2,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: AppColors.color2),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Group Number';
                            }
                            return null;
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'startt'.tr(),
                      style: GoogleFonts.montserrat(
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(
                                fontSize: 24.sp, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: AppColors.color2,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: AppColors.color2),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Start Time';
                            }
                            return null;
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'end'.tr(),
                      style: GoogleFonts.montserrat(
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(
                                fontSize: 24.sp, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: AppColors.color2,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: AppColors.color2),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter End Time';
                            }
                            return null;
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomElvatedButton(
                          text: 'Cancel',
                          backgroundColor: AppColors.color5,
                          borderSideColor: Colors.transparent,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontSize: 20.sp, fontWeight: FontWeight.w700),
                          onPressed: () {}),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Expanded(
                      child: CustomElvatedButton(
                          text: 'Start',
                          backgroundColor: AppColors.color1,
                          borderSideColor: Colors.transparent,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontSize: 20.sp, fontWeight: FontWeight.w700),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              log('valid');
                            } else {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                    child: const CheckInScreen(),
                                    type: PageTransitionType.theme,
                                    duration: const Duration(seconds: 1),
                                  ));
                              log('invalid');
                            }
                          }),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
//  Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: DropdownButtonFormField(
//                       borderRadius: BorderRadius.circular(20),
//                       decoration: const InputDecoration(
//                         labelText: "Select a Course",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(20)),
//                         ),
//                       ),
//                       value: selectedValue,
//                       items: ['1', '2', '3', '4', '5']
//                           .map((e) => DropdownMenuItem(
//                                 value: e,
//                                 child: Text(e),
//                               ))
//                           .toList(),
//                       onChanged: (value) 
//                       {
//                       },
//                       validator: (value) =>
//                           value == null ? "Please select a course" : '$value',
//                     ),
//                   ),
//                 ),
