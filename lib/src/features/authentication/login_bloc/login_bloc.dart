import 'package:aamako_maya/src/features/authentication/model/login_request_model.dart';
import 'package:aamako_maya/src/features/authentication/model/user_model.dart';
import 'package:aamako_maya/src/features/authentication/repository/login_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../local_storage/authentication_local_storage.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
 final AuthLocalData _local;
  final LoginRepository _repo;
  LoginBloc(LoginRepository repo,AuthLocalData local)
      : _repo = repo,
      _local=local,
        super(const _Initial()) {
    on<_LoginStart>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      await _handleLogin(event, emit);
    });
  }
//login event functions
  Future<void> _handleLogin(_LoginStart event, Emitter<LoginState> emit) async {
    try {
      final UserModel response = await _repo.login(credential: event.user);
      _local.saveCredentialsDataToLocal(response);
      emit(LoginState.success(user: response,isLoading: false,error: null));
    } catch (error) {
      emit(state.copyWith(
        error: error.toString(),
        isLoading: false,
      ));
    }
  }
}
