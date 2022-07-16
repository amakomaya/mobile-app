import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/authentication/model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../local_storage/authentication_local_storage.dart';

class QrCodeCubit extends Cubit<LoggedInState> {
  final Dio dio;
  final AuthLocalData local;
  QrCodeCubit(this.dio,this.local) : super(const LoggedInState(user: null, error: null));
  Barcode? result;
  QRViewController? controller;
  void loginWithQr(String qrCode) async {
    try {
      final Response res = await Dio().post(Urls.qrcodeUrl + qrCode);
      if (res.statusCode == 200) {
        final user = UserModel.fromJson(res.data['user']);
          local.saveCredentialsDataToLocal(user);
        emit(LoggedInState(user: user, error: null));
      } else {
        emit(const LoggedInState(user: null, error: 'Error'));
      }
    } catch (e) {
      emit(const LoggedInState(user: null, error: 'Error'));
    }
  }
}

class LoggedInState extends Equatable {
  final UserModel? user;
  final String? error;
  const LoggedInState({required this.user, required this.error});
  @override
  List<Object?> get props => [];
}
