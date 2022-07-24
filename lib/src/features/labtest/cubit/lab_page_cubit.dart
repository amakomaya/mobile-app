import 'package:bloc/bloc.dart';

class LabPageCubit extends Cubit<int> {
  LabPageCubit() : super(0);
  void togglePage(int page) {
    emit(page);
  }
}
