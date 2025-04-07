import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text("choose".tr(),
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontSize: 20, fontWeight: FontWeight.normal)),
      trailing: const Icon(Icons.arrow_drop_down, size: 35),
      onTap: () => _showLanguageBottomSheet(context),
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("choose".tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 20, fontWeight: FontWeight.normal)),
              const SizedBox(height: 20),
              ListTile(
                title: const Text('English', textAlign: TextAlign.center),
                onTap: () {
                  context.setLocale(const Locale('en'));

                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('العربيه', textAlign: TextAlign.center),
                onTap: () {
                  context.setLocale(
                    const Locale('ar'),
                  );
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
