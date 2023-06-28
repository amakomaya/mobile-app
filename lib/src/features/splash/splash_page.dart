import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/features/authentication/local_storage/authentication_local_storage.dart';
import 'package:aamako_maya/src/features/authentication/screens/login/login_page.dart';
import 'package:aamako_maya/src/features/onboarding/screens/onboarding_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

import '../../../l10n/locale_keys.g.dart';
import '../../core/constant/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../authentication/authentication_cubit/auth_cubit.dart';
import '../bottom_nav/bottom_navigation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        var box = await Hive.openBox('myBox');
        final bool? onboard = await box.get('onboard') as bool?;
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
        context.read<AuthenticationCubit>().loginWithToken(token);
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
    _checkIfOnboard();

    super.initState();
  }

  @override
  void dispose() {
    Hive.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is LoginSuccessfulState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (ctx) => const CustomBottomNavigation()),
            (route) => false,
          );
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ));
        }
      },
      child: SafeArea(
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
                    width: 363.w,
                    scale: 1.0,
                  ),
                  VerticalSpace(20.h),
                  Text(LocaleKeys.label_pregnancy_healthy.tr() ,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Colors.white,
                          )),
                  Spacer(
                    flex: 7,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
