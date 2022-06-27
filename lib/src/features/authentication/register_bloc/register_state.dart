part of 'register_bloc.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.initial(
     {@Default(false) bool isLoading,
      String? error,}
  ) = _Initial;
  const factory RegisterState.success(
      {@Default(false) bool isLoading,
      String? error,
      required UserModel user}) = _RegisterSuccess;
}
