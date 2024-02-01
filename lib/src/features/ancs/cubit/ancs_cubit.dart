import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/network_services/urls.dart';
import '../../authentication/local_storage/authentication_local_storage.dart';
import '../model/information_model.dart';
import '../model/new_report_model.dart';

class AncsCubit extends Cubit<AncsState> {
  Dio dio;
  SharedPreferences prefs;
  AuthLocalData local;
  AncsCubit(this.dio, this.local, this.prefs) : super(AncnitialState());

  void getAncs(bool isRefreshed) async {
    emit(AncLoadingState());
    // String token = await local.getTokenFromocal();
    final AuthLocalData _localData = AuthLocalData();
    String? token = await _localData.getTokenFromocal();

    final response = prefs.getString('anc_data');

    if (response != null && isRefreshed == false) {
      final ancs = jsonDecode(response);
      NewReportModel list = NewReportModel.fromJson(ancs);
      emit(AncSuccessState(list));
    } else {
      try {
        final response = await dio.get("${Urls.ancsUrls}", options:  Options(
          headers: {"token": "$token"},
        ));
        if (response.statusCode == 200) {
          prefs.setString('anc_data', jsonEncode(response.data));
          NewReportModel list = NewReportModel.fromJson(response.data);
          emit(AncSuccessState(list));
        } else {
          emit(AncFailureState());
        }
      } on DioError catch (e) {
        emit(AncFailureState());
      }
    }
  }


}

abstract class AncsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AncnitialState extends AncsState {}

class AncLoadingState extends AncsState {}

class AncSuccessState extends AncsState {
  final NewReportModel data;
  AncSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class AncFailureState extends AncsState {}
