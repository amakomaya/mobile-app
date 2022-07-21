import 'package:bloc/bloc.dart';


class PageChangeCubit extends Cubit<int> {
  PageChangeCubit() : super(0);
  void togglePage(int page){
    emit(page);

  }
}
