import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/audio/model/audio_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AudioCubit extends Cubit<AudioState> {
  final Dio _dio;
  AudioCubit(Dio dio)
      : _dio = dio,
        super(const AudioState(audioModel: null, error: null));

  void getAudio() async {
    try {
      final Response response = await _dio.get(Urls.audiourl);
      if (response.statusCode == 200) {
        final List<AudioModel> data = (response.data as List)
            .map(
              (json) => AudioModel.fromJson(json),
            )
            .toList();
        emit(AudioState(audioModel: data, error: null));
      } else {
        emit(AudioState(
            audioModel: state.audioModel, error: 'Audio Fetch Failed'));
      }
    } on DioError catch (error) {
      emit(AudioState(audioModel: state.audioModel, error: error.toString()));
    }
  }

  // @override
  // AudioState? fromJson(Map<String, dynamic> json) {
  //   try {
  //     final data =
  //         (json["data"] as List).map((e) => AudioModel.fromJson(e)).toList();
  //     return AudioState(audioModel: data, error: null);
  //   } catch (_) {
  //     return null;
  //   }
  // }

  // @override
  // Map<String, dynamic>? toJson(AudioState state) {
  //   if (state.audioModel != null) {
  //     final data = state.audioModel?.map((e) => e.toJson()).toList();
  //     return {"data": data};
  //   }
  //   return null;
  // }
}

class AudioState extends Equatable {
  final List<AudioModel>? audioModel;
  final String? error;

  const AudioState({required this.audioModel, required this.error});
  @override
  List<Object?> get props => [audioModel, error];
}
