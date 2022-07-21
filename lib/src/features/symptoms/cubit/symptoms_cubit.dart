import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/authentication/local_storage/authentication_local_storage.dart';
import 'package:aamako_maya/src/features/symptoms/model/symptoms_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class SymptomsCubit extends Cubit<SymptomsState> {
  Dio dio;
  AuthLocalData local;
  SymptomsCubit(this.dio, this.local)
      : super(SymptomsState(symptoms: null, error: null, loading: false));

  String token = "457-KEOKbxJgiveCQK4d";

  void getSymptoms() async {
    emit(SymptomsState(symptoms: null, loading: true, error: null));
    try {
      final response = await dio.get("${Urls.symptomsUrl}?token=$token");

      if (response.statusCode == 200) {
        final symptoms = response.data["pregnancy"] as List;
        List<Symptomsmodel> list =
            (symptoms).map((e) => Symptomsmodel.fromJson(e)).toList();

        emit(SymptomsState(symptoms: list, error: null, loading: false));
      } else {
        emit(SymptomsState(
            symptoms: state.symptoms, error: "error", loading: false));
      }
    } on DioError catch (e) {
      emit(SymptomsState(
          symptoms: state.symptoms, error: e.message, loading: false));
    }
  }
}

class SymptomsState extends Equatable {
  final bool loading;
  final String? error;
  List<Symptomsmodel>? symptoms;
  SymptomsState({this.symptoms, required this.error, required this.loading});
  @override
  List<Object?> get props => [loading, error, symptoms];
}
