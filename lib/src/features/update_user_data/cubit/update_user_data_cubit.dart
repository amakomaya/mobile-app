import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'update_user_data_state.dart';

class UpdateUserDataCubit extends Cubit<UpdateUserDataState> {
  final Dio dio;
  final SharedPreferences prefs;
  UpdateUserDataCubit(this.dio, this.prefs) : super(UpdateUserDataInitial());

  void updateProfile() {
    emit(UpdateUserDataLoading());
    try{
      final response = dio.post('');
    }catch(_){
      emit(UpdateUserDataFailure());
    }
  }

  void updateSymptoms() {}
}
