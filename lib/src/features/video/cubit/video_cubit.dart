import 'package:aamako_maya/src/features/video/model/video_model.dart';
import 'package:aamako_maya/src/features/video/repository/videoes_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../authentication/cache/cache_values.dart';

part 'video_state.dart';
part 'video_cubit.freezed.dart';

class VideoCubit extends Cubit<VideoState> {
  final VideosRepo _repo;
  final CachedValues _cache;
  VideoCubit(VideosRepo repo, CachedValues cache)
      : _repo = repo,
        _cache = cache,
        super(const VideoState.initial());

  void getVideos({bool? isRefreshed}) async {
    emit(state.copyWith(isLoading: true));
    try {
      final cache = await _cache.getVideosList() as List<VideoModel>?;
      print((cache?[0].descriptionEn.toString() ?? '') + 'GGG');
      if (cache == null || isRefreshed == true) {
        final List<VideoModel> response = await _repo.getVideos();

        await _cache.setVideoList(response);
        emit(VideoState.success(
            videos: response, isLoading: false, error: null));
      } else {
        print('object + lda');
        emit(VideoState.success(videos: cache, isLoading: false, error: null));
      }
    } catch (error ) {
      print(error.toString() +'eror');
      emit(state.copyWith(
        error: "Can't fetch data at the moment!",
        isLoading: false,
      ));
    }
  }
}
