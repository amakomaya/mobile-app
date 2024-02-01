import 'package:Amakomaya/src/core/network_services/urls.dart';
import 'package:Amakomaya/src/features/ancs/model/new_report_model.dart';
import 'package:Amakomaya/src/features/appointment_booking/model/verify_response.dart';
import 'package:Amakomaya/src/features/authentication/local_storage/authentication_local_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../model/booking_model.dart';

class FonePayPaymentCubit extends Cubit<FonePayPaymentState> {
  Dio dio;
  SharedPreferences prefs;
  AuthLocalData local;

  FonePayPaymentCubit(this.dio, this.local, this.prefs)
      : super(FonePayPaymentInitial());

  void requestFonePayPayment({required BookingModel requestModel}) async {
    emit(FonePayPaymentLoading());
    final AuthLocalData _localData = AuthLocalData();
    String? token = await _localData.getTokenFromocal();
    var uuid = Uuid();
    var bookingToken =  uuid.v1();
    prefs.remove("bookingToken");
    prefs.setString("bookingToken", bookingToken);
    try {
      final response =
      await dio.post("${Urls.fonepayPaymentRequest}", data: requestModel.toJson(), options: Options(
        headers: {
          "token":token,
          "booking-token":bookingToken
        },
      ));
      if (response.statusCode == 200) {
        emit(FonePayPaymentSuccess(response.data));
      } else {
        emit(FonePayPaymentFailure());
      }
    } on DioError catch (e) {
      emit(FonePayPaymentFailure());
    }
  }

  void verifyThePayment() async {
    emit(VerifyPaymentLoading());
    final AuthLocalData _localData = AuthLocalData();
    String? token = await _localData.getTokenFromocal();
    var bookingToken =  prefs.get("bookingToken");

        try {
      final response =
      await dio.get("${Urls.verifyPaymentRequest}",options: Options(
        headers: {
          "token":token,
          "booking-token":bookingToken
        },
      ));
      if (response.statusCode == 200) {
        final data = VerifyResponse.fromJson(response.data);
        emit(VerifyPaymentSuccess(data));
      } else {
        emit(VerifyPaymentFailure());
      }
    } on DioError catch (e) {
      emit(VerifyPaymentFailure());
    }
  }
}

abstract class FonePayPaymentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FonePayPaymentFailure extends FonePayPaymentState {}
class VerifyPaymentFailure extends FonePayPaymentState {}

class FonePayPaymentInitial extends FonePayPaymentState {}

class FonePayPaymentLoading extends FonePayPaymentState {}
class VerifyPaymentLoading extends FonePayPaymentState {}

class FonePayPaymentSuccess extends FonePayPaymentState {
  final String responseBody;

  FonePayPaymentSuccess(this.responseBody);

  @override
  List<Object?> get props => [responseBody];
}


class VerifyPaymentSuccess extends FonePayPaymentState {
  final VerifyResponse verifyResponse;

  VerifyPaymentSuccess(this.verifyResponse);

  @override
  List<Object?> get props => [verifyResponse];
}
