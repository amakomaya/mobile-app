import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/audio/model/audio_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

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
}

class AudioState extends Equatable {
  final List<AudioModel>? audioModel;
  final String? error;

  const AudioState({required this.audioModel, required this.error});
  @override
  List<Object?> get props => [audioModel, error];
}
