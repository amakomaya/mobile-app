import 'dart:convert';
import 'package:Amakomaya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../l10n/locale_keys.g.dart';
import '../../../core/padding/padding.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/buttons/primary_action_button.dart';
import '../../authentication/drawer_cubit/drawer_cubit.dart';
import '../../bottom_nav/bottom_navigation.dart';
import '../../bottom_nav/cubit/cubit/navigation_index_cubit.dart';
import 'fonepay_payment_cubit.dart';

class PaymentConfirmationPage extends StatelessWidget {
  final String status;

  const PaymentConfirmationPage(this.status, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primaryRed,
              title: Text(
                "Fonepay Confirmation",
                style: TextStyle(fontSize: 16.sm, fontFamily: 'lato'),
              ),
            ),
            body: ShadowContainer(
              margin: REdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: REdgeInsets.symmetric(horizontal: 10, vertical: 10),
              radius: 25,
              height: 250.h,
              color: Colors.white,
              child: Container(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/success.png',
                      height: 70.w,
                      width: 70.w,
                      // colorBlendMode: BlendMode.darken,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Appointment Booked Successfully!",
                      style: TextStyle(fontSize: 18.sm, fontWeight: FontWeight.w700, fontFamily: 'lato'),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: defaultPadding,
                      child: PrimaryActionButton(
                        padding: REdgeInsets.symmetric(vertical: 20),
                        onpress: () {
                          context
                              .read<DrawerCubit>()
                              .checkDrawerSelection(0);

                          context
                              .read<NavigationIndexCubit>()
                              .changeIndex(
                              index: 0,
                              titleEn: 'Home',
                              titleNp: "होम");
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) =>
                                    const CustomBottomNavigation()),
                            (route) => false,
                          );
                        },
                        title: "Go to Home",
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
