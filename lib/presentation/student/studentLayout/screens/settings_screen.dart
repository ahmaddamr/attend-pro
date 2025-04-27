import 'package:attend_pro/core/app_colors.dart';
import 'package:attend_pro/presentation/manager/provider/main_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/apptheme.dart';
import 'language_selection_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MainProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios,
                size: 35.sp, color: AppColors.color1)),
        backgroundColor: Colors.transparent,
        title: Text(
          'settings'.tr(),
          style: GoogleFonts.montserrat(
            textStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 31.sp, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
              provider.themeData == AppTheme().darkTheme
                  ? 'dark'.tr()
                  : 'light'.tr(),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 20, fontWeight: FontWeight.normal),
            ),
            trailing: Switch(
              activeColor: Colors.white,
              inactiveThumbColor: AppColors.color2,
              inactiveTrackColor: Colors.grey.shade400,
              value: provider.themeData == AppTheme().darkTheme,
              onChanged: (value) {
                provider.changeTheme(
                    value ? AppTheme().darkTheme : AppTheme().lightTheme);
              },
            ),
          ),
          const LanguageSelectionScreen()
        ],
      ),
    );
  }
}
