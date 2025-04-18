// ignore_for_file: must_be_immutable
import 'package:attend_pro/core/app_colors.dart';
import 'package:attend_pro/presentation/student/studentLayout/screens/announcments_screen.dart';
import 'package:attend_pro/presentation/student/studentLayout/screens/profile_screen.dart';
import 'package:attend_pro/presentation/student/studentLayout/screens/schedule_screen.dart';
import 'package:attend_pro/presentation/student/studentLayout/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../main.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const AnnouncmentsScreen(),
    const ScheduleScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    String? fname = prefs.getString('fname');
    String? lname = prefs.getString('lname');
    String? email = prefs.getString('email');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 80.h,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$fname $lname',
              style: GoogleFonts.montserrat(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              '42020106',
              style: GoogleFonts.montserrat(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.push(context, route)
            },
            icon: Icon(
              Icons.notifications_none_outlined,
              size: 40.sp,
              color: AppColors.color1,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(13.sp),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Ensure the container is circular
                  border: Border.all(
                    color: AppColors.color1, // Border color
                    width: 2.w, // Border width
                  ),
                ),
                child: CircleAvatar(
                  radius: 30.r,
                  backgroundColor: AppColors.color2,
                  child: Icon(
                    Icons.person,
                    size: 40.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppColors.color2, // Customize selected item color
        selectedFontSize: 14.sp,
        unselectedFontSize: 12.sp,
        showUnselectedLabels: false,

        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/icons/home-2.png',
              height: 30.h,
              color: _currentIndex == 0 ? AppColors.color2 : Colors.white,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/icons/Vector.png',
              height: 30.h,
              color: _currentIndex == 1 ? AppColors.color2 : Colors.white,
            ),
            label: 'Announcement',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/icons/shcedule.png',
              height: 30.h,
              color: _currentIndex == 2 ? AppColors.color2 : Colors.white,
            ),
            label: 'Schedule',
          ),
        ],
      ),
    );
  }
}
