import 'package:aamako_maya/src/features/onboarding/models/onboarding_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import '../onboarding_repository/onboarding_repository.dart';

part 'onboard_event.dart';
part 'onboard_state.dart';
part 'onboard_bloc.freezed.dart';

class OnboardBloc extends Bloc<OnboardEvent, OnboardState> {
  final OnboardingRepo _repo;
  OnboardBloc({required OnboardingRepo repo})
      : _repo = repo,
        super(const _Initial()) {
    on<_StartOnboard>(
        (event, emit) => onboardBloc(event, emit));
  }
  Future<void> onboardBloc(
      OnboardEvent event, Emitter<OnboardState> emit) async {
    try {
      final response = await _repo.getOnboardingList();
      //assign false to not show onboarding screens next time
      var box =await  Hive.openBox('myBox');
      box.put('onboard', true);
      emit(
        OnboardState.success(
          onboardList: response,
          isLoading: false,
          error: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: Exception()));
    }
  }
}
