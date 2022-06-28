part of 'weekly_tips_cubit.dart';

@freezed
class WeeklyTipsState with _$WeeklyTipsState {
  const factory WeeklyTipsState.initial({
    @Default(false) bool isLoading,
    String? error,
  }) = _Initial;
  const factory WeeklyTipsState.success(
      {@Default(false) bool isLoading,
      String? error,
      required List<WeeklyTips> tips}) = _Success;
}
