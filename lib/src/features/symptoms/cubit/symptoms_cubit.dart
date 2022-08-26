import 'dart:convert';

import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/authentication/local_storage/authentication_local_storage.dart';
import 'package:aamako_maya/src/features/symptoms/model/symptoms_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SymptomsCubit extends Cubit<SymptomsState> {
  Dio dio;
  AuthLocalData local;
  SharedPreferences prefs;
  SymptomsCubit(this.dio, this.prefs, this.local) : super(SymptomsInitial());

  String token = "457-KEOKbxJgiveCQK4d";
  // /v1/woman-survey?token=457-KEOKbxJgiveCQK4d
  void getSymptoms(bool isRefreshed) async {
    final response = prefs.getString('symptoms');
    if (response != null && isRefreshed == false) {
      final res = jsonDecode(response);
      final symptoms =
          (res as List).map((e) => Symptomsmodel.fromJson(e)).toList();
      emit(SymptomsSuccess(symptoms));
    } else {
      emit(SymptomsLoading());
      print("${Urls.symptomsUrl}?token=$token");
      try {
        final response = await dio.get("${Urls.symptomsUrl}?token=$token");

        if (response.statusCode == 200) {
          final symptoms = response.data["pregnancy"] as List;
          //save to local
          await prefs.setString('symptoms', jsonEncode(symptoms));

          //end
          List<Symptomsmodel> list =
              (symptoms).map((e) => Symptomsmodel.fromJson(e)).toList();

          emit(SymptomsSuccess(list));
        } else {
          emit(SymptomsFailure());
        }
      } on DioError catch (_) {
        emit(SymptomsFailure());
      }
    }
  }
}

abstract class SymptomsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SymptomsSuccess extends SymptomsState {
  final List<Symptomsmodel> symptoms;
  SymptomsSuccess(this.symptoms);
  @override
  List<Object?> get props => [symptoms];
}

class SymptomsInitial extends SymptomsState {}

class SymptomsLoading extends SymptomsState {}

class SymptomsFailure extends SymptomsState {}
