import 'dart:convert';

import 'package:aamako_maya/src/core/cache/news_feed/cache_values.dart';
import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/newsfeed_model.dart';

class NewsfeedCubit extends Cubit<NewsfeedState> {
  final Dio _dio;

  final SharedPreferences _prefs;
  NewsfeedCubit(Dio dio, SharedPreferences prefs, NewsFeedCache cache)
      : _dio = dio,
        _prefs = prefs,
        super(NewsFeedInitial());

  void getNewsFeed(bool isRefreshed) async {
    final response = _prefs.getString('newsfeed');
    if (response != null && isRefreshed == false) {
      final newsfeed = jsonDecode(response) as List;
      final data = newsfeed.map((e) => NewsFeedModel.fromJson(e)).toList();
      emit(NewsfeedSuccess(data, isRefreshed));
    } else {
      try {
        final Response response = await _dio.get(Urls.newsFeedUrl);
        if (response.statusCode == 200) {
          final news = response.data as List;
          await _prefs.setString('newsfeed', jsonEncode(news));
          final data = (response.data as List)
              .map((json) => NewsFeedModel.fromJson(json))
              .toList();
          emit(NewsfeedSuccess(data, isRefreshed));
        } else {
          emit(NewsfeedFailure());
        }
      } catch (e) {
        emit(NewsfeedFailure());
      }
    }
  }
}

abstract class NewsfeedState extends Equatable {}

class NewsFeedInitial extends NewsfeedState {
  @override
  List<Object?> get props => [];
}

class NewsFeedLoading extends NewsfeedState {
  @override
  List<Object?> get props => [];
}

class NewsfeedSuccess extends NewsfeedState {
  final List<NewsFeedModel> newsfeed;
  final bool isRefreshed;
  NewsfeedSuccess(this.newsfeed, this.isRefreshed);

  @override
  List<Object?> get props => [];
}

class NewsfeedFailure extends NewsfeedState {
  @override
  List<Object?> get props => [];
}
