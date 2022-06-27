import 'dart:convert';

import 'package:aamako_maya/src/features/authentication/model/user_model.dart';
import 'package:dio/dio.dart';

import '../../../core/network_services/urls.dart';
import '../model/login_request_model.dart';

class LoginRepository {
  Response? response;
  var dio = Dio();

  Future login({required LoginRequestModel credential}) async {
    try {
      final response =
          await dio.post(Urls.loginUrl, data: jsonEncode(credential.toJson()));
      if (response.statusCode == 200) {
        final data = UserModel.fromJson(response.data);
        return data;
      } else {
        throw response.data['message'];
      }
    } on DioError catch (e) {
      if(e.response!=null){
        throw(e.response?.data['message']);
      }else{
        throw('Unexpected Error Occured');
      }}
  }
}
