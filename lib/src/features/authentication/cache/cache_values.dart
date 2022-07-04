import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constant/app_constants.dart';
import '../model/user_model.dart';

class CachedValues {
 Future<Box<Map<dynamic,dynamic>>> openUserBox()async{
   // Open your boxes. Optional: Give it a type.
  final box =await Hive.openBox<Map>(Consts.user_info);
  return box;
 }

   Future<UserModel?> getUserInfo() async{

    // final box=openUserBox();
    
    // String? userInfo = box.put(Consts.user_info);
    // if (userInfo != null) {
    //   // jsonDecode and parse the json to opject
    //   UserModel userInfoDecoded =
    //       UserModel.fromJson(jsonDecode(userInfo) as Map<String, dynamic>);
    //   return userInfoDecoded;
    // }
    // return null;
  }

   setUserInfo(UserModel userData) async {
    final box =await openUserBox();
     await box.put(
        Consts.user_info, userData.toJson());
  }
}
