part of 'update_user_data_cubit.dart';

abstract class UpdateUserDataState extends Equatable {
  const UpdateUserDataState();

  @override
  List<Object> get props => [];
}

class UpdateUserDataInitial extends UpdateUserDataState {}
 class UpdateUserDataLoading extends UpdateUserDataState {}
class UpdateUserDataSuccess extends UpdateUserDataState {}

class UpdateUserDataFailure extends UpdateUserDataState {}
