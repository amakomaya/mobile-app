import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocalizationButton extends StatelessWidget {
  final Color? color;
  final Widget? icon;

  const LocalizationButton({Key? key, this.icon, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        child:icon?? ImageIcon(
          const AssetImage(
            "assets/images/language.png",
          ),
          size: 22.sm,
          color: color ?? Colors.red,
        ),
        itemBuilder: (ctx) {
          return [
            PopupMenuItem(
                onTap: ()  {
                   context.setLocale(const Locale('en', ''));
                },
                child: const Text('English')),
            PopupMenuItem(
                onTap: ()  {
                   context.setLocale(const Locale('ne', ''));
                },
                child: const Text('Nepali')),
          ];
        });
  }
}
