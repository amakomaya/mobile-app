import 'dart:convert';

import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/authentication/local_storage/authentication_local_storage.dart';
import 'package:aamako_maya/src/features/medication/model/medication_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicationCubit extends Cubit<MedicationState> {
  final Dio dio;
  AuthLocalData local;
  SharedPreferences prefs;
  MedicationCubit(this.dio, this.local, this.prefs)
      : super(MedicationInitial());

  void getMedication(bool isRefreshed) async {
    emit(MedicationLoading());
    String token = '4a66f714-9124-4cd1-a0fa-e48789021600';
    final response = prefs.getString('medication');
    if (response != null && isRefreshed == false) {
      final medication = jsonDecode(response) as List;
      final data = medication.map((e) => Medicationmodel.fromJson(e)).toList();
      emit(MedicationSuccess(data));
    } else {
      try {
        final response = await dio.get("${Urls.medicationUrl}/$token");
        if (response.statusCode == 200) {
          final medication = response.data as List;
          await prefs.setString('medication', jsonEncode(medication));

          List<Medicationmodel> list =
              (medication).map((e) => Medicationmodel.fromJson(e)).toList();

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
  final List<Medicationmodel>? data;
  MedicationSuccess(this.data);
  @override
  List<Object?> get props => [data];
}

class MedicationInitial extends MedicationState {}

class MedicationFailure extends MedicationState {}

class MedicationLoading extends MedicationState {}
