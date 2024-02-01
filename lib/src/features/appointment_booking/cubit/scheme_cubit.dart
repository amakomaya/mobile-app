import 'dart:convert';

import 'package:Amakomaya/src/core/network_services/urls.dart';
import 'package:Amakomaya/src/features/appointment_booking/model/scheme_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SchemeCubit extends Cubit<SchemeState> {
  SharedPreferences prefs;
  Dio dio;
  SchemeCubit(this.dio, this.prefs)
      : super(SchemeInitial());

  void startSchemeFetch() async {
    final res = prefs.getString('general_scheme');
    final res1 = prefs.getString('paying_scheme');

    if (res != null && res1 != null) {
      final data = (jsonDecode(res) as List)
          .map((e) => SchemeGeneralModel.fromJson(e))
          .toList();

      final data1 = (jsonDecode(res1) as List)
          .map((e) => SchemePayingModel.fromJson(e))
          .toList();
          
      emit(
        SchemeSuccess(
          schemeGeneralModelList: data,
          schemePayingModelList: data1,
        ),
      );
    } else {
      emit(
        SchemeSuccess(
          schemeGeneralModelList: [],
          schemePayingModelList: [],
        ),
      );
    }
  }
}

abstract class SchemeState extends Equatable {
 
}
class SchemeInitial extends SchemeState{
  @override
  List<Object?> get props => [];
}

class SchemeSuccess extends SchemeState{
   final List<SchemeGeneralModel> schemeGeneralModelList;
  final List<SchemePayingModel> schemePayingModelList;

   SchemeSuccess({
    required this.schemeGeneralModelList,
    required this.schemePayingModelList,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [schemeGeneralModelList,schemePayingModelList];
}

class Scheme {
  Dio dio;
  SharedPreferences prefs;
  Scheme(this.dio, this.prefs);
  Future fetchScheme() async {
    try {
      final response = await Future.wait(
          [dio.get(Urls.getSchemeGeneral),dio.get(Urls.getSchemePaying)]);
      print("aaaaaa set ${jsonEncode(response[0].data)}");
     final result= await prefs.setString('general_scheme', jsonEncode(response[0].data));
    final result1=  await prefs.setString('paying_scheme', jsonEncode(response[1].data));


      return true;
    } catch (_) {
      return Future.error('error');
    }
  }
}
