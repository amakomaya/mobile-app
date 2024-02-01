import 'dart:convert';

import 'package:Amakomaya/src/core/connection_checker/network_connection.dart';
import 'package:Amakomaya/src/features/authentication/authentication_repository/authentication_repo.dart';
import 'package:Amakomaya/src/features/authentication/model/login_request_model.dart';
import 'package:Amakomaya/src/features/authentication/model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/network_services/urls.dart';
import '../../symptoms/cubit/symptoms_cubit.dart';
import '../model/forget_password_model.dart';
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
        emit(LoginFailureState(error.toString()));
      }
    } else {
      emit(LoginFailureState('No Internet Connection!'));
    }
  }

  Future<ForgetPasswordModel?> forgetPassword() async {
    final hasInternet = await network.isConnected;
    if (hasInternet) {
      try {
        final response = await dio.post("${Urls.forgetPassword}");
        if (response.statusCode == 200){
          final data = ForgetPasswordModel.fromJson(response.data);
          return data;
        }
        else {
          throw ApiException(response.data.toString());
        }
      } on DioError catch (e) {
        throw ApiException(e.message ?? "");
      }
    } else {
      ApiException('No Internet Connection!');
    }
    return null;
  }

  void loginWithQr(String qrCode) async {
    final hasInternet = await network.isConnected;
    if (hasInternet) {
      emit(AuthenticationLoadingState());
      try {
        final UserModel response = await _repo.qrLogin(credenntial: qrCode);

        emit(LoginSuccessfulState(response));
      } catch (e) {
        emit(LoginFailureState(e.toString()));
      }
    } else {
      emit(LoginFailureState('No Internet Connection!'));
    }
  }
}

abstract class AuthenticationState extends Equatable {}

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
