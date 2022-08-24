import 'dart:convert';

import 'package:aamako_maya/src/features/authentication/local_storage/authentication_local_storage.dart';
import 'package:dio/dio.dart';

import '../../../core/network_services/urls.dart';
import '../model/login_request_model.dart';
import '../model/register_request_model.dart';
import '../model/user_model.dart';

class AuthenticationRepository {
  Dio dio;
  AuthLocalData local;

  AuthenticationRepository(this.dio, this.local,);
  Response? response;

  Future register({required RegisterRequestModel credential}) async {
    try {
      final response =
          await dio.post(Urls.registerUrl, data: credential.toJson());
      if (response.statusCode == 200) {
        final data = UserModel.fromJson(response.data['user']);
        local.saveCredentialsDataToLocal(response.data['user']['token']);
        return data;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw (e.response?.data['message']);
      } else {
        throw ('Unexpected Error Occured');
      }
    }
  }

  Future login({required LoginRequestModel credential}) async {
    try {
      final response =
          await dio.post(Urls.loginUrl, data: jsonEncode(credential.toJson()));
      if (response.statusCode == 200) {
        final data = UserModel.fromJson(response.data['user']);
        await local.saveCredentialsDataToLocal(response.data['user']['token']);
        return data;
      } else {
        throw response.data['message'];
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw (e.response?.data['message']);
      } else {
        throw ('Unexpected Error Occured');
      }
    }
  }
}
