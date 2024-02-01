import 'dart:convert';

import 'package:Amakomaya/src/core/network_services/urls.dart';
import 'package:Amakomaya/src/features/ancs/model/ancs_model.dart';
import 'package:Amakomaya/src/features/ancs/model/new_report_model.dart';
import 'package:Amakomaya/src/features/pnc/model/pnc_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ancs/model/information_model.dart';
import '../../authentication/local_storage/authentication_local_storage.dart';

class PncsInfoCubit extends Cubit<PncInfoState> {
  Dio dio;
  AuthLocalData local;
  SharedPreferences prefs;
  PncsInfoCubit(this.dio, this.local, this.prefs) : super(PncInitial());

  void getPncsInfo(bool isRefreshed) async {
    emit(PncLoadingState());
    // String token = await local.getTokenFromocal();
    final AuthLocalData _localData = AuthLocalData();
    String? token = await _localData.getTokenFromocal();

    final response = prefs.getString('pnc_info_data');

    if (response != null && isRefreshed == false) {
      final ancs = jsonDecode(response);
      InformationModel list = InformationModel.fromJson(ancs);
      emit(PncInfoSuccessState(list));
    } else {
      try {
        final response = await dio.get("${Urls.pncInfoUrls}", options:  Options(
          headers: {"token": "$token"},
        ));
        if (response.statusCode == 200) {
          prefs.setString('pnc_info_data', jsonEncode(response.data));
          InformationModel list = InformationModel.fromJson(response.data);
          emit(PncInfoSuccessState(list));
        } else {
          emit(PncFailureState());
        }
      } on DioError catch (e) {
        emit(PncFailureState());
      }
    }
  }

}

abstract class PncInfoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PncInitial extends PncInfoState {}


class PncLoadingState extends PncInfoState {}

class PncFailureState extends PncInfoState {}
class PncInfoSuccessState extends PncInfoState {
  final InformationModel data;
  PncInfoSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}