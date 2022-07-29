
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../local_storage/authentication_local_storage.dart';

class LoggedOutState extends Equatable {
  final bool? isLoading;
  final bool? isLoggedOut;
  const LoggedOutState(this.isLoggedOut, this.isLoading);

  @override
  List<Object?> get props => [isLoading, isLoggedOut];
}

class LoggedOutCubit extends Cubit<LoggedOutState> {
  final AuthLocalData local;
  LoggedOutCubit(this.local) : super(const LoggedOutState(null, false));

  void logout() async {
    emit(const LoggedOutState(null, true));

    try {
      await local.clearToken();

      emit(const LoggedOutState(true, false));
    } catch (e) {
      emit(const LoggedOutState(false, false));
    }
  }
}
