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
          data: jsonEncode({
            "name": "test reg",
            "age": 0,
            "is_first_time_parent": 1,
            "register_as": "planning",
            "lmp_date_en": "",
            "lmp_date_np": "",
            "phone": "9841888888",
            "email": "",
            "district_id": 0,
            "municipality_id": 0,
            "tole": "",
            "username": "aanna",
            "password": "1234567",
            "longitude": "85.3852891",
            "latitude": "27.6758303",
            "created_at": "2021-10-02 14:56:08",
            "updated_at": "2021-10-02 14:56:08"
          }));
      if (response.statusCode == 200) {
        final data = UserModel.fromJson(response.data);
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
