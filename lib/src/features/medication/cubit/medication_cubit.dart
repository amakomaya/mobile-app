import 'dart:convert';

import 'package:Amakomaya/src/core/network_services/urls.dart';
import 'package:Amakomaya/src/features/ancs/model/new_report_model.dart';
import 'package:Amakomaya/src/features/authentication/local_storage/authentication_local_storage.dart';
import 'package:Amakomaya/src/features/medication/model/medication_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ancs/model/information_model.dart';

class MedicationCubit extends Cubit<MedicationState> {
  final Dio dio;
  AuthLocalData local;
  SharedPreferences prefs;
  MedicationCubit(this.dio, this.local, this.prefs)
      : super(MedicationInitial());

  void getMedication(bool isRefreshed) async {
    emit(MedicationLoading());
    final AuthLocalData _localData = AuthLocalData();
    String? token = await _localData.getTokenFromocal();
    final response = prefs.getString('medication_data');
    if (response != null && isRefreshed == false) {
      final medication = jsonDecode(response);
      final data = NewReportModel.fromJson(medication);
      emit(MedicationSuccess(data));
    } else {
      try {
        final response = await dio.get("${Urls.medicationUrls}", options:  Options(
          headers: {"token": "$token"},
        ));
        if (response.statusCode == 200) {
          await prefs.setString('medication_data', jsonEncode(response.data));
          NewReportModel list = NewReportModel.fromJson(response.data);

          emit(MedicationSuccess(list));
        } else {
          emit(MedicationFailure());
        }
      } on DioError catch (_) {
        emit(MedicationFailure());
      }
    }
  }
}

abstract class MedicationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MedicationSuccess extends MedicationState {
  final NewReportModel data;
  MedicationSuccess(this.data);
  @override
  List<Object?> get props => [data];
}

class MedicationInitial extends MedicationState {}

class MedicationFailure extends MedicationState {}

class MedicationLoading extends MedicationState {}
