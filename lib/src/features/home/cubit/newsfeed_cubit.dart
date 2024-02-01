import 'dart:convert';

import 'package:Amakomaya/src/core/cache/news_feed/cache_values.dart';
import 'package:Amakomaya/src/core/network_services/urls.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../authentication/local_storage/authentication_local_storage.dart';
import '../models/newsfeed_model.dart';

class NewsfeedCubit extends Cubit<NewsfeedState> {
  final Dio _dio;

  final SharedPreferences _prefs;

  NewsfeedCubit(Dio dio, SharedPreferences prefs)
      : _dio = dio,
        _prefs = prefs,
        super(NewsFeedInitial());

  void getNewsFeed(bool isRefreshed) async {
    final response = _prefs.getString('newsfeedData');
    if (response != null && isRefreshed == false) {
      final data = NewsFeedModel.fromJson(jsonDecode(response));
      _prefs.remove("user_mode");
      _prefs.setString("user_mode", data.userDetail.userMode);
      emit(NewsfeedSuccess(data, isRefreshed));
    } else {
      final AuthLocalData _localData = AuthLocalData();
      String? token = await _localData.getTokenFromocal();
      try {
        final response = await _dio.get("${Urls.newsFeedUrl}",
            options: Options(
              headers: {"token": "$token"},
            ));
        emit(NewsFeedLoading());
        if (response.statusCode == 200) {
          await _prefs.setString('newsfeedData', jsonEncode(response.data));
          NewsFeedModel newsFeedModel = NewsFeedModel.fromJson(response.data);
          print("statetssss fdfdf");
          _prefs.remove("user_mode");
          _prefs.setString("user_mode", newsFeedModel.userDetail.userMode);
          emit(NewsfeedSuccess(newsFeedModel, isRefreshed));
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
  final NewsFeedModel newsfeed;
  final bool isRefreshed;

  NewsfeedSuccess(this.newsfeed, this.isRefreshed);

  @override
  List<Object?> get props => [];
}

class NewsfeedFailure extends NewsfeedState {
  @override
  List<Object?> get props => [];
}
