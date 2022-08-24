import 'dart:convert';

import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/ancs/model/ancs_model.dart';
import 'package:aamako_maya/src/features/pnc/model/pnc_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    String token = "4a66f714-9124-4cd1-a0fa-e48789021600";
    final response = prefs.getString('pnc');

    if (response != null && isRefreshed == false) {
      final pncs = jsonDecode(response) as List;
      final data = pncs.map((e) => PncModel.fromJson(e)).toList();
      emit(PncSuccessState(data));
    } else {
      try {
        final response = await dio.get("${Urls.pncUrl}/$token");
        if (response.statusCode == 200) {
          final pncs = response.data as List;
          await prefs.setString('pnc', jsonEncode(pncs));

          List<PncModel> list =
              (pncs).map((e) => PncModel.fromJson(e)).toList();

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
  final List<PncModel> data;
  PncSuccessState(this.data);
  @override
  List<Object?> get props => [];
}

class PncLoadingState extends PncState {}

class PncFailureState extends PncState {}
