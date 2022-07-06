import 'package:aamako_maya/src/features/authentication/cache/cache_values.dart';
import 'package:aamako_maya/src/features/weekly_tips/model/weekly_tips_model.dart';
import 'package:aamako_maya/src/features/weekly_tips/repository/weekly_tips_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weekly_tips_state.dart';
part 'weekly_tips_cubit.freezed.dart';

class WeeklyTipsCubit extends Cubit<WeeklyTipsState> {
  WeeklyTipsRepo _repo;
  CachedValues _cache;

  WeeklyTipsCubit({required WeeklyTipsRepo repo, required CachedValues cache})
      : _repo = repo,
        _cache = cache,
        super(const WeeklyTipsState.initial());

  void getWeeklyTips() async {
    print('ghgvh');
    try {
      final cached = await _cache.getWeeklyTips();
      print('object' + cached.toString());
      if (cached == null) {
        final List<WeeklyTips> response = await _repo.getWeeklyTips();
        await _cache.saveWeeklyTips(response);

        emit(WeeklyTipsState.success(
            tips: response, isLoading: false, error: null));
      } else {

      
        emit(WeeklyTipsState.success(
            tips: cached, isLoading: false, error: null));
      }
    } catch (error) {
      emit(state.copyWith(
        error: "Can't fetch data at the moment",
        isLoading: false,
      ));
    }
  }
}
