import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/theme/custom_theme.dart';
import 'package:aamako_maya/src/features/authentication/cache/cache_values.dart';
import 'package:aamako_maya/src/features/authentication/cubit/register_cubit.dart';
import 'package:aamako_maya/src/features/authentication/cubit/toggle_district_municipality.dart';
import 'package:aamako_maya/src/features/authentication/local_storage/authentication_local_storage.dart';
import 'package:aamako_maya/src/features/authentication/repository/login_repository.dart';
import 'package:aamako_maya/src/features/authentication/repository/register_repository.dart';
import 'package:aamako_maya/src/features/authentication/screens/login/login_page.dart';
import 'package:aamako_maya/src/features/delivery/cubit/delivery_cubit.dart';
import 'package:aamako_maya/src/features/faqs/cubit/faqs_cubit.dart';
import 'package:aamako_maya/src/features/labtest/cubit/labtest_cubit.dart';
import 'package:aamako_maya/src/features/medication/cubit/medication_cubit.dart';
import 'package:aamako_maya/src/features/onboarding/bloc/onboard_bloc.dart';
import 'package:aamako_maya/src/features/onboarding/onboarding_repository/onboarding_repository.dart';
import 'package:aamako_maya/src/features/onboarding/screens/onboarding_page.dart';
import 'package:aamako_maya/src/features/pnc/cubit/pnc_cubit.dart';
import 'package:aamako_maya/src/features/splash/splash_page.dart';
import 'package:aamako_maya/src/features/symptoms/cubit/symptoms_cubit.dart';
import 'package:aamako_maya/src/features/video/cubit/video_cubit.dart';
import 'package:aamako_maya/src/features/weekly_tips/cubit/weekly_tips_cubit.dart';
import 'package:aamako_maya/src/features/weekly_tips/repository/weekly_tips_repository.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/features/ancs/cubit/ancs_cubit.dart';
import 'src/features/audio/cubit/audio_cubit.dart';
import 'src/features/authentication/cubit/district_municipality_cubit.dart';
import 'src/features/authentication/login_bloc/login_bloc.dart';
import 'src/features/authentication/qr_code_cubit/qr_code_cubit.dart';
import 'src/features/authentication/register_bloc/register_bloc.dart';
import 'src/features/home/cubit/newsfeed_cubit.dart';
import 'src/features/video/repository/videoes_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // WidgetsBinding.instance?.addObserver(const AudioPlayerWidget());

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
            create: (context) => SymptomsCubit(Dio(), AuthLocalData())),
        BlocProvider(create: (context) => DeliverCubit(Dio(), AuthLocalData())),
        BlocProvider(
            create: (context) => MedicationCubit(Dio(), AuthLocalData())),
        BlocProvider(create: (context) => LabtestCubit(Dio(), AuthLocalData())),
        BlocProvider(create: (context) => AncsCubit(Dio(), AuthLocalData())),
        BlocProvider(create: (context) => QrCodeCubit(Dio(), AuthLocalData())),
        BlocProvider(create: (context) => PncsCubit(Dio(), AuthLocalData())),
        BlocProvider(
            create: (context) => NewsfeedCubit(
                  Dio(),
                )),
        BlocProvider(
          create: (context) => LoginBloc(
            LoginRepository(),
            AuthLocalData(),
          ),
        ),
        BlocProvider(create: (context) => FaqsCubit(Dio())),
        BlocProvider(create: (context) => AudioCubit(Dio())),
        BlocProvider(
          create: (context) =>
              RegisterBloc(RegisterRepository(), AuthLocalData()),
        ),
        BlocProvider(
            create: (context) => SymptomsCubit((Dio()), (AuthLocalData()))),
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
        BlocProvider(
          create: (context) => VideoCubit(VideosRepo()),
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
        );
      }),
    );
  }
}
