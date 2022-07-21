import 'dart:math';

import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/authentication/local_storage/authentication_local_storage.dart';
import 'package:aamako_maya/src/features/medication/model/medication_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class MedicationCubit extends Cubit<MedicationState> {
  final Dio dio;
  AuthLocalData local;
  MedicationCubit(this.dio, this.local)
      : super(MedicationState(medication: null, error: null, loading: false));

  void getMedication() async {
    emit(MedicationState(medication: null, loading: true, error: null));
    String token = '4a66f714-9124-4cd1-a0fa-e48789021600';
    try {
      final response = await dio.get("${Urls.medicationUrl}/$token");
      if (response.statusCode == 200) {
        final medication = response.data as List;

        List<Medicationmodel> list =
            (medication).map((e) => Medicationmodel.fromJson(e)).toList();

        emit(MedicationState(medication: list, error: null, loading: false));
      } else {
        emit(MedicationState(
            medication: state.medication, error: 'Error', loading: false));
      }
    } on DioError catch (e) {
      emit(MedicationState(
          medication: state.medication, error: e.message, loading: false));
    }
  }
}

class MedicationState extends Equatable {
  List<Medicationmodel>? medication;
  final String? error;
  final bool loading;

  MedicationState(
      {required this.medication, required this.error, required this.loading});
  @override
  List<Object?> get props => [medication, error, loading];
}
