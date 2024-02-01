import 'dart:convert';

import 'package:Amakomaya/src/core/network_services/urls.dart';
import 'package:Amakomaya/src/features/ancs/model/new_report_model.dart';
import 'package:Amakomaya/src/features/authentication/local_storage/authentication_local_storage.dart';
import 'package:Amakomaya/src/features/labtest/model/labtest_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ancs/model/information_model.dart';

class LabtestInfoCubit extends Cubit<LabtestInfoState> {
  Dio dio;
  SharedPreferences prefs;
  AuthLocalData local;
  LabtestInfoCubit(this.dio, this.local, this.prefs) : super(LabtestInitial());


  void getlabtestInfo(bool isRefreshed) async {
    emit(LabtestLoading());
    // String token = await local.getTokenFromocal();
    final AuthLocalData _localData = AuthLocalData();
    String? token = await _localData.getTokenFromocal();

    final response = prefs.getString('labtest_info_data');

    if (response != null && isRefreshed == false) {
      final ancs = jsonDecode(response);
      InformationModel list = InformationModel.fromJson(ancs);
      emit(LabtestInfoSuccessState(list));
    } else {
      try {
        final response = await dio.get("${Urls.labtestInfoUrls}", options:  Options(
          headers: {"token": "$token"},
        ));
        if (response.statusCode == 200) {
          prefs.setString('labtest_info_data', jsonEncode(response.data));
          InformationModel list = InformationModel.fromJson(response.data);
          emit(LabtestInfoSuccessState(list));
        } else {
          emit(LabtestFailure());
        }
      } on DioError catch (e) {
        emit(LabtestFailure());
      }
    }
  }

}

abstract class LabtestInfoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LabtestFailure extends LabtestInfoState {}

class LabtestInitial extends LabtestInfoState {}

class LabtestLoading extends LabtestInfoState {}

class LabtestInfoSuccessState extends LabtestInfoState {
  final InformationModel data;
  LabtestInfoSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}