import 'package:bloc/bloc.dart';

import '../../../../core/strings/app_strings.dart';

class NavigationIndexCubit extends Cubit<NavigationIndexState> {
  NavigationIndexCubit()
      : super(const NavigationIndexState(
            appbarTitleEn: 'Home', appbarTitleNp: AppStrings.home, index: 0));

  changeIndex(
      {required int index, required String titleEn, required String titleNp}) {
    emit(NavigationIndexState(
        appbarTitleEn: titleEn, appbarTitleNp: titleNp, index: index));
  }
}

class NavigationIndexState {
  final int index;
  final String appbarTitleEn;
  final String appbarTitleNp;
  const NavigationIndexState(
      {required this.appbarTitleEn,
      required this.index,
      required this.appbarTitleNp});
}
