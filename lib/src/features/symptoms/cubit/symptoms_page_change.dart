import 'package:bloc/bloc.dart';

class SymptomsPagChangeCubit extends Cubit<int> {
  SymptomsPagChangeCubit() : super(0);
  void togglePage(int page) {
    emit(page);
  }
}
