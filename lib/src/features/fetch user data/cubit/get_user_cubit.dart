import 'dart:convert';

import 'package:aamako_maya/src/features/authentication/local_storage/authentication_local_storage.dart';
import 'package:aamako_maya/src/features/authentication/model/user_model.dart';
import 'package:aamako_maya/src/features/symptoms/cubit/symptoms_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/network_services/urls.dart';

part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  SharedPreferences prefs;
  final AuthLocalData local;
  final Dio dio;
  UserModel? userModelData;

  GetUserCubit(this.prefs, this.local, this.dio) : super(GetUserInitial());
  // void getUserData() {
  //   final local = prefs.getString('user');
  //   if (local != null) {
  //     final user = UserModel.fromJson(jsonDecode(local));
  //     emit(GetUserSuccess(user));
  //   } else {
  //     emit(GetUserFailure());
  //   }
  // }
    void getUserData() async {
      var token = await local.getTokenFromocal();
      final response = prefs.getString('user_data');
    if (response != null) {
      final userData = jsonDecode(response);
      final data = UserModel.fromJson(userData);
      userModelData = data;
      emit(GetUserSuccess(data));
    } else {
      try {
        final response = await dio.get("${Urls.profileUrl}",
            options: Options(
              headers: {"token": "$token"},
            ));
        if (response.statusCode == 200) {
          prefs.setString('user_data', jsonEncode(response.data));
          UserModel data = UserModel.fromJson(response.data);
          userModelData = data;
          emit(GetUserSuccess(data));
        } else {
          emit(GetUserFailure());
        }
      } on DioError catch (_) {
        emit(GetUserFailure());
      }
    }
  }

  Future<void> postUserData(
      {required String name,
      required int age,
      required String lmp_date,
      required String bloodgroup,
      required String districtName,
      required String municipalityName,
      required String provinceName,
      required String wardno,
      required String tole,
      required String mobile_number,
      required String heightIncm,
      required String husbandName,
      required String currentHealthPost,
      required int numberOfPregnancy,
      required String disease,
      required String mode}) async {
    var token = await local.getTokenFromocal();
    var body = {
      "name": name,
      "age": age,
      "lmp_date_np": lmp_date,
      "district_name": districtName,
      "municipality_name": municipalityName,
      "province_name": provinceName,
      "ward": wardno,
      "tole": tole,
      "phone": mobile_number,
      "have_disease_previously": disease,
      "bloodGroup": bloodgroup,
      "pregnant_times": numberOfPregnancy,
      "height": heightIncm,
      "husband_name": husbandName,
      "current_health_post": currentHealthPost,
      "mode_type": mode
    };
    print(body);
    try {
      final response = await dio.post("${Urls.profileUrl}",
          data: body,
          options: Options(
            headers: {"token": "$token"},
          ));
      if (response.statusCode == 200)
        return (response.data);
      else {
        throw ApiException(response.data.toString());
      }
    } on DioError catch (e) {
      throw ApiException(e.message);
    }
  }
}
