import 'dart:convert';

import 'package:aamako_maya/src/core/connection_checker/network_connection.dart';
import 'package:aamako_maya/src/features/weekly_tips/model/weekly_tips_model.dart';
import 'package:aamako_maya/src/features/weekly_tips/repository/weekly_tips_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/cache/weekly_cache/cache_values.dart';

class WeeklyTipsCubit extends Cubit<WeeklyTipsState> {
  final WeeklyTipsRepo _repo;
  final WeeklyCachedValues _cache;
  final NetworkInfo _network;
  final SharedPreferences _prefs;

  WeeklyTipsCubit(
      {required NetworkInfo network,
      required SharedPreferences prefs,
      required WeeklyTipsRepo repo,
      required WeeklyCachedValues cache})
      : _repo = repo,
        _prefs = prefs,
        _network = network,
        _cache = cache,
        super(WeeklyTipsInitial());

  void getWeeklyTips(bool isRefreshed) async {
    emit(WeeklyTipsLoading());
    final response = _prefs.getString('weeklyTips');
    if (response != null && isRefreshed == false) {
      final weekly = jsonDecode(response) as List;
      final List<WeeklyTips> data =
          weekly.map((json) => WeeklyTips.fromJson(json)).toList();
      emit(WeeklyTipsSucces(data));
    } else {
      try {
        final List<WeeklyTips> response = await _repo.getWeeklyTips();

        emit(WeeklyTipsSucces(response, isRefreshed: isRefreshed));
      } on DioError catch (_) {
        emit(WeeklyTipsFailure());
      }
    }
  }
}

abstract class WeeklyTipsState extends Equatable {}

class WeeklyTipsLoading extends WeeklyTipsState {
  @override
  List<Object?> get props => [];
}

class WeeklyTipsSucces extends WeeklyTipsState {
  final List<WeeklyTips> data;
  final bool? isRefreshed;
  WeeklyTipsSucces(this.data, {this.isRefreshed});
  @override
  List<Object?> get props => [data];
}

class WeeklyTipsFailure extends WeeklyTipsState {
  @override
  List<Object?> get props => [];
}
class WeeklyTipsInitial extends WeeklyTipsState {
  @override
  List<Object?> get props => [];
}
