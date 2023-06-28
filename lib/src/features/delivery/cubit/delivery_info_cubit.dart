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
class DeliverInfoCubit extends Cubit<DeliveryInfoState> {
  Dio dio; //type of data accepted in constructor
  AuthLocalData local;
  SharedPreferences prefs;

  DeliverInfoCubit(this.dio, this.local, this.prefs) //constructor
      : super(DeliveryInitialState());

  void getDeliveryInfo(bool isRefreshed) async {
    emit(DeliveryLoadingState());
    // String token = await local.getTokenFromocal();
    final AuthLocalData _localData = AuthLocalData();
    String? token = await _localData.getTokenFromocal();

    final response = prefs.getString('delivery_info_data');

    if (response != null && isRefreshed == false) {
      final ancs = jsonDecode(response);
      InformationModel list = InformationModel.fromJson(ancs);
      emit(DeliveryInfoSuccessState(list));
    } else {
      try {
        final response = await dio.get("${Urls.deliveryiInfoUrls}", options:  Options(
          headers: {"token": "$token"},
        ));
        if (response.statusCode == 200) {
          prefs.setString('delivery_info_data', jsonEncode(response.data));
          InformationModel list = InformationModel.fromJson(response.data);
          emit(DeliveryInfoSuccessState(list));
        } else {
          emit(DeliveryFailureState());
        }
      } on DioError catch (e) {
        emit(DeliveryFailureState());
      }
    }
  }

}

class DeliveryInfoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeliveryInitialState extends DeliveryInfoState {}

class DeliveryLoadingState extends DeliveryInfoState {}

class DeliveryFailureState extends DeliveryInfoState {}
class DeliveryInfoSuccessState extends DeliveryInfoState {
  final InformationModel data;
  DeliveryInfoSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}