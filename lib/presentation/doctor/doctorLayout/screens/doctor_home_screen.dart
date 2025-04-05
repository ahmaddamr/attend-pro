import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../../../student/studentLayout/widget/carousel_slider_widget.dart';
import '../../../student/studentLayout/widget/custom_home_container.dart';
import '../widgets/custom_doctor_service_widget.dart';
import 'attendance_logs_screen.dart';
import 'choose_hall_screen.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  final ScrollController _scrollController = ScrollController();
  late Timer _timer;
  List<String> imgs = [
    'assets/images/icons/slider1.png',
    'assets/images/icons/slider2.png',
    'assets/images/icons/slider3.png',
    'assets/images/icons/slider4.png',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_scrollController.hasClients) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.position.pixels;
        double nextScroll = currentScroll + 350; // Adjust step size
        if (nextScroll > maxScroll) {
          _scrollController.jumpTo(0);
        } else {
          _scrollController.animateTo(
            nextScroll,
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'upcoming'.tr(),
                style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomHomeContainer(
                child: SizedBox(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemBuilder: (context, index) => CarouselSliderWidget(
                      img: imgs[index],
                    ),
                    itemCount: imgs.length, // Number of items
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'services'.tr(),
                style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        PageTransition(
                          child: const AttendanceLogsScreen(),
                          type: PageTransitionType.theme,
                          duration: const Duration(seconds: 1),
                        )),
                    child: CustomDoctorServiceWidget(
                      img: 'assets/images/icons/service1.png',
                      title: 'logs'.tr(),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        PageTransition(
                          child:  ChooseHallScreen(),
                          type: PageTransitionType.theme,
                          duration: const Duration(seconds: 1),
                        )),
                    child:  CustomDoctorServiceWidget(
                        img: 'assets/images/icons/service1.png',
                        title: 'hall'.tr()),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
