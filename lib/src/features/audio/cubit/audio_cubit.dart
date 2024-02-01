import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/network_services/urls.dart';
import '../model/audio_model.dart';

class AudioCubit extends Cubit<AudioState> {
  final Dio _dio;
  final SharedPreferences _prefs;
  AudioCubit(Dio dio, SharedPreferences prefs)
      : _dio = dio,
        _prefs = prefs,
        super(AudioInitialState());

  void getAudio(bool isRefreshed) async {

    final response = _prefs.getString('audios');
    emit(AudioLoadingState());
    if (response != null && isRefreshed == false) {
      final audios = jsonDecode(response) as List;
      final data = audios.map((e) => AudioModel.fromJson(e)).toList();
      emit(AudioSuccessState(data,isRefreshed));
    } else {
      try {
        final Response response = await _dio.get(Urls.audiourl);
        if (response.statusCode == 200) {
          final audios = response.data as List;

          await _prefs.setString('audios', jsonEncode(audios));
          final List<AudioModel> data = (response.data as List)
              .map(
                (json) => AudioModel.fromJson(json),
              )
              .toList();
          emit(AudioSuccessState(data,isRefreshed));
        } else {
          emit(AudioFailureState());
        }
      } on DioError catch (_) {
        emit(AudioFailureState());
      }
    }
  }
}

abstract class AudioState extends Equatable {}

class AudioSuccessState extends AudioState {
  final List<AudioModel> data;
  final bool isRefreshed;
  AudioSuccessState(this.data,this.isRefreshed);

  @override
  List<Object?> get props => [data];
}

class AudioInitialState extends AudioState {
  @override
  List<Object?> get props => [];
}

class AudioFailureState extends AudioState {
  @override
  List<Object?> get props => [];
}

class AudioLoadingState extends AudioState {
  @override
  List<Object?> get props => [];
}
