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
    String token = "4a66f714-9124-4cd1-a0fa-e48789021600";

    final response = prefs.getString('delivery');
    if (response != null && isRefreshed == false) {
      final delivery = jsonDecode(response) as List;
      final data = (delivery).map((e) => Deliverymodel.fromJson(e)).toList();
      emit(DeliverySuccessState(data));
    } else {
      try {
        final response = await dio.get("${Urls.deliveryUrl}/$token");
        if (response.statusCode == 200) {
          final delivery = response.data as List;
          prefs.setString('delivery', jsonEncode(delivery));
          List<Deliverymodel> list =
              (delivery).map((e) => Deliverymodel.fromJson(e)).toList();

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
  final List<Deliverymodel> data;
  DeliverySuccessState(this.data);
  @override
  List<Object?> get props => [data];
}

class DeliveryInitialState extends DeliveryState {}

class DeliveryLoadingState extends DeliveryState {}

class DeliveryFailureState extends DeliveryState {}
