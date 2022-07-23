import 'package:bloc/bloc.dart';

class PcnChangecubit extends Cubit<int> {
  PcnChangecubit() : super(0);
  void togglePage(int page) {
    emit(page);
  }
}
