import 'package:attend_pro/presentation/manager/cubit/auth_cubit.dart';
import 'package:attend_pro/presentation/manager/provider/main_provider.dart';
import 'package:attend_pro/presentation/splash/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  runApp(
    ChangeNotifierProvider(
      create: (context) => MainProvider(),
      child: EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('ar')],
          path:
              'assets/translations', // <-- change the path of the translation files
          fallbackLocale: const Locale('en'),
          child: const AttendPro()),
    ),
  );
}

class AttendPro extends StatelessWidget {
  const AttendPro({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MainProvider>(context);
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: ScreenUtilInit(
        designSize: const Size(430, 750),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: provider.themeData,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
