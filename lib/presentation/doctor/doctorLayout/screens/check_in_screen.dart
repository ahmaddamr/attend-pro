import 'package:attend_pro/presentation/doctor/doctorLayout/widgets/purple_data_log_item.dart';
import 'package:attend_pro/presentation/doctor/doctorLayout/widgets/student_check_in_data_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/widgets/custom_elevatedButton.dart';

class CheckInScreen extends StatelessWidget {
  const CheckInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100.h),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomElvatedButton(
                    text: 'Start Check-In',
                    backgroundColor: AppColors.color1,
                    borderSideColor: Colors.transparent,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: CustomElvatedButton(
                    text: 'End Check-In',
                    backgroundColor: AppColors.color5,
                    borderSideColor: Colors.transparent,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          const PurpleDataLogItem(
            status: 'Time',
          ),

          /// ✅ Ensure `Expanded` starts directly after `PurpleDataLogItem`
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero, // Remove any extra padding
              itemCount: 5,
              itemBuilder: (context, index) {
                return const StudentCheckInDataItem(
                  id: '42021106',
                  name: 'AhmedMoahmed',
                  status: '10:00',
                );
              },
            ),
          ),
          Expanded(
                  child: CustomElvatedButton(
                    text: 'Start Check-Out',
                    backgroundColor: AppColors.color1,
                    borderSideColor: Colors.transparent,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                    onPressed: () {},
                  ),
                ),
        ],
      ),
    );
  }
}
