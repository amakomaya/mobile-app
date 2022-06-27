import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/constant/app_constants.dart';
import '../model/user_model.dart';

class AuthLocalData {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  Future<void> saveCredentialsDataToLocal(UserModel? user) async {
    try {
      _secureStorage.write(key: Consts.access_token, value: user?.token);
    } catch (e) {
      rethrow;
    }
  }

  //get user details from local
  Future<void> getCredentialsDataToLocal(UserModel? user) async {
    //get 
  }
}
