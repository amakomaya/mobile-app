import 'dart:convert';

import 'package:aamako_maya/src/features/authentication/model/register_request_model.dart';
import 'package:aamako_maya/src/features/authentication/model/user_model.dart';
import 'package:dio/dio.dart';

import '../../../core/network_services/urls.dart';

class RegisterRepository {
  Response? response;
  var dio = Dio();

  register({required RegisterRequestModel credential}) async {
    try {
      final response = await dio.post(Urls.registerUrl,
          data: credential.toJson());
      if (response.statusCode == 200) {
        final data = UserModel.fromJson(response.data['user']);
        print(data);
        return data;
      }
    } on DioError catch (e) {
      if(e.response!=null){
        throw(e.response?.data['message']);
      }else{
        throw('Unexpected Error Occured');
      }
      
    }
  }
}
