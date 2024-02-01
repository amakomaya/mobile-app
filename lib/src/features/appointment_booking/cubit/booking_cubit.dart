import 'package:Amakomaya/src/core/connection_checker/network_connection.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/network_services/urls.dart';
import '../model/booking_model.dart';

class BookingCubit extends Cubit<BookingState> {
  final Dio dio;
  final NetworkInfo network;
  final SharedPreferences prefs;

  BookingCubit(this.dio, this.prefs, this.network)
      : super(BookingInitialState());

  void bookingFormSubmit({required BookingModel bookingModel}) async {
    final hasInternet = await network.isConnected;
    if (hasInternet) {
      emit(BookingLoadingState());
      try {
        final response =
            await dio.post("${Urls.postBookingFormData}", data: bookingModel.toJson());
        if (response.statusCode == 200) {
          BookingModel bookingModel = BookingModel.fromJson(response.data);
          emit(BookingSuccessfulState(bookingModel));
        } else {
          emit(BookingFailureState("error"));
        }
      } catch (error) {
        emit(BookingFailureState(error.toString()));
      }
    } else {
      emit(BookingFailureState('No Internet Connection!'));
    }
  }
}

abstract class BookingState extends Equatable {}

class BookingInitialState extends BookingState {
  @override
  List<Object?> get props => [];
}

class BookingSuccessfulState extends BookingState {
  final BookingModel bookingModel;

  BookingSuccessfulState(this.bookingModel);

  @override
  List<Object?> get props => [bookingModel];
}

class BookingFailureState extends BookingState {
  final String error;

  BookingFailureState(this.error);

  @override
  List<Object?> get props => [error];
}

class BookingLoadingState extends BookingState {
  @override
  List<Object?> get props => [];
}
