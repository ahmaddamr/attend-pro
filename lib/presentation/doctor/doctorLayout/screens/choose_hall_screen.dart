import 'package:attend_pro/core/app_colors.dart';
import 'package:attend_pro/presentation/doctor/doctorLayout/screens/hall_edits_screen.dart';
import 'package:attend_pro/presentation/manager/cubit/halls_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toastification/toastification.dart';

import '../widgets/hall_item.dart';

class ChooseHallScreen extends StatelessWidget {
  ChooseHallScreen({super.key});
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
      body: BlocProvider(
        create: (context) => HallsCubit()..getHalls(),
        child: BlocConsumer<HallsCubit, HallsState>(
          listener: (context, state) {
            if (state is HallsLoading) {
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
            if (state is HallsSuccess) {}
            if (state is HallsError) {
              Navigator.pop(context);
              toastification.show(
                context: context, // optional if you use ToastificationWrapper
                type: ToastificationType.error,
                style: ToastificationStyle.flat,
                autoCloseDuration: const Duration(seconds: 5),
                title: Text(state.msg),
              );
            }
          },
          builder: (context, state) {
            var cubit = HallsCubit.get(context);
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(14.sp),
                    child: TextFormField(
                      key: _formKey,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.color2,
                        suffixIcon: const Icon(Icons.search),
                        hintText: 'Search',
                        labelStyle: GoogleFonts.montserrat(
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontSize: 20.sp, fontWeight: FontWeight.w500),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.r),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 800.h,
                      child: GridView.builder(
                        itemCount: cubit.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10.h,
                            crossAxisSpacing: 10.w),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => Navigator.push(
                                context,
                                PageTransition(
                                  child: HallEditsScreen(
                                    location: cubit.data[index].location ?? '',
                                  ),
                                  type: PageTransitionType.theme,
                                  duration: const Duration(seconds: 1),
                                )),
                            child: HallItem(
                              hall: cubit.data[index].location ?? '',
                              status: cubit.data[index].status ?? '',
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
