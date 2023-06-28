import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit() : super(DrawerState(0));

  void checkDrawerSelection(int index) {
    print(index.toString() + "bbc");
    emit(DrawerState(index));
  }
}

class DrawerState extends Equatable {
  final int? index;

  DrawerState(this.index);

  @override
  List<Object?> get props => [index];
}
