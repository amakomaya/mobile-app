import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../models/newsfeed_model.dart';

class NewsfeedCubit extends Cubit<NewsfeedState> {
  final Dio _dio;
  NewsfeedCubit(Dio dio)
      : _dio = dio,
        super(NewsfeedState(newsfeed: null, isLoading: false));

  void getNewsFeed() async {
    emit(const NewsfeedState(newsfeed: null, isLoading: true));
    try {
      final Response response = await _dio.get(Urls.newsFeedUrl);
      if (response.statusCode == 200) {
        final data = (response.data as List)
            .map((json) => NewsFeedModel.fromJson(json))
            .toList();
        emit(NewsfeedState(newsfeed: data, isLoading: false));
      } else {
        emit(NewsfeedState(newsfeed: state.newsfeed, isLoading: false));
      }
    } catch (e) {
      emit(NewsfeedState(newsfeed: state.newsfeed, isLoading: false));
    }
  }

  // @override
  // NewsfeedState? fromJson(Map<String, dynamic> json) {
  //   try {
  //     final data =
  //         (json["data"] as List).map((e) => NewsFeedModel.fromJson(e)).toList();
  //     return NewsfeedState(newsfeed: data, isLoading: false);
  //   } catch (_) {
  //     return null;
  //   }
  // }

  // @override
  // Map<String, dynamic>? toJson(NewsfeedState state) {
  //   if (state.newsfeed != null) {
  //     final data = state.newsfeed?.map((e) => e.toJson()).toList();
  //     return {"data": data};
  //   }
  //   return null;
  // }
}

class NewsfeedState extends Equatable {
  final bool isLoading;
  final List<NewsFeedModel>? newsfeed;

  const NewsfeedState({required this.newsfeed, required this.isLoading});

  @override
  List<Object?> get props => [newsfeed, isLoading];
}
