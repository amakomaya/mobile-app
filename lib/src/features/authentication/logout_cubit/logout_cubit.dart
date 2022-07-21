// import 'package:aamako_maya/src/core/network_services/urls.dart';
// import 'package:aamako_maya/src/features/authentication/model/user_model.dart';
// import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:equatable/equatable.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// import '../local_storage/authentication_local_storage.dart';

// class LogoutCubit extends Cubit<LoggedInState> {
//   final AuthLocalData local;
//   LogoutCubit(this.local) : super(const LoggedInState(user: null, error: null));

//   void logout(String qrCode) async {
//     final AuthLocalData _localData = AuthLocalData();
//     String? token = await _localData.getTokenFromocal();
//     if (token != null && token.isNotEmpty) {
//       final status = await _localData.clearToken();
//       if (status) {
//         emit(LoggedInState(user: null, error: null));
//       }
//     }
//   }
// }

// class LoggedInState extends Equatable {
//   final UserModel? user;
//   final String? error;
//   const LoggedInState({required this.user, required this.error});
//   @override
//   List<Object?> get props => [];
// }
