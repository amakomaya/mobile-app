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

class MedicationInfoCubit extends Cubit<MedicationInfoState> {
  final Dio dio;
  AuthLocalData local;
  SharedPreferences prefs;
  MedicationInfoCubit(this.dio, this.local, this.prefs)
      : super(MedicationInitial());

  void getMedicationInfo(bool isRefreshed) async {
    emit(MedicationLoading());
    // String token = await local.getTokenFromocal();
    final AuthLocalData _localData = AuthLocalData();
    String? token = await _localData.getTokenFromocal();

    final response = prefs.getString('medication_info_data');

    if (response != null && isRefreshed == false) {
      final ancs = jsonDecode(response);
      InformationModel list = InformationModel.fromJson(ancs);
      emit(MedicationInfoSuccessState(list));
    } else {
      try {
        final response = await dio.get("${Urls.medicationInfoUrls}", options:  Options(
          headers: {"token": "$token"},
        ));
        if (response.statusCode == 200) {
          prefs.setString('medication_info_data', jsonEncode(response.data));
          InformationModel list = InformationModel.fromJson(response.data);
          emit(MedicationInfoSuccessState(list));
        } else {
          emit(MedicationFailure());
        }
      } on DioError catch (e) {
        emit(MedicationFailure());
      }
    }
  }
}

abstract class MedicationInfoState extends Equatable {
  @override
  List<Object?> get props => [];
}


class MedicationInitial extends MedicationInfoState {}

class MedicationFailure extends MedicationInfoState {}

class MedicationLoading extends MedicationInfoState {}
class MedicationInfoSuccessState extends MedicationInfoState {
  final InformationModel data;
  MedicationInfoSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}