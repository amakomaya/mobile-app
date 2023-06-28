import 'package:bloc/bloc.dart';

class TogglePageViewCubit extends Cubit<int> {
  TogglePageViewCubit() : super(0);
  void togglePage(int page) {
    emit(page);
  }
}
