import 'package:aamako_maya/src/features/authentication/cache/cache_values.dart';
import 'package:aamako_maya/src/features/weekly_tips/model/weekly_tips_model.dart';
import 'package:aamako_maya/src/features/weekly_tips/repository/weekly_tips_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'weekly_tips_state.dart';
part 'weekly_tips_cubit.freezed.dart';

class WeeklyTipsCubit extends HydratedCubit<WeeklyTipsState> {
  final WeeklyTipsRepo _repo;

  WeeklyTipsCubit({
    required WeeklyTipsRepo repo,
  })  : _repo = repo,
        super(const WeeklyTipsState.initial());

  void getWeeklyTips() async {
    try {
      final List<WeeklyTips> response = await _repo.getWeeklyTips();

      emit(WeeklyTipsState.success(
          tips: response, isLoading: false, error: null));
    } catch (error) {
      emit(state.copyWith(
        error: "Can't fetch data at the moment",
        isLoading: false,
      ));
    }
  }

  @override
  WeeklyTipsState? fromJson(Map<String, dynamic> json) {

    print(json.toString());
    // return WeeklyTipsState.success(tips: (json["data"] as List).map((e) => e.WeeklyTips.fromJson()) );
  }

  @override
  Map<String, dynamic>? toJson(WeeklyTipsState state) {
    state.when(initial: (d, f) {
      return;
    }, success: (x, d, g) {
       // ignore: unused_local_variable
       final data=g.map((e) => e.toJson());

       return {"data":data};
       
    });
  }
}
