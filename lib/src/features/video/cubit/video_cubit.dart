import 'package:aamako_maya/src/features/video/model/video_model.dart';
import 'package:aamako_maya/src/features/video/repository/videoes_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'video_state.dart';
part 'video_cubit.freezed.dart';

class VideoCubit extends Cubit<VideoState> {
  final VideosRepo _repo;

  VideoCubit(VideosRepo repo)
      : _repo = repo,
        super(VideoState.initial());

  void getVideos() async {
    try {
      final List<VideoModel> response = await _repo.getVideos();

      emit(VideoState.success(videos: response, isLoading: false, error: null));
    } catch (error) {
      emit(state.copyWith(
        error: "Can't fetch data at the moment!",
        isLoading: false,
      ));
    }
  }

  // @override
  // VideoState? fromJson(Map<String, dynamic> json) {
  //   try {
  //     final data =
  //         (json["videos"] as List).map((e) => VideoModel.fromJson(e)).toList();
  //     return VideoState.success(videos: data);
  //   } catch (_) {
  //     return null;
  //   }
  // }

}
