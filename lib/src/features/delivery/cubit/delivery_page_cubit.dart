import 'package:flutter_bloc/flutter_bloc.dart';

class DeliverPageCubit extends Cubit<int> {
  DeliverPageCubit() : super(0);
  void togglePage(int page) {
    emit(page);
  }
}
