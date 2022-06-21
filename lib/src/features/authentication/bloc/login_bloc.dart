import 'package:aamako_maya/src/features/authentication/model/login_request_model.dart';
import 'package:aamako_maya/src/features/authentication/model/user_model.dart';
import 'package:aamako_maya/src/features/authentication/repository/login_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository _repo;
  LoginBloc(LoginRepository repo)
      : _repo = repo,
        super(_Initial()) {
    on<_LoginStart>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      await _handleLogin(event, emit);
    });
  }
//login event functions
  Future<void> _handleLogin(_LoginStart event, Emitter<LoginState> emit) async {
    try {
      final response = await _repo.login(credential: event.user);
      emit(LoginState.success(user: response,isLoading: false,error: null));
    } catch (error) {
      emit(state.copyWith(
        error: Exception(),
        isLoading: false,
      ));
    }
  }
}
