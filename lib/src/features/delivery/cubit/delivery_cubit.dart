import 'dart:convert';

import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/ancs/model/ancs_model.dart';
import 'package:aamako_maya/src/features/delivery/model/delivery_model.dart';
import 'package:aamako_maya/src/features/pnc/model/pnc_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../injection_container.dart';
import '../../ancs/model/information_model.dart';
import '../../ancs/model/new_report_model.dart';
import '../../authentication/local_storage/authentication_local_storage.dart';

//this is cubit (class)
class DeliverCubit extends Cubit<DeliveryState> {
  Dio dio; //type of data accepted in constructor
  AuthLocalData local;
  SharedPreferences prefs;

  DeliverCubit(this.dio, this.local, this.prefs) //constructor
      : super(DeliveryInitialState());

  //inside class, function is called method
  void getDelivery(bool isRefreshed) async {
    emit(DeliveryLoadingState());
    // String token = await local.getTokenFromocal();
    final AuthLocalData _localData = AuthLocalData();
    String? token = await _localData.getTokenFromocal();
    final response = prefs.getString('delivery_data');
    if (response != null && isRefreshed == false) {
      final delivery = jsonDecode(response);
      final data =  NewReportModel.fromJson(delivery);
      emit(DeliverySuccessState(data));
    } else {
      try {
        final response = await dio.get("${Urls.deliveryUrls}", options:  Options(
          headers: {"token": "$token"},
        ));
        if (response.statusCode == 200) {
          prefs.setString('delivery_data', jsonEncode(response.data));
          NewReportModel list = NewReportModel.fromJson( response.data);
          emit(DeliverySuccessState(list));
        } else {
          emit(DeliveryFailureState());
        }
      } on DioError catch (_) {
        emit(DeliveryFailureState());
      }
    }
  }


}

class DeliveryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeliverySuccessState extends DeliveryState {
  final NewReportModel data;
  DeliverySuccessState(this.data);
  @override
  List<Object?> get props => [data];
}

class DeliveryInitialState extends DeliveryState {}

class DeliveryLoadingState extends DeliveryState {}

class DeliveryFailureState extends DeliveryState {}