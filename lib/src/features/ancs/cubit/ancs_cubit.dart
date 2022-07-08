import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/ancs/model/ancs_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class AncsCubit extends Cubit<AncsState> {
  Dio dio;
  AncsCubit(this.dio) : super(AncsState(ancs: null));
  String token = 'jhf';
  void getAncs() async {
    try {
      final response = await dio.get(Urls.ancsUrl,
          options: Options(headers: {
            "token": token,
          }));
      if (response.statusCode == 200) {
        final ancs = response.data;

        List<AncModel> list =
            (ancs as List).map((e) => AncModel.fromJson(e)).toList();
        emit(AncsState(ancs: list));
      } else {
        emit(AncsState(ancs: state.ancs));
      }
    } catch (e) {
      emit(AncsState(ancs: state.ancs));
    }
  }
}

class AncsState extends Equatable {
  final List<AncModel>? ancs;
  const AncsState({this.ancs});
  @override
  List<Object?> get props => [];
}
