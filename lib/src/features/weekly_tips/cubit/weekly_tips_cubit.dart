import 'dart:convert';

import 'package:aamako_maya/src/core/connection_checker/network_connection.dart';
import 'package:aamako_maya/src/features/weekly_tips/model/weekly_tips_model.dart';
import 'package:aamako_maya/src/features/weekly_tips/repository/weekly_tips_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../authentication/cache/cache_values.dart';

class WeeklyTipsCubit extends Cubit<WeeklyTipsState> {
  final WeeklyTipsRepo _repo;
  final CachedValues _cache;
  final NetworkInfo _network;

  WeeklyTipsCubit(
      {required NetworkInfo network,
      required WeeklyTipsRepo repo,
      required CachedValues cache})
      : _repo = repo,
        _network = network,
        _cache = cache,
        super(WeeklyTipsState());

  void getWeeklyTips({bool? isRefreshed}) async {
    emit(WeeklyTipsState(isLoading: true));

    try {
      final cache = await _cache.getWeeklyTips() as List<WeeklyTips>?;
      if (cache == null || isRefreshed == true) {
        final List<WeeklyTips> response = await _repo.getWeeklyTips();
        await _cache.setWeeklyTips(response);
        emit(WeeklyTipsState(
            data: response,
            error: null,
            success: 'Successfully Fetched !',
            isLoading: false));
      } else {
        emit(WeeklyTipsState(data: cache, isLoading: false, error: null));
      }
    } catch (error) {
      emit(WeeklyTipsState(
          data: null, isLoading: false, error: error.toString()));
    }
  }
}

class WeeklyTipsState extends Equatable {
  final List<WeeklyTips>? data;
  final String? error;
  final bool? isLoading;
  final String? success;

  WeeklyTipsState({this.data, this.success, this.error, this.isLoading});
  @override
  List<Object?> get props => [data, success, error, isLoading];
}
