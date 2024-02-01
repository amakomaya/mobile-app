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

class AncsInfoCubit extends Cubit< AncsInfoState> {
  Dio dio;
  SharedPreferences prefs;
  AuthLocalData local;
  AncsInfoCubit(this.dio, this.local, this.prefs) : super(AncnitialState());

  void getAncsInfo(bool isRefreshed) async {
    emit(AncLoadingState());
    // String token = await local.getTokenFromocal();
    final AuthLocalData _localData = AuthLocalData();
    String? token = await _localData.getTokenFromocal();

    final response = prefs.getString('anc_info_data');

    if (response != null && isRefreshed == false) {
      final ancs = jsonDecode(response);
      InformationModel list = InformationModel.fromJson(ancs);
      emit(AncInfoSuccessState(list));
    } else {
      try {
        final response = await dio.get("${Urls.ancsInfoUrls}", options:  Options(
          headers: {"token": "$token"},
        ));
        if (response.statusCode == 200) {
          prefs.setString('anc_info_data', jsonEncode(response.data));
          InformationModel list = InformationModel.fromJson(response.data);
          emit(AncInfoSuccessState(list));
        } else {
          emit(AncFailureState());
        }
      } on DioError catch (e) {
        emit(AncFailureState());
      }
    }
  }

}

abstract class AncsInfoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AncnitialState extends AncsInfoState {}

class AncLoadingState extends AncsInfoState {}


class AncInfoSuccessState extends AncsInfoState {
  final InformationModel data;
  AncInfoSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class AncFailureState extends AncsInfoState {}
