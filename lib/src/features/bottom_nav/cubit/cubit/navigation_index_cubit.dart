import 'package:aamako_maya/l10n/locale_keys.g.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

class NavigationIndexCubit extends Cubit<NavigationIndexState> {
  NavigationIndexCubit() : super( NavigationIndexState(appbarTitle: LocaleKeys.home.tr(),index: 0));
  changeIndex({required int index,required String title}) {
    print(index.toString()+title);
    emit(NavigationIndexState(appbarTitle: title, index: index));
  }
}


class NavigationIndexState extends Equatable{
 final int index;
 final String appbarTitle;
 const  NavigationIndexState({required this.appbarTitle,required this.index});

  @override

  List<Object?> get props => [index,appbarTitle];

  
}