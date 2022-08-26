import 'dart:convert';

import 'package:aamako_maya/src/features/authentication/model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  SharedPreferences prefs;

  GetUserCubit(this.prefs) : super(GetUserInitial());
  void getUserFromLocal() {
    final local = prefs.getString('user');
    if (local != null) {
      final user = UserModel.fromJson(jsonDecode(local));
      emit(GetUserSuccess(user));
    } else {
      emit(GetUserFailure());
    }
  }
}
