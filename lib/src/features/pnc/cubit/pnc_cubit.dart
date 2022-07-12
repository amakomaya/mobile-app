import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/ancs/model/ancs_model.dart';
import 'package:aamako_maya/src/features/pnc/model/pnc_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../authentication/local_storage/authentication_local_storage.dart';

class PncsCubit extends Cubit<PncState> {
  Dio dio;
  AuthLocalData local;
  PncsCubit(this.dio, this.local)
      : super(const PncState(pncs: null, error: null, loading: false));
  void getPncs() async {
    emit(const PncState(pncs: null, loading: true, error: null));
    // String token = await local.getTokenFromocal();s
    String token = "4a66f714-9124-4cd1-a0fa-e48789021600";
    try {
      final response = await dio.get("${Urls.pncUrl}/$token");
      if (response.statusCode == 200) {
        debugPrint(response.data.toString() + 'pncs');
        final pncs = response.data as List;

        List<PncModel> list = (pncs).map((e) => PncModel.fromJson(e)).toList();
        debugPrint(list.toString() + 'pncs success');

        emit(PncState(pncs: list, error: null, loading: false));
      } else {
        emit(PncState(pncs: state.pncs, error: 'Error', loading: false));
        debugPrint(response.data.toString() + 'pncs');
      }
    } on DioError catch (e) {
      debugPrint(e.toString() + 'pncs dio');

      emit(PncState(pncs: state.pncs, error: e.message, loading: false));
    }
  }
}

class PncState extends Equatable {
  final bool loading;
  final String? error;
  final List<PncModel>? pncs;
  const PncState(
      {required this.pncs, required this.loading, required this.error});
  @override
  List<Object?> get props => [loading, error, pncs];
}
