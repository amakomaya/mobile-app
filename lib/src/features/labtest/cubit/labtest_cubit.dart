import 'dart:convert';

import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/ancs/model/new_report_model.dart';
import 'package:aamako_maya/src/features/authentication/local_storage/authentication_local_storage.dart';
import 'package:aamako_maya/src/features/labtest/model/labtest_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ancs/model/information_model.dart';

class LabtestCubit extends Cubit<LabtestState> {
  Dio dio;
  SharedPreferences prefs;
  AuthLocalData local;
  LabtestCubit(this.dio, this.local, this.prefs) : super(LabtestInitial());

  void getlabtest(bool isRefreshed) async {
    emit(LabtestLoading());
    // String token = await local.getTokenFromocal();s
    final AuthLocalData _localData = AuthLocalData();
    String? token = await _localData.getTokenFromocal();
    final response = prefs.getString('labtest_data');
    if (response != null && isRefreshed == false) {
      final labtest = jsonDecode(response);
      final data =  NewReportModel.fromJson(labtest);
      emit(LabtestSuccess(data));
    } else {
      try {
        final response = await dio.get("${Urls.labtestUrls}", options:  Options(
          headers: {"token": "$token"},
        ));
        if (response.statusCode == 200) {
          prefs.setString('labtest_data', jsonEncode(response.data));
        NewReportModel list = NewReportModel.fromJson(response.data);
          emit(LabtestSuccess(list));
        } else {
          emit(LabtestFailure());
        }
      } on DioError catch (e) {
        emit(LabtestFailure());
      }
    }
  }


}

abstract class LabtestState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LabtestFailure extends LabtestState {}

class LabtestInitial extends LabtestState {}

class LabtestLoading extends LabtestState {}

class LabtestSuccess extends LabtestState {
  final NewReportModel data;

  LabtestSuccess(this.data);
  @override
  List<Object?> get props => [data];
}