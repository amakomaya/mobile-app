import 'dart:convert';

import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/authentication/model/municipality_district_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DistrictMunicipalityCubit extends Cubit<DistrictMunicipalityState> {
  SharedPreferences prefs;
  Dio dio;
  DistrictMunicipalityCubit(this.dio, this.prefs)
      : super(DistrictMuniCiInitial());

  void startDistrictMunicipalityFetch() async {
    final res = prefs.getString('district');
    final res1 = prefs.getString('municipality');

    if (res != null && res1 != null) {
      final data = (jsonDecode(res) as List)
          .map((e) => DistrictModel.fromJson(e))
          .toList();

      final data1 = (jsonDecode(res1) as List)
          .map((e) => MunicipalityModel.fromJson(e))
          .toList();
          
      emit(
        DistrictMuniciSuccess(
          municipalityModelList: data1,
          disctrictModelList: data,
        ),
      );
    } else {
      emit(
        DistrictMuniciSuccess(
          municipalityModelList: [],
          disctrictModelList: [],
        ),
      );
    }
  }
}

abstract class DistrictMunicipalityState extends Equatable {
 
}
class DistrictMuniCiInitial extends DistrictMunicipalityState{
  @override
  List<Object?> get props => [];
}

class DistrictMuniciSuccess extends DistrictMunicipalityState{
   final List<MunicipalityModel> municipalityModelList;
  final List<DistrictModel> disctrictModelList;

  DistrictMuniciSuccess({
    required this.municipalityModelList,
    required this.disctrictModelList,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [municipalityModelList,disctrictModelList];
}

class DistrictMunicipality {
  Dio dio;
  SharedPreferences prefs;
  DistrictMunicipality(this.dio, this.prefs);
  Future fetchDistrictAndMunicipality() async {
    try {
      final response = await Future.wait(
          [dio.get(Urls.getDistrict), dio.get(Urls.getMunicipality),dio.get(Urls.getProvince)]);

     final result= await prefs.setString('district', jsonEncode(response[0].data));
    final result1=  await prefs.setString('municipality', jsonEncode(response[1].data));
    final result2=  await prefs.setString('province', jsonEncode(response[2].data));


      return true;
    } catch (_) {
      return Future.error('error');
    }
  }
}
