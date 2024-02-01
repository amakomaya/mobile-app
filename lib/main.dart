
import 'package:Amakomaya/src/core/theme/app_colors.dart';
import 'package:Amakomaya/src/core/theme/custom_theme.dart';
import 'package:Amakomaya/src/features/ancs/cubit/ancs_info_cubit.dart';
import 'package:Amakomaya/src/features/app_update/nav_service.dart';
import 'package:Amakomaya/src/features/app_update/update_service.dart';
import 'package:Amakomaya/src/features/appointment_booking/cubit/appointment_booking_history_cubit.dart';
import 'package:Amakomaya/src/features/appointment_booking/cubit/booking_cubit.dart';
import 'package:Amakomaya/src/features/appointment_booking/cubit/scheme_cubit.dart';
import 'package:Amakomaya/src/features/appointment_booking/fonepay_payment/fonepay_payment_cubit.dart';
import 'package:Amakomaya/src/features/appointment_booking/screens/booking_page.dart';
import 'package:Amakomaya/src/features/authentication/cubit/select_district_municipality_cubit.dart';
import 'package:Amakomaya/src/features/authentication/cubit/toggle_district_municipality.dart';
import 'package:Amakomaya/src/features/delivery/cubit/delivery_cubit.dart';
import 'package:Amakomaya/src/features/delivery/cubit/delivery_info_cubit.dart';
import 'package:Amakomaya/src/features/faqs/cubit/faqs_cubit.dart';
import 'package:Amakomaya/src/features/labtest/cubit/labtest_cubit.dart';
import 'package:Amakomaya/src/features/labtest/cubit/labtest_info_cubit.dart';
import 'package:Amakomaya/src/features/medication/cubit/medication_cubit.dart';
import 'package:Amakomaya/src/features/medication/cubit/medication_info_cubit.dart';
import 'package:Amakomaya/src/features/onboarding/bloc/onboard_bloc.dart';
import 'package:Amakomaya/src/features/pnc/cubit/pnc_cubit.dart';
import 'package:Amakomaya/src/features/pnc/cubit/pnc_info_cubit.dart';
import 'package:Amakomaya/src/features/splash/splash_page.dart';
import 'package:Amakomaya/src/features/symptoms/cubit/symptoms_cubit.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'injection_container.dart';
import 'injection_container.dart' as di;
import 'src/features/ancs/cubit/ancs_cubit.dart';
import 'src/features/authentication/authentication_cubit/auth_cubit.dart';
import 'src/features/authentication/authentication_cubit/logout_cubit.dart';
import 'src/features/authentication/cubit/district_municipality_cubit.dart';
import 'src/features/authentication/drawer_cubit/drawer_cubit.dart';
import 'src/features/bottom_nav/cubit/cubit/navigation_index_cubit.dart';
import 'src/features/fetch user data/cubit/get_user_cubit.dart';
import 'src/features/home/cubit/newsfeed_cubit.dart';

late Box box;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appInit();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.primaryRed,
  ));
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(
    EasyLocalization(
      supportedLocales:  [
        Locale('en'),
        Locale('ne'),
      ],
      path: 'assets/l10n',
      fallbackLocale: const Locale('en'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<LoggedOutCubit>()),
          BlocProvider<DistrictFieldToggleCubit>(
            create: (context) => DistrictFieldToggleCubit(),
          ),
          BlocProvider(create: (context) => NavigationIndexCubit()),
          BlocProvider(create: (context) => sl<SymptomsCubit>()),
          BlocProvider(create: (context) => sl<DeliverCubit>()),
          BlocProvider(create: (context) => sl<DeliverInfoCubit>()),
          BlocProvider(create: (context) => sl<MedicationCubit>()),
          BlocProvider(create: (context) => sl<MedicationInfoCubit>()),
          BlocProvider(create: (context) => sl<LabtestCubit>()),
          BlocProvider(create: (context) => sl<LabtestInfoCubit>()),
          BlocProvider(create: (context) => sl<AncsCubit>()),
          BlocProvider(create: (context) => sl<AncsInfoCubit>()),
          BlocProvider(create: (context) => sl<AuthenticationCubit>()),
          BlocProvider(create: (context) => sl<BookingCubit>()),
          BlocProvider(create: (context) => sl<AppointmentBookingHistoryCubit>()),
          BlocProvider(create: (context) => sl<FonePayPaymentCubit>()),
          BlocProvider(create: (context) => sl<PncsCubit>()),
          BlocProvider(create: (context) => sl<PncsInfoCubit>()),
          BlocProvider(create: (context) => sl<NewsfeedCubit>()),
          BlocProvider(create: (context) => sl<GetUserCubit>()),
          BlocProvider(create: (context) => sl<FaqsCubit>()),
          // BlocProvider(create: (context) => sl<AudioCubit>()),
          BlocProvider(create: (context) => SelectDistrictMunicipalityCubit()),
          BlocProvider(
              create: (context) => DrawerCubit()..checkDrawerSelection(0)),
          BlocProvider(create: (context) => sl<SymptomsCubit>()),
          BlocProvider(
            create: (context) =>
                sl<OnboardBloc>()..add(const OnboardEvent.onboardStart()),
          ),
          // BlocProvider(
          //     create: (context) => AppLanguageCubit()),
          BlocProvider(
            create: (context) => sl<DistrictMunicipalityCubit>(),
          ),
          BlocProvider(
            create: (context) => sl<SchemeCubit>(),
          ),
          // BlocProvider(
          //   create: (context) => sl<WeeklyTipsCubit>(),
          // ),
          // BlocProvider(
          //   create: (context) => sl<VideoCubit>(),
          // ),
        ],
        child: const MyApp(),
      ),
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
          navigatorKey: NavigationService.navigatorKey,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
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

Future appInit() async {
  await Hive.initFlutter();
  await EasyLocalization.ensureInitialized();
  di.init();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  UpdateService.check(packageInfo);
}