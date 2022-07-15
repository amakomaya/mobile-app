import 'package:aamako_maya/src/features/authentication/model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeCubit extends Cubit<LoggedInState> {
  QrCodeCubit() : super(const LoggedInState(user: null,error: null));
  Barcode? result;
  QRViewController? controller;
  void loginWithQr(String qrCode) async {
    print(qrCode+'hhh');
    try {
      final Response res = await Dio().post(
          "https://mnch.mohp.gov.np/api/v1/woman-qrlogin?type=1&token=$qrCode");
      if (res.statusCode == 200) {
        print(200.toString());
        // final user = userModelFromJson(res.data);
        emit(LoggedInState(user: UserModel(), error: null));
      } else {
        emit(LoggedInState(user: null, error: 'Error'));
      }
    } catch (e) {
      emit(LoggedInState(user: null, error: 'Error'));
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
