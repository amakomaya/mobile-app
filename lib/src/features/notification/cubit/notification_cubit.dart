import 'dart:convert';

import 'package:Amakomaya/src/core/connection_checker/network_connection.dart';
import 'package:Amakomaya/src/features/weekly_tips/model/weekly_tips_model.dart';
import 'package:Amakomaya/src/features/weekly_tips/repository/weekly_tips_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/cache/weekly_cache/cache_values.dart';
import '../model/notification_model.dart';
import '../repository/notification_repository.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo _repo;
  final SharedPreferences _prefs;

  NotificationCubit(
      {required NetworkInfo network,
      required SharedPreferences prefs,
      required NotificationRepo repo})
      : _repo = repo,
        _prefs = prefs,
        super(NotificationInitial());

  void getNotification(bool isRefreshed) async {
    emit(NotificationLoading());
    final response = _prefs.getString('NotificationData');
    if (response != null && isRefreshed == false) {
      final weekly = jsonDecode(response) as List;
      final List<NotificationModel> data =
          weekly.map((json) => NotificationModel.fromJson(json)).toList();
      emit(NotificationSuccess(data, isRefreshed));
    } else {
      try {
        final List<NotificationModel> response = await _repo.getNotification();

        emit(NotificationSuccess(response, isRefreshed));
      } on DioError catch (_) {
        emit(NotificationFailure());
      }
    }
  }
}

abstract class NotificationState extends Equatable {}

class NotificationLoading extends NotificationState {
  @override
  List<Object?> get props => [];
}

class NotificationSuccess extends NotificationState {
  final List<NotificationModel> data;
  final bool isRefreshed;

  NotificationSuccess(this.data, this.isRefreshed);

  @override
  List<Object?> get props => [data];
}

class NotificationFailure extends NotificationState {
  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {
  @override
  List<Object?> get props => [];
}
