import 'package:Amakomaya/src/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../l10n/locale_keys.g.dart';
import '../../core/widgets/popup_confirmation_page.dart';
import '../authentication/drawer_cubit/drawer_cubit.dart';
import 'cubit/cubit/navigation_index_cubit.dart';

Future<bool> showExitPopup(context) async {
  return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext userCtx) {
        return PopUpConfirmation(
          message: LocaleKeys.label_want_exit.tr(),
          onConfirmed: () {
            Navigator.of(context).pop(true);
          },
        );
      });
}
