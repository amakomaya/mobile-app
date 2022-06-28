import 'package:aamako_maya/src/features/weekly_tips/model/weekly_tips_model.dart';
import 'package:aamako_maya/src/features/weekly_tips/repository/weekly_tips_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weekly_tips_state.dart';
part 'weekly_tips_cubit.freezed.dart';

class WeeklyTipsCubit extends Cubit<WeeklyTipsState> {
  WeeklyTipsRepo _repo;

  WeeklyTipsCubit({required WeeklyTipsRepo repo})
      : _repo = repo,
        super(const WeeklyTipsState.initial());

  void getWeeklyTips() async {
    try {
      final List<WeeklyTips> response = await _repo.getWeeklyTips();

      emit(WeeklyTipsState.success(tips:response, isLoading: false, error: null));
    } catch (error) {
      emit(state.copyWith(
        error: "Can't fetch data at the moment",
        isLoading: false,
      ));
    }
  }
}
