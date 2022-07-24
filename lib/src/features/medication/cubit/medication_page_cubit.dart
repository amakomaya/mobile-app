import 'package:bloc/bloc.dart';

class MedicationPageCubit extends Cubit<int> {
  MedicationPageCubit() : super(0);
  void togglePage(int page) {
    emit(page);
  }
}
