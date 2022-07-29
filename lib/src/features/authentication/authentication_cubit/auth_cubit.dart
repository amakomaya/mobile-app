import 'dart:async';

import 'package:aamako_maya/src/core/connection_checker/network_connection.dart';
import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/authentication/authentication_repository/authentication_repo.dart';
import 'package:aamako_maya/src/features/authentication/model/login_request_model.dart';
import 'package:aamako_maya/src/features/authentication/model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../local_storage/authentication_local_storage.dart';
import '../model/register_request_model.dart';

class AuthenticationCubit extends Cubit<LoggedInState> {
  final Dio dio;
  final AuthenticationRepository _repo;
  final NetworkInfo network;
  final AuthLocalData local;
  AuthenticationCubit(this.dio,this.network, this.local, this._repo)
      : super(LoggedInState(user: null, error: null, isLoading: false));

  void loginWithToken(String token) async {
    try {
      emit(LoggedInState(
          user: null,
          error: null,
          isLoading: false,
          isAuthenticated: true,
          isProfileComplete: false));
    } catch (e) {
      emit(LoggedInState(user: null, error: 'Error', isLoading: false));
    }
  }

  void login({required LoginRequestModel user}) async {
    final hasInternet= await network.isConnected;
    if(hasInternet){
      emit(LoggedInState(user: null, error: null, isLoading: true));
    try {
      final UserModel response = await _repo.login(credential: user);
      local.saveCredentialsDataToLocal(response);
      emit(LoggedInState(
          user: response,
          isLoading: false,
          error: null,
          isAuthenticated: true,
          isProfileComplete:
              (response.tole != null && (response.tole?.isNotEmpty ?? false))));
    } catch (error) {
      emit(LoggedInState(
        user: null,
        error: error.toString(),
        isLoading: false,
      ));
    }
    }
    else{
     emit( LoggedInState(
      isLoading: false,
      user: null,
      isAuthenticated: false,
      isProfileComplete: false,
      error: 'No Internet Connection',));

    }
  }

  void register({required RegisterRequestModel user}) async {
    emit(LoggedInState(error: null, isLoading: true, user: null));
    try {
      final UserModel response = await _repo.register(credential: user);
      // print(response.token??''+'eeeee');
      local.saveCredentialsDataToLocal(response);
      emit(LoggedInState(
          user: response,
          isLoading: false,
          isAuthenticated: true,
          isProfileComplete:
              (response.tole != null && (response.tole?.isNotEmpty ?? false)),
          error: null));
    } catch (error) {
      emit(
          LoggedInState(user: null, error: error.toString(), isLoading: false));
    }
  }

  void loginWithQr(String qrCode) async {
    print(qrCode + 'Dick');
    try {
      final Response res = await Dio().post(Urls.qrcodeUrl + qrCode);
      if (res.statusCode == 200) {
        print(qrCode + 'Pussy');
        final user = UserModel.fromJson(res.data['user']);
        // local.saveCredentialsDataToLocal(user);
        emit(LoggedInState(
            user: user,
            error: null,
            isLoading: false,
            isAuthenticated: true,
            isProfileComplete:
                (user.tole != null && (user.tole?.isNotEmpty ?? false))));
      } else {
        emit(LoggedInState(user: null, error: 'Error', isLoading: false));
      }
    } catch (e) {
      emit(LoggedInState(user: null, error: 'Error', isLoading: false));
    }
  }

  // @override
  // LoggedInState? fromJson(Map<String, dynamic> json) {
  //   try {
  //     final user = UserModel.fromJson(json);
  //     return LoggedInState(user: user, error: null, isLoading: false);
  //   } catch (_) {
  //     return null;
  //   }
  // }

  // @override
  // Map<String, dynamic>? toJson(LoggedInState state) {
  //   if (state.user!=null) {
  //     final user = state.user?.toJson();
  //     return user;
  //   } else {
  //     return null;
  //   }
  // }
}

class LoggedInState extends Equatable {
  final UserModel? user;
  final String? error;
  final bool? isLoading;
  final bool? isAuthenticated;
  final bool? isProfileComplete;

  LoggedInState(
      {required this.user,
      this.isProfileComplete = false,
      required this.error,
      required this.isLoading,
      this.isAuthenticated = false});
  @override
  List<Object?> get props => [user, error, isLoading];
}
