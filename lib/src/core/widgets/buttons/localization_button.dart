import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../localization_cubit/localization_cubit.dart';

class LocalizationButton extends StatelessWidget {
  final Color? color;

  const LocalizationButton({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: ImageIcon(
          const AssetImage(
            "assets/images/language.png",
          ),
          color: color ?? Colors.red,
        ),
        itemBuilder: (ctx) {
          return [
            PopupMenuItem(
                onTap: () {
                  EasyLocalization.of(context)?.setLocale(Locale('en', ''));
                },
                child: Text('English')),
            PopupMenuItem(
                onTap: () {
                  EasyLocalization.of(context)?.setLocale(Locale('ne', ''));
                },
                child: Text('Nepali')),
          ];
        });
  }
}
