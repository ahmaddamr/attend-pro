import 'package:attend_pro/core/app_colors.dart';
import 'package:attend_pro/presentation/doctor/doctorLayout/screens/doctor_announcments_data_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class DoctorAnnouncmentsScreen extends StatelessWidget {
  const DoctorAnnouncmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'announcements'.tr(),
            style: GoogleFonts.montserrat(
              textStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: Container(
              padding: EdgeInsets.all(20.sp),
              decoration: BoxDecoration(
                color: AppColors.color2, // Dark background
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "What's On Your Mind ?",
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.color1,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'Choose Subject',
                                style: GoogleFonts.montserrat(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.w700),
                                ),
                              ),
                              content: SizedBox(
                                height: 200.h, // Limiting height for ListView
                                width: double.maxFinite, // Expanding width
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                  child:
                                                      const DoctorAnnouncmentsDataScreen(),
                                                  type:
                                                      PageTransitionType.theme,
                                                  duration: const Duration(
                                                      milliseconds: 900),
                                                ),
                                              );
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 8.0),
                                                  child: Text(
                                                    'DataBase',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      textStyle: Theme.of(
                                                              context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .copyWith(
                                                              fontSize: 18.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 8.0),
                                                  child: Text(
                                                    'G:1',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      textStyle: Theme.of(
                                                              context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .copyWith(
                                                              fontSize: 18.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                        const Divider(),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Close"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text(
                        "Send To",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
