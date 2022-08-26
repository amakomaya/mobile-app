import 'dart:async';

import 'package:aamako_maya/src/core/cache/news_feed/cache_values.dart';
import 'package:aamako_maya/src/core/cache/videos_cache/cache_values.dart';
import 'package:aamako_maya/src/core/cache/weekly_cache/cache_values.dart';
import 'package:aamako_maya/src/features/authentication/authentication_cubit/auth_cubit.dart';
import 'package:aamako_maya/src/features/authentication/authentication_repository/authentication_repo.dart';
import 'package:aamako_maya/src/features/authentication/local_storage/authentication_local_storage.dart';
import 'package:aamako_maya/src/features/video/repository/videoes_repository.dart';
import 'package:aamako_maya/src/features/weekly_tips/repository/weekly_tips_repository.dart';
import 'package:dio/dio.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/core/connection_checker/network_connection.dart';
import 'src/features/ancs/cubit/ancs_cubit.dart';
import 'src/features/audio/cubit/audio_cubit.dart';
import 'src/features/authentication/authentication_cubit/logout_cubit.dart';
import 'src/features/authentication/cubit/district_municipality_cubit.dart';
import 'src/features/delivery/cubit/delivery_cubit.dart';
import 'src/features/faqs/cubit/faqs_cubit.dart';
import 'src/features/fetch user data/cubit/get_user_cubit.dart';
import 'src/features/home/cubit/newsfeed_cubit.dart';
import 'src/features/labtest/cubit/labtest_cubit.dart';
import 'src/features/medication/cubit/medication_cubit.dart';
import 'src/features/onboarding/bloc/onboard_bloc.dart';
import 'src/features/onboarding/onboarding_repository/onboarding_repository.dart';
import 'src/features/pnc/cubit/pnc_cubit.dart';
import 'src/features/symptoms/cubit/symptoms_cubit.dart';
import 'src/features/video/cubit/video_cubit.dart';
import 'src/features/weekly_tips/cubit/weekly_tips_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // register Blocs //
  sl.registerFactory<AuthenticationCubit>(
      () => AuthenticationCubit(sl(), sl(), sl(), sl()));

  sl.registerFactory<LoggedOutCubit>(() => LoggedOutCubit(sl()));

  sl.registerFactory<DeliverCubit>(() => DeliverCubit(sl(), sl(), sl()));
  sl.registerFactory<MedicationCubit>(() => MedicationCubit(sl(), sl(), sl()));
  sl.registerFactory<LabtestCubit>(() => LabtestCubit(sl(), sl(), sl()));
  sl.registerFactory<AncsCubit>(() => AncsCubit(sl(), sl(), sl()));
  sl.registerFactory<PncsCubit>(() => PncsCubit(sl(), sl(), sl()));
  sl.registerFactory<NewsfeedCubit>(() => NewsfeedCubit(sl(), sl(), sl()));
  sl.registerFactory<FaqsCubit>(() => FaqsCubit(sl(), sl()));
  sl.registerFactory<AudioCubit>(() => AudioCubit(sl(), sl()));
  sl.registerFactory<SymptomsCubit>(() => SymptomsCubit(sl(), sl(),sl()));
  sl.registerFactory<OnboardBloc>(() => OnboardBloc(repo: sl()));
  sl.registerFactory<WeeklyTipsCubit>(() =>
      WeeklyTipsCubit(repo: sl(), cache: sl(), network: sl(), prefs: sl()));
  sl.registerFactory<VideoCubit>(() => VideoCubit(sl(), sl(), sl()));
  sl.registerFactory<DistrictMunicipalityCubit>(()=>DistrictMunicipalityCubit(sl(),sl()));

  sl.registerFactory<GetUserCubit>(() => GetUserCubit(sl()));

  //??Repositories ??//
  sl.registerLazySingleton<OnboardingRepo>(() => OnboardingRepo(sl()));
  sl.registerLazySingleton<VideosRepo>(() => VideosRepo(sl(), sl()));
  sl.registerLazySingleton<WeeklyTipsRepo>(() => WeeklyTipsRepo(sl(), sl()));

  //Authentication Repository

  sl.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository(sl(), sl(), sl(),sl()));

       sl.registerLazySingleton<DistrictMunicipality>(
      () => DistrictMunicipality(sl(), sl(),));

  //??Repositories ??//

  //Authlocal Data
  sl.registerLazySingleton<WeeklyCachedValues>(() => WeeklyCachedValues());
  sl.registerLazySingleton<VideosCachedValues>(() => VideosCachedValues());
  sl.registerLazySingleton<NewsFeedCache>(() => NewsFeedCache());

  sl.registerLazySingleton<AuthLocalData>(() => AuthLocalData());

  // Register secure storage

  const FlutterSecureStorage secureStorage = FlutterSecureStorage();

  sl.registerLazySingleton<FlutterSecureStorage>(() => secureStorage);

  //Register Dio

  final Dio dio = Dio();
  sl.registerLazySingleton<Dio>(() => dio);

  //sharedPref
  SharedPreferences prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(
    () => prefs,
  );
  //internet_connection_checker
  final InternetConnectionChecker connectionChecker =
      InternetConnectionChecker();

  sl.registerLazySingleton(() => connectionChecker);

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}
