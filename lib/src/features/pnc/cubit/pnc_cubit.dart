import 'dart:convert';

import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/ancs/model/ancs_model.dart';
import 'package:aamako_maya/src/features/ancs/model/new_report_model.dart';
import 'package:aamako_maya/src/features/pnc/model/pnc_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ancs/model/information_model.dart';
import '../../authentication/local_storage/authentication_local_storage.dart';

class PncsCubit extends Cubit<PncState> {
  Dio dio;
  AuthLocalData local;
  SharedPreferences prefs;
  PncsCubit(this.dio, this.local, this.prefs) : super(PncInitial());
  void getPncs(bool isRefreshed) async {
    emit(PncLoadingState());
    // String token = await local.getTokenFromocal();
    // print(token);
    final AuthLocalData _localData = AuthLocalData();
    String? token = await _localData.getTokenFromocal();
    final response = prefs.getString('pnc_data');

    if (response != null && isRefreshed == false) {
      final pncs = jsonDecode(response) ;
      final data = NewReportModel.fromJson(pncs);
      emit(PncSuccessState(data));
    } else {
      try {
        final response = await dio.get("${Urls.pncUrls}", options:  Options(
          headers: {"token": "$token"},
        ));
        if (response.statusCode == 200) {
          final pncs = response.data ;
          await prefs.setString('pnc_data', jsonEncode(pncs));
         NewReportModel list = NewReportModel.fromJson(pncs);
          emit(PncSuccessState(list));
        } else {
          emit(PncFailureState());
        }
      } on DioError catch (_) {
        emit(PncFailureState());
      }
    }
  }

}

abstract class PncState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PncInitial extends PncState {}

class PncSuccessState extends PncState {
  final NewReportModel data;
  PncSuccessState(this.data);
  @override
  List<Object?> get props => [];
}

class PncLoadingState extends PncState {}

class PncFailureState extends PncState {}