import 'dart:convert';

import 'package:Amakomaya/src/core/network_services/urls.dart';
import 'package:Amakomaya/src/features/faqs/model/faqs_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FaqsCubit extends Cubit<FaqsState> {
  final Dio dio;
  final SharedPreferences prefs;
  FaqsCubit(this.dio, this.prefs) : super(FaqInitialState());

  void getfaqs(bool isRefreshed) async {
    // emit(FaqLoadingState());

    final response = prefs.getString('faqs');
    if (response != null && isRefreshed == false) {
      final faqs = jsonDecode(response) as List;
      List<Faqsmodel> list = (faqs).map((e) => Faqsmodel.fromJson(e)).toList();
      emit(FaqSuccessState(list,false));
    } else {
      try {
        final response = await dio.get(Urls.faqsUrl);

        if (response.statusCode == 200) {
          final faqs = response.data as List;
          await prefs.setString('faqs', jsonEncode(faqs));
          List<Faqsmodel> list =
              (faqs).map((e) => Faqsmodel.fromJson(e)).toList();

          emit(FaqSuccessState(list,isRefreshed));
        } else {
          emit(FaqFailureState());
        }
      } on DioError catch (e) {
        emit(FaqFailureState());
      }
    }
  }
}

abstract class FaqsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FaqSuccessState extends FaqsState {
  final List<Faqsmodel> faqs;
  final bool isRefreshed;
  FaqSuccessState(this.faqs,this.isRefreshed);
  @override
  List<Object?> get props => [faqs];
}

class FaqInitialState extends FaqsState {}

class FaqFailureState extends FaqsState {}

class FaqLoadingState extends FaqsState {}
