import 'package:flutter_bloc/flutter_bloc.dart';

class DistrictFieldToggleCubit extends Cubit<int> {
  DistrictFieldToggleCubit() : super(0);

  void toggleDistrict(int value) {
    emit(value);
  }
}
