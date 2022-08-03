// import 'package:aamako_maya/localization/locale.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive/hive.dart';

// class AppLanguageCubit extends Cubit<Locale?> {
//   AppLanguageCubit() : super(null);

//   // void getLocale() async {
//   //   final hive = await Hive.openBox('languageBox');
//   //   final locale = await hive.get('language_code');
//   //   if (locale != null) {
//   //     emit(Locale(locale, ''));
//   //   } else {
//   //     emit(const Locale('en', ''));
//   //   }
//   // }

//   void changeLocale(String lang, context) async {
//     EasyLocalization.of(context)?.setLocale(Locale(lang));
//     // final hive = await Hive.openBox('languageBox');
//     // await hive.clear();
//     // await hive.put('language_code', lang);

//     // emit(Locale(lang, ''));
//   }
// }
