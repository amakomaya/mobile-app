import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/authentication/local_storage/authentication_local_storage.dart';
import 'package:aamako_maya/src/features/labtest/model/labtest_model.dart';
import 'package:aamako_maya/src/features/pnc/model/pnc_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class LabtestCubit extends Cubit<labtestState> {
  Dio dio;
  AuthLocalData local;
  LabtestCubit(this.dio, this.local)
      : super(labtestState(labtest: null, error: null, loading: false));

  void getlabtest() async {
    emit(labtestState(labtest: null, loading: true, error: null));
    // String token = await local.getTokenFromocal();s
    String token = "4a66f714-9124-4cd1-a0fa-e48789021600";
    try {
      final response = await dio.get("${Urls.labtestUrl}/$token");
      if (response.statusCode == 200) {
        final labtest = response.data as List;
        List<Labtestmodel> list =
            labtest.map((e) => Labtestmodel.fromJson(e)).toList();
        emit(labtestState(labtest: list, error: null, loading: false));
      } else {
        emit(labtestState(
            labtest: state.labtest, error: 'Error', loading: false));
      }
    } on DioError catch (e) {
      emit(labtestState(
          labtest: state.labtest, error: e.message, loading: false));
    }
  }
}

class labtestState extends Equatable {
  final bool loading;
  final String? error;
  final List<Labtestmodel>? labtest;
  const labtestState(
      {required this.labtest, required this.loading, required this.error});
  @override
  List<Object?> get props => [loading, error, labtest];
}
