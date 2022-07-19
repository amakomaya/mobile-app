import 'package:aamako_maya/src/features/medication/model/medication_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class MedicationCubit extends Cubit<MedicationState> {
  MedicationCubit() : super(MedicationState(medication: null));
}

class MedicationState extends Equatable {
  List<Medicationmodel>? medication;

  MedicationState({this.medication});
  @override
  // TODO: implement props
  List<Object?> get props => [medication];
}
