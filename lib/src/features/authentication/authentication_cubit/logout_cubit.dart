
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  SharedPreferences prefs;
  LoggedOutCubit(this.local, this.prefs) : super(const LoggedOutState(null, false));

  void logout() async {
    emit(const LoggedOutState(null, true));

    try {
      await local.clearToken();
        prefs.remove("anc_data");
        prefs.remove("anc_info_data");
        prefs.remove("delivery_data");
        prefs.remove("delivery_info_data");
         prefs.remove("labtest_data");
        prefs.remove("pnc_data");
        prefs.remove("pnc_info_data");
        prefs.remove("medication_data");
        prefs.remove("medication_info_data");
        prefs.remove("symptoms_history");
        prefs.remove("user_data");
        prefs.remove("user_mode");

      emit(const LoggedOutState(true, false));
    } catch (e) {
      emit(const LoggedOutState(false, false));
    }
  }
}
