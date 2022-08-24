import 'dart:convert';

import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/ancs/model/ancs_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../authentication/local_storage/authentication_local_storage.dart';

class AncsCubit extends Cubit<AncsState> {
  Dio dio;
  SharedPreferences prefs;
  AuthLocalData local;
  AncsCubit(this.dio, this.local, this.prefs) : super(AncnitialState());
  void getAncs(bool isRefreshed) async {
    emit(AncLoadingState());
    // String token = await local.getTokenFromocal();
    String token = "4a66f714-9124-4cd1-a0fa-e48789021600";

    final response = prefs.getString('anc');

    if (response != null && isRefreshed == false) {
      final ancs = jsonDecode(response) as List;

      List<AncModel> list = (ancs).map((e) => AncModel.fromJson(e)).toList();
      emit(AncSuccessState(list));
    } else {
      try {
        final response = await dio.get("${Urls.ancsUrl}/$token");
        if (response.statusCode == 200) {
          final ancs = response.data as List;

          prefs.setString('anc', jsonEncode(response.data));

          List<AncModel> list =
              (ancs).map((e) => AncModel.fromJson(e)).toList();
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
  final List<AncModel> data;
  AncSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class AncFailureState extends AncsState {}
