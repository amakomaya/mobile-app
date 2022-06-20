import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/theme/custom_theme.dart';
import 'package:aamako_maya/src/features/authentication/screens/login_page.dart';
import 'package:aamako_maya/src/features/onboarding/bloc/onboard_bloc.dart';
import 'package:aamako_maya/src/features/onboarding/onboarding_repository/onboarding_repository.dart';
import 'package:aamako_maya/src/features/onboarding/screens/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

bool? show;
Future<void> main() async {
  await Hive.initFlutter(); //initialize Hive database
  var box = await Hive.openBox('myBox');
  show = box.get('onboard');
  print('show ' + show.toString());

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.primaryRed, // status bar color
  ));
  runApp(
    const MyApp(),
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
          debugShowCheckedModeBanner: false,
          theme: CustomTheme.lightTheme,
          home: ((show == null) || (show == true))
              ? BlocProvider<OnboardBloc>(
                  create: (context) => OnboardBloc(repo: OnboardingRepo())
                    ..add(const OnboardEvent.onboardStart()),
                  child: BlocConsumer<OnboardBloc, OnboardState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return state.maybeWhen(
                          success: ((isLoading, error, onboardList) {
                            return const OnboardingPage();
                          }),
                          orElse: () => const LoginPage());
                    },
                  ),
                )
              : const LoginPage(),
        );
      }),
    );
  }
}
