import 'dart:convert';

import 'package:aamako_maya/src/core/connection_checker/network_connection.dart';
import 'package:aamako_maya/src/features/authentication/authentication_repository/authentication_repo.dart';
import 'package:aamako_maya/src/features/authentication/model/login_request_model.dart';
import 'package:aamako_maya/src/features/authentication/model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/register_request_model.dart';



class AuthenticationCubit extends Cubit<AuthenticationState> {
  final Dio dio;
  final AuthenticationRepository _repo;
  final NetworkInfo network;
  final SharedPreferences prefs;
  AuthenticationCubit(this.dio, this.prefs, this.network, this._repo)
      : super(AuthenticationInitialState());

  void loginWithToken(String token) async {
    final response = prefs.getString('user');

    if (response != null) {
      final user = UserModel.fromJson(jsonDecode(response));
      emit(LoginSuccessfulState(user));
    } else {
      emit(LoginFailureState('Problem in accessing data'));
    }
  }

  void login({required LoginRequestModel user}) async {
    final hasInternet = await network.isConnected;
    if (hasInternet) {
      emit(AuthenticationLoadingState());
      try {
        final UserModel response = await _repo.login(credential: user);
        emit(LoginSuccessfulState(response));
      } catch (error) {
        emit(LoginFailureState(error.toString()));
      }
    } else {
      emit(LoginFailureState('No Internet Connection!'));
    }
  }

  void register({required RegisterRequestModel user}) async {
      final hasInternet = await network.isConnected;
    if (hasInternet) {
        emit(AuthenticationLoadingState());
    try {
      final UserModel response = await _repo.register(credential: user);
      emit(LoginSuccessfulState(response));
    } catch (error) {
      emit(
          LoginFailureState(error.toString()));
    }
    }else{
      emit(LoginFailureState('No Internet Connection!'));
    }
  
  }

  // void loginWithQr(String qrCode) async {
  //   try {
  //     final Response res = await Dio().post(Urls.qrcodeUrl + qrCode);
  //     if (res.statusCode == 200) {
  //       final user = UserModel.fromJson(res.data['user']);
  //       // local.saveCredentialsDataToLocal(user);
  //       emit(LoggedInState(
  //           user: user,
  //           error: null,
  //           isLoading: false,
  //           isAuthenticated: true,
  //           isProfileComplete:
  //               (user.tole != null && (user.tole?.isNotEmpty ?? false))));
  //     } else {
  //       emit(const LoggedInState(user: null, error: 'Error', isLoading: false));
  //     }
  //   } catch (e) {
  //     emit(const LoggedInState(user: null, error: 'Error', isLoading: false));
  //   }
  // }
}

abstract class AuthenticationState extends Equatable {
  // final UserModel? user;
  // final String? error;
  // final bool? isLoading;
  // final bool? isAuthenticated;
  // final bool? isProfileComplete;

  // const LoggedInState(
  //     {required this.user,
  //     this.isProfileComplete = false,
  //     required this.error,
  //     required this.isLoading,
  //     this.isAuthenticated = false});
  // @override
  // List<Object?> get props => [user, error, isLoading];
}

class AuthenticationInitialState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class LoginSuccessfulState extends AuthenticationState {
  final UserModel user;
  LoginSuccessfulState(this.user);

  @override
  List<Object?> get props => [user];
}

class LoginFailureState extends AuthenticationState {
  final String error;
  LoginFailureState(this.error);

  @override
  List<Object?> get props => [error];
}

class AuthenticationLoadingState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}
