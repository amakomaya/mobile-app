part of 'onboard_bloc.dart';

@freezed
class OnboardState with _$OnboardState {
  const factory OnboardState.initial(
   { @Default(false) bool isLoading,
    Exception? error,}
  ) = _Initial;
  const factory OnboardState.success(
   { @Default(false) bool isLoading,
    Exception? error,
   required List<GuidePagesList> onboardList,}
  ) = _OnboardSuccess;
}
