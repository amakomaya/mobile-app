import 'dart:convert';

import 'package:aamako_maya/src/features/video/model/video_model.dart';
import 'package:aamako_maya/src/features/video/repository/videoes_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/cache/weekly_cache/cache_values.dart';

class VideoCubit extends Cubit<VideoState> {
  final VideosRepo _repo;
  final SharedPreferences _prefs;
  final WeeklyCachedValues _cache;
  VideoCubit(VideosRepo repo, SharedPreferences prefs, WeeklyCachedValues cache)
      : _repo = repo,
        _prefs = prefs,
        _cache = cache,
        super(VideoInitialState());

  void getVideos(bool isRefreshed) async {
    
    final response = _prefs.getString('videos');

    if (response != null && isRefreshed == false) {
      final videos = jsonDecode(response) as List;

      final data = videos.map((e) => VideoModel.fromJson(e)).toList();
      emit(VideoSuccessState(data,isRefreshed));
    } else {
      try {
        final List<VideoModel> response = await _repo.getVideos();

        emit(VideoSuccessState(response,isRefreshed));
      } catch (error) {
        emit(VideoFailureState());
      }
    }
  }
}

abstract class VideoState extends Equatable {}

class VideoInitialState extends VideoState {
  @override
  List<Object?> get props => [];
}

class VideoLoadingState extends VideoState {
  @override
  List<Object?> get props => [];
}

class VideoFailureState extends VideoState {
  @override
  List<Object?> get props => [];
}

class VideoSuccessState extends VideoState {
  final List<VideoModel> data;
  final bool isRefreshed;
  VideoSuccessState(this.data,this.isRefreshed);
  @override
  List<Object?> get props => [data];
}
