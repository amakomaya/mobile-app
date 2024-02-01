import 'package:Amakomaya/src/features/app_update/model/app_update_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../core/network_services/urls.dart';


class AppUpdateCubit extends Cubit<AppUpdateState> {
  Dio dio;
  AppUpdateCubit(this.dio,) : super(AppUpdateInitialState());

  void getVersionCheck() async {
    emit(AppUpdateLoadingState());
      try {
        final response = await dio.get("${Urls.versionCheck}");
        if (response.statusCode == 200) {
          AppUpdateModel appUpdateModel = AppUpdateModel.fromJson(response.data);
          emit(AppUpdateSuccessState(appUpdateModel));
        } else {
          emit(AppUpdateFailureState());
        }
      } on DioError catch (e) {
        emit(AppUpdateFailureState());
      }
  }

}

abstract class AppUpdateState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppUpdateInitialState extends AppUpdateState {}

class AppUpdateLoadingState extends AppUpdateState {}

class AppUpdateSuccessState extends AppUpdateState {
  final AppUpdateModel data;
  AppUpdateSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class AppUpdateFailureState extends AppUpdateState {}
