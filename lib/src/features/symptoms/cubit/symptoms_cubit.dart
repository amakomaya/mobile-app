import 'dart:convert';

import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/authentication/local_storage/authentication_local_storage.dart';
import 'package:aamako_maya/src/features/symptoms/model/assessment_model.dart';
import 'package:aamako_maya/src/features/symptoms/model/symptoms_model.dart';
import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SymptomsCubit extends Cubit<SymptomsState> {
  Dio dio;
  AuthLocalData local;
  SharedPreferences prefs;

  SymptomsCubit(this.dio, this.prefs, this.local) : super(SymptomsInitial());

  postSymptoms(List<DeliveryModel> data, String? selectedValue,
      String other_symptoms) async {
    var token = await local.getTokenFromocal();
    final formData = FormData();

    /// type

    formData.fields.add(MapEntry(
        'health_condition',
        selectedValue == 'Postnatal'
            ? '3'
            : selectedValue == 'Delivery'
                ? '2'
                : '1'));

    /// other symptoms
    formData.fields.add(MapEntry(
        'other_symptoms', other_symptoms.isEmpty ? "None" : "$other_symptoms"));

    data.forEach((element) {
      formData.fields
          .add(MapEntry(element.key, element.isSelected ? '1' : '0'));
    });
    try {
      final response = await dio.post("${Urls.symptomsUrl}",
          data: formData,
          options: Options(
            headers: {"token": "$token"},
          ));
      if (response.statusCode == 200)
        return (response.data);
      else {
        throw ApiException(response.data.toString());
      }
    } on DioError catch (e) {
      throw ApiException(e.message);
    }
  }

  void getSymptoms(bool isRefreshed) async {
    var token = await local.getTokenFromocal();
    final response = prefs.getString('symptoms_history');

    if (response != null && isRefreshed == false) {
      final res = jsonDecode(response);
      final symptoms =
          (res as List).map((e) => Symptomsmodel.fromJson(e)).toList();
      emit(SymptomsSuccess(symptoms));
    } else {
      emit(SymptomsLoading());
      try {
        final response = await dio.get("${Urls.symptomsUrl}",
            options: Options(
              headers: {"token": "$token"},
            ));
        if (response.statusCode == 200) {
          final symptoms = response.data as List;
          //save to local
          await prefs.setString('symptoms_history', jsonEncode(symptoms));
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

class ApiException implements Exception {
  final String message;

  ApiException(this.message);
}
