import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/constant/app_constants.dart';
import '../model/user_model.dart';

class AuthLocalData {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  Future<void> saveCredentialsDataToLocal(UserModel? user) async {
    print(user?.token);
    try {
      _secureStorage.write(key: Consts.access_token, value: user?.token);
    } catch (e) {
      rethrow;
    }
  }

  //GET TOKEN FROM LOCAL STORAGE
  Future getTokenFromocal() async {
    try {
      String? value = await _secureStorage.read(key: Consts.access_token) ?? '';
      return value;
    } catch (e) {
      rethrow;
    }
  }
}
