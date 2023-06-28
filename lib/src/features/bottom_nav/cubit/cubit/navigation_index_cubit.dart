import 'package:bloc/bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class NavigationIndexCubit extends Cubit<NavigationIndexState> {
  NavigationIndexCubit()
      : super(const NavigationIndexState(
            appbarTitleEn: 'Home', appbarTitleNp: "होम", index: 0));

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
