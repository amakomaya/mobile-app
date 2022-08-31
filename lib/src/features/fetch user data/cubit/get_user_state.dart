part of 'get_user_cubit.dart';

abstract class GetUserState extends Equatable {
  const GetUserState();

  @override
  List<Object> get props => [];
}

class GetUserInitial extends GetUserState {}

class GetUserSuccess extends GetUserState {
  final UserModel user;
 
  const GetUserSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class GetUserFailure extends GetUserState {}
