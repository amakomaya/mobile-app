import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/ancs/model/ancs_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../authentication/local_storage/authentication_local_storage.dart';

class AncsCubit extends Cubit<AncsState> {
  Dio dio;
  AuthLocalData local;
  AncsCubit(this.dio, this.local)
      : super(const AncsState(ancs: null, error: null, loading: false));
  void getAncs() async {
    emit(const AncsState(ancs: null, loading: true, error: null));
    // String token = await local.getTokenFromocal();s
    String token = "4a66f714-9124-4cd1-a0fa-e48789021600";
    try {
      final response = await dio.get("${Urls.ancsUrl}/$token");
      if (response.statusCode == 200) {
        debugPrint(response.data.toString() + 'ANCS');
        final ancs = response.data as List;

        List<AncModel> list = (ancs).map((e) => AncModel.fromJson(e)).toList();
        debugPrint(list.toString() + 'ANCS success');

        emit(AncsState(ancs: list, error: null, loading: false));
      } else {
        emit(AncsState(ancs: state.ancs, error: 'Error', loading: false));
        debugPrint(response.data.toString() + 'ANCS');
      }
    } on DioError catch (e) {
      debugPrint(e.toString() + 'ANCS dio');

      emit(AncsState(ancs: state.ancs, error: e.message, loading: false));
    }
  }
}

class AncsState extends Equatable {
  final bool loading;
  final String? error;
  final List<AncModel>? ancs;
  const AncsState(
      {required this.ancs, required this.loading, required this.error});
  @override
  List<Object?> get props => [loading, error, ancs];
}
