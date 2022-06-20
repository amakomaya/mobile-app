part of 'onboard_bloc.dart';

@freezed
class OnboardEvent with _$OnboardEvent {
  const factory OnboardEvent.started() = _Started;
   const factory OnboardEvent.onboardStart() = _StartOnboard;
}