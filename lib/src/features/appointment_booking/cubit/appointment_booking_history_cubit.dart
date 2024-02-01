import 'package:Amakomaya/src/core/network_services/urls.dart';
import 'package:Amakomaya/src/features/ancs/model/new_report_model.dart';
import 'package:Amakomaya/src/features/authentication/local_storage/authentication_local_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentBookingHistoryCubit
    extends Cubit<AppointmentBookingHistoryState> {
  Dio dio;
  SharedPreferences prefs;
  AuthLocalData local;

  AppointmentBookingHistoryCubit(this.dio, this.local, this.prefs)
      : super(AppointmentBookingHistoryInitial());

  void getAppointmentBookingHistory(bool isRefreshed) async {
    emit(AppointmentBookingHistoryLoading());
    final AuthLocalData _localData = AuthLocalData();
    String? token = await _localData.getTokenFromocal();
    try {
      final response = await dio.get("${Urls.paymentHistory}",
          options: Options(
            headers: {"token": "$token"},
          ));
      if (response.statusCode == 200) {
        NewReportModel list = NewReportModel.fromJson(response.data);
        emit(AppointmentBookingHistorySuccess(list));
      } else {
        emit(AppointmentBookingHistoryFailure());
      }
    } on DioError catch (e) {
      emit(AppointmentBookingHistoryFailure());
    }
  }
}

abstract class AppointmentBookingHistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppointmentBookingHistoryFailure extends AppointmentBookingHistoryState {}

class AppointmentBookingHistoryInitial extends AppointmentBookingHistoryState {}

class AppointmentBookingHistoryLoading extends AppointmentBookingHistoryState {}

class AppointmentBookingHistorySuccess extends AppointmentBookingHistoryState {
  final NewReportModel data;

  AppointmentBookingHistorySuccess(this.data);

  @override
  List<Object?> get props => [data];
}
