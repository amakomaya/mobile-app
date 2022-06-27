part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial({
    @Default(false) bool isLoading,
    String? error,
  }) = _Initial;
  const factory LoginState.success(
      {@Default(false) bool isLoading,
      String? error,
      required UserModel user}) = _LoginSuccess;
}
