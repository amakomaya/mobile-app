import 'dart:convert';

import 'package:aamako_maya/src/features/authentication/local_storage/authentication_local_storage.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/network_services/urls.dart';
import '../cubit/district_municipality_cubit.dart';
import '../model/login_request_model.dart';
import '../model/register_request_model.dart';
import '../model/user_model.dart';

class AuthenticationRepository {
  Dio dio;
  SharedPreferences prefs;
  AuthLocalData local;
  DistrictMunicipality dis;

  AuthenticationRepository(
    this.dio,
    this.prefs,
    this.dis,
    this.local,
  );
  Response? response;

  Future register({required RegisterRequestModel credential}) async {
    try {
      final response =
          await dio.post(Urls.registerUrl, data: credential.toJson());
      if (response.statusCode == 200) {
        //save in shared_prefs
        final user = response.data['user'];
        await prefs.remove('user');
        await prefs.setString('user', jsonEncode(user));

        //end

        //fetch districtMunicipality and save to local
        await dis.fetchDistrictAndMunicipality();
        //end
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
        //save in shared_prefs
        final user = response.data['user'];
        await prefs.remove('user');
        await prefs.setString('user', jsonEncode(user));

        //end
         //fetch districtMunicipality and save to local
        await dis.fetchDistrictAndMunicipality();
        //end
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
