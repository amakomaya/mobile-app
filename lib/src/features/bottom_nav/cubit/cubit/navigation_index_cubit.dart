import 'package:aamako_maya/l10n/locale_keys.g.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class NavigationIndexCubit extends Cubit<NavigationIndexState> {
  NavigationIndexCubit()
      : super(
            const NavigationIndexState(appbarTitle: LocaleKeys.home, index: 0));


  changeIndex({required int index, required String title}) {
    emit(NavigationIndexState(appbarTitle: title, index: index));
  }
}

class NavigationIndexState {
  final int index;
  final String appbarTitle;
  const NavigationIndexState({
    required this.appbarTitle,
    required this.index,
  });
}
