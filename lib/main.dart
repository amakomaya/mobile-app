import 'dart:collection';

import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/theme/custom_theme.dart';
import 'package:aamako_maya/src/features/authentication/cubit/register_cubit.dart';
import 'package:aamako_maya/src/features/authentication/cubit/toggle_district_municipality.dart';
import 'package:aamako_maya/src/features/authentication/local_storage/authentication_local_storage.dart';
import 'package:aamako_maya/src/features/authentication/repository/login_repository.dart';
import 'package:aamako_maya/src/features/authentication/repository/register_repository.dart';
import 'package:aamako_maya/src/features/authentication/screens/login/login_page.dart';
import 'package:aamako_maya/src/features/onboarding/bloc/onboard_bloc.dart';
import 'package:aamako_maya/src/features/onboarding/onboarding_repository/onboarding_repository.dart';
import 'package:aamako_maya/src/features/onboarding/screens/onboarding_page.dart';
import 'package:aamako_maya/src/features/splash/splash_page.dart';
import 'package:aamako_maya/src/features/weekly_tips/cubit/weekly_tips_cubit.dart';
import 'package:aamako_maya/src/features/weekly_tips/repository/weekly_tips_repository.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/features/authentication/cubit/district_municipality_cubit.dart';
import 'src/features/authentication/login_bloc/login_bloc.dart';
import 'src/features/authentication/register_bloc/register_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.primaryRed,
  ));
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<DistrictFieldToggleCubit>(
          create: (context) => DistrictFieldToggleCubit(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(
            LoginRepository(),AuthLocalData(),
          ),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(
            RegisterRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => OnboardBloc(repo: OnboardingRepo())
            ..add(const OnboardEvent.onboardStart()),
        ),
        BlocProvider(
          create: (context) => DistrictMunicipalityCubit(),
        ),
         BlocProvider(
          create: (context) => WeeklyTipsCubit(repo: WeeklyTipsRepo()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(414, 896),
      builder: (context, child) => Builder(builder: (context) {
        return MaterialApp(
          builder: BotToastInit(),
          navigatorObservers: [
            BotToastNavigatorObserver(),
          ],
          debugShowCheckedModeBanner: false,
          theme: CustomTheme.lightTheme,
          home: const SplashPage(),
          // home: ((show == null) || (show == true))
          //     ? BlocProvider<OnboardBloc>(
          //         create: (context) => OnboardBloc(repo: OnboardingRepo())
          //           ..add(const OnboardEvent.onboardStart()),
          //         child: BlocConsumer<OnboardBloc, OnboardState>(
          //           listener: (context, state) {},
          //           builder: (context, state) {
          //             return state.maybeWhen(
          //                 success: ((isLoading, error, onboardList) {
          //                   return const OnboardingPage();
          //                 }),
          //                 orElse: () => const LoginPage());
          //           },
          //         ),
          //       )
          //     : const LoginPage(),
        );
      }),
    );
  }
}
