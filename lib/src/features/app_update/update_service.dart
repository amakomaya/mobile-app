import 'dart:io';

import 'package:Amakomaya/src/features/app_update/cubit/app_update_cubit.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as checker;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

import '../../../injection_container.dart';
import 'custom_dialog.dart';
import 'nav_service.dart';

class UpdateService {
  static const playStoreUrl = "https://play.google.com/store/apps/details?id=com.amakomaya_version2";
  static const appStoreUrl = "";

  static void check(PackageInfo packageInfo, {bool showMessageWhenNoUpdate = false}) {
    final updateCubit = sl<AppUpdateCubit>();
    final connectionStream =
        checker.InternetConnectionChecker().onStatusChange.listen((event) {
      if (event == checker.InternetConnectionStatus.connected) {
        updateCubit.getVersionCheck();
      }
    });

    updateCubit.stream.listen((state) {
      if (state is AppUpdateSuccessState) {
        print("here");
        connectionStream.cancel();
        final data = Platform.isAndroid ? state.data.android : state.data.ios;

        final isUnderMaintenance = data.updateAction == "under_maintenance";
        print("heresss");
        if (NavigationService.navigatorKey.currentContext == null) return;
        print("here asd");
        final canPop =
            data.updateAction == "no_action" || data.updateAction == "normal";
        var hasUpdate = _hasUpdate(data.version, data.updateAction, packageInfo.version);
        if (data.updateAction == "no_action") {
          hasUpdate = false;
        }

        //Showing dialog only if app [hasUpdate] or is stopped for maintenance
        if (hasUpdate || isUnderMaintenance) {
          showDialog(
            barrierDismissible: canPop,
            context: NavigationService.navigatorKey.currentContext!,
            barrierColor: Colors.black.withOpacity(0.75),
            builder: (context) {
              return WillPopScope(
                  onWillPop: () async {
                    return canPop;
                  },
                  child: CustomDialog(
                    message: data.message,
                    title: data.title,
                    showDismiss: canPop,
                    icon: Icons.system_update,
                    actionText: hasUpdate ? "Proceed" : '',
                    onAction: isUnderMaintenance
                        ? null
                        : () {
                            launcher.launch(Platform.isAndroid
                                ? playStoreUrl
                                : appStoreUrl);
                          },
                  ));
            },
          );
        } else if (showMessageWhenNoUpdate) {
          if ( NavigationService.navigatorKey.currentContext == null) return;
          FlushbarHelper.createInformation(
                  message: "App is already updated to the latest version",
                  duration: Duration(seconds: 30))
              .show( NavigationService.navigatorKey.currentContext!);
        }
      }
    });
  }


  static bool _hasUpdate(String latestVersion, String updateAction, String version) {
    if (updateAction == "no_action") return false;
    final currentVersion =  version;
    return _isNewVersionAvailable(
        currentVersion , latestVersion);
  }

  static bool _isNewVersionAvailable(
      String currentVersion, String newVersion) {
    final currentVersionArray =
        currentVersion.split('.').map((e) => int.tryParse(e) ?? 1).toList();
    final newVersionArray =
        newVersion.split('.').map((e) => int.tryParse(e) ?? 1).toList();
    for (int i = 0; i < currentVersionArray.length; i++) {
      if (currentVersionArray[i] < newVersionArray[i]) {
        return true;
      } else if (currentVersionArray[i] > newVersionArray[i]) {
        return false;
      } else {
        continue;
      }
    }

    return false;
  }
}
