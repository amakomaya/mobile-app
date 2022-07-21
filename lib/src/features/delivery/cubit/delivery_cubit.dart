import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/ancs/model/ancs_model.dart';
import 'package:aamako_maya/src/features/delivery/model/delivery_model.dart';
import 'package:aamako_maya/src/features/pnc/model/pnc_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../authentication/local_storage/authentication_local_storage.dart';

//this is cubit (class)
class DeliverCubit extends Cubit<DeliveryState> {
  Dio dio; //type of data accepted in constructor
  AuthLocalData local;
  DeliverCubit(this.dio, this.local) //constructor
      : super(const DeliveryState(delivery: null, error: null, loading: false));

  //inside class, function is called method
  void getDelivery() async {
    emit(const DeliveryState(delivery: null, loading: true, error: null));
    String token = await local.getTokenFromocal();
    // String token = "4a66f714-9124-4cd1-a0fa-e48789021600";
    try {
      final response = await dio.get("${Urls.deliveryUrl}/$token");
      if (response.statusCode == 200) {
        debugPrint(response.data.toString() + 'delivery');
        final delivery = response.data as List;
        //final delieveryv= response.data;
        // DeliveryModel data= DelievryModel.fromJson(deliverryv);
        //emit DeliveryState(delievery:data,error:null,loading:false);

        List<Deliverymodel> list =
            (delivery).map((e) => Deliverymodel.fromJson(e)).toList();
        debugPrint(list.toString() + ' success');

        emit(DeliveryState(delivery: list, error: null, loading: false));
      } else {
        emit(DeliveryState(
            delivery: state.delivery, error: 'Error', loading: false));
        // debugPrint(response.data.toString() + 'delivery');
      }
    } on DioError catch (e) {
      //e = Internal Server error
      //or e= Bad request
      //or e = 404 not found error
      debugPrint(e.toString() + 'pncs dio');

      emit(DeliveryState(
          delivery: state.delivery, error: e.message, loading: false));
    }
  }
}

class DeliveryState extends Equatable {
  final bool loading;
  final String? error;
  final List<Deliverymodel>? delivery;
  const DeliveryState(
      {required this.delivery, required this.loading, required this.error});
  @override
  List<Object?> get props => [loading, error, delivery];
}
