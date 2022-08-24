import 'dart:convert';

import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/audio/model/audio_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioCubit extends Cubit<AudioState> {
  final Dio _dio;
  final SharedPreferences _prefs;
  AudioCubit(Dio dio, SharedPreferences prefs)
      : _dio = dio,
        _prefs = prefs,
        super(AudioInitialState());

  void getAudio(bool isRefreshed) async {
    emit(AudioLoadingState());

    final response = _prefs.getString('audios');

    if (response != null && isRefreshed == false) {
      final audios = jsonDecode(response) as List;
      final data = audios.map((e) => AudioModel.fromJson(e)).toList();
      emit(AudioSuccessState(data));
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
          emit(AudioSuccessState(data));
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
  AudioSuccessState(this.data);

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
