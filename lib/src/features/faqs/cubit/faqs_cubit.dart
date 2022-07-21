import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/faqs/model/faqs_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class FaqsCubit extends Cubit<FaqsState> {
  final Dio dio;
  FaqsCubit(this.dio)
      : super(FaqsState(faqs: null, error: null, loading: false));

  void getfaqs() async {
    emit(FaqsState(error: null, loading: true, faqs: null));
    try {
      final response = await dio.get(Urls.faqsUrl);

      if (response.statusCode == 200) {
        final faqs = response.data as List;
        List<Faqsmodel> list =
            (faqs).map((e) => Faqsmodel.fromJson(e)).toList();

        emit(FaqsState(error: null, loading: false, faqs: list));
      } else {
        emit(FaqsState(faqs: state.faqs, error: null, loading: false));
      }
    } on DioError catch (e) {
      emit(FaqsState(faqs: state.faqs, error: e.message, loading: false));
    }
  }
}

class FaqsState extends Equatable {
  final bool loading;
  final String? error;
  final List<Faqsmodel>? faqs;
  FaqsState({required this.faqs, required this.error, required this.loading});

  @override
  List<Object?> get props => [faqs, loading, error];
}
