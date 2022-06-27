import 'dart:async';

import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/features/authentication/local_storage/authentication_local_storage.dart';
import 'package:aamako_maya/src/features/authentication/screens/login/login_page.dart';
import 'package:aamako_maya/src/features/onboarding/screens/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

import '../../core/constant/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../bottom_nav/bottom_navigation.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthLocalData _localData = AuthLocalData();
  _checkIfOnboard() async {
    try {
      String? token = await _localData.getTokenFromocal();

      if (token == null || token.isEmpty) {
        var box = await Hive.openBox(Consts.hive_box);
        final bool? onboard =
            await box.get(Consts.hive_box_onboard_key) as bool?;
        if (onboard == false || onboard == null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const OnboardingPage(),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ));
        }
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (ctx) => const CustomBottomNavigation()),
          (route) => false,
        );
      }
    } catch (e) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ));
    }
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 2), () => _checkIfOnboard());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryRed,
        body: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 3,
                ),
                Image.asset(
                  "assets/images/logo/logo_white.png",
                  height: 363.w,
                  width: 363.h,
                 scale: 1.0,
                ),
                VerticalSpace(20.h),
                Text('Making Pregnancy Healthy and Happy',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.white,
                        )),
                Spacer(
                  flex: 7,
                ),
              ],
            )),
      ),
    );
  }
}
