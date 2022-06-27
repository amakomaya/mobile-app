import 'package:aamako_maya/src/features/authentication/model/register_request_model.dart';
import 'package:aamako_maya/src/features/authentication/repository/register_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/user_model.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository _repo;
  RegisterBloc(RegisterRepository repo)
      : _repo = repo,
        super(_Initial()) {
    on<_RegisterStart>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      try {
        final response = await _repo.register(credential: event.user);
        emit(RegisterState.success(
            user: response, isLoading: false, error: null));
      } catch (error) {
        emit(state.copyWith(
          error: error.toString(),
          isLoading: false,
        ));
      }
    });
  }
}
