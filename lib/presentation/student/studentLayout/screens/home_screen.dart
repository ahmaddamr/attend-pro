import 'dart:async';
import 'package:attend_pro/presentation/student/studentLayout/screens/subjects_screen.dart';
import 'package:attend_pro/presentation/student/studentLayout/screens/warning_screen.dart';
import 'package:attend_pro/presentation/student/studentLayout/widget/attendace_item.dart';
import 'package:attend_pro/presentation/student/studentLayout/widget/custom_service_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../widget/carousel_slider_widget.dart';
import '../widget/custom_home_container.dart';
import 'attendance_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: const AttendanceScreen(),
                              type: PageTransitionType.rightToLeft,
                              duration: const Duration(milliseconds: 300)));
                    },
                    child: CustomServiceWidget(
                        img: 'assets/images/icons/attend.png',
                        title: 'attendance'.tr()),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: const SubjectsScreen(),
                              type: PageTransitionType.rightToLeft,
                              duration: const Duration(milliseconds: 300)));
                    },
                    child:  CustomServiceWidget(
                        img: 'assets/images/icons/subject.png',
                        title: 'subject'.tr()),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: const WarningScreen(),
                              type: PageTransitionType.rightToLeft,
                              duration: const Duration(milliseconds: 300)));
                    },
                    child:  CustomServiceWidget(
                        img: 'assets/images/icons/warning.png',
                        title: 'warnings'.tr()),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'previous'.tr(),
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
              SizedBox(
                height: 1000.h,
                child: ListView.builder(
                  // shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const AttendaceItem(
                        txt: 'Network', date: '15/10/2024');
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
