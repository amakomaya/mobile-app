import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/theme/custom_theme.dart';
import 'package:aamako_maya/src/features/authentication/authentication_repository/authentication_repo.dart';
import 'package:aamako_maya/src/features/authentication/cache/cache_values.dart';
import 'package:aamako_maya/src/features/authentication/cubit/register_cubit.dart';
import 'package:aamako_maya/src/features/authentication/cubit/toggle_district_municipality.dart';
import 'package:aamako_maya/src/features/authentication/local_storage/authentication_local_storage.dart';
import 'package:aamako_maya/src/features/authentication/screens/login/login_page.dart';
import 'package:aamako_maya/src/features/card/card_cubit.dart';
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
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'injection_container.dart';
import 'src/features/ancs/cubit/ancs_cubit.dart';
import 'src/features/audio/cubit/audio_cubit.dart';
import 'src/features/authentication/authentication_cubit/auth_cubit.dart';
import 'src/features/authentication/cubit/district_municipality_cubit.dart';
import 'src/features/authentication/drawer_cubit/drawer_cubit.dart';
import 'src/features/bottom_nav/cubit/cubit/navigation_index_cubit.dart';
import 'src/features/home/cubit/newsfeed_cubit.dart';
import 'src/features/video/repository/videoes_repository.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding?.ensureInitialized();
  // await FlutterDownloader.initialize(debug: true, ignoreSsl: true);

  await Hive.initFlutter();
  // WidgetsBinding.instance?.addObserver(const AudioPlayerWidget());

  //initialize get_it
  di.init();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.primaryRed,
  ));

  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  HydratedBlocOverrides.runZoned(
      () => runApp(
            MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => sl<LoggedOutCubit>()),
                BlocProvider<DistrictFieldToggleCubit>(
                  create: (context) => DistrictFieldToggleCubit(),
                ),
                BlocProvider(create: (context) => NavigationIndexCubit()),
                BlocProvider(create: (context) => sl<SymptomsCubit>()),
                BlocProvider(create: (context) => sl<DeliverCubit>()),
                BlocProvider(create: (context) => sl<MedicationCubit>()),
                BlocProvider(create: (context) => sl<LabtestCubit>()),
                BlocProvider(create: (context) => sl<AncsCubit>()),
                BlocProvider(create: (context) => sl<AuthenticationCubit>()),
                BlocProvider(create: (context) => sl<PncsCubit>()),
                BlocProvider(
                    create: (context) => sl<NewsfeedCubit>(
                         
                        )),
                BlocProvider(create: (context) => sl<FaqsCubit>()),
                BlocProvider(create: (context) => sl<AudioCubit>()),
                BlocProvider(
                    create: (context) =>
                        DrawerCubit()..checkDrawerSelection(0)),
                BlocProvider(create: (context) => sl<SymptomsCubit>()),
                BlocProvider(
                  create: (context) =>
                      sl<OnboardBloc>()..add(const OnboardEvent.onboardStart()),
                ),
                BlocProvider(
                  create: (context) => DistrictMunicipalityCubit(),
                ),
                BlocProvider(
                  create: (context) => sl<WeeklyTipsCubit>(),
                ),
                BlocProvider(
                  create: (context) => sl<VideoCubit>(),
                ),
              ],
              child: const MyApp(),
            ),
          ),
      storage: storage);
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
