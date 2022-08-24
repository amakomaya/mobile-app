import 'dart:convert';

import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/authentication/local_storage/authentication_local_storage.dart';
import 'package:aamako_maya/src/features/labtest/model/labtest_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LabtestCubit extends Cubit<LabtestState> {
  Dio dio;
  SharedPreferences prefs;
  AuthLocalData local;
  LabtestCubit(this.dio, this.local, this.prefs) : super(LabtestInitial());

  void getlabtest(bool isRefreshed) async {
    emit(LabtestLoading());
    // String token = await local.getTokenFromocal();s
    String token = "4a66f714-9124-4cd1-a0fa-e48789021600";

    final response = prefs.getString('labtest');
    if (response != null && isRefreshed == false) {
      final labtest = (jsonDecode(response) as List)
          .map((e) => Labtestmodel.fromJson(e))
          .toList();
      emit(LabtestSuccess(labtest));
    } else {
      try {
        final response = await dio.get("${Urls.labtestUrl}/$token");
        if (response.statusCode == 200) {
          final labtest = response.data as List;
          prefs.setString('labtest', jsonEncode(labtest));
          List<Labtestmodel> list =
              labtest.map((e) => Labtestmodel.fromJson(e)).toList();
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
  final List<Labtestmodel> data;

  LabtestSuccess(this.data);
  @override
  List<Object?> get props => [data];
}
