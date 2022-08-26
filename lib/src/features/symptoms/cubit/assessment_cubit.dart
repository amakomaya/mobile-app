import 'package:bloc/bloc.dart';

import '../model/assessment_model.dart';

class AssessmentCubit extends Cubit<int> {
  AssessmentCubit() : super(0);
   List<PostnatalModel> postnatalComplications = [
    PostnatalModel(
        id: 1, isSelected: false, problem: 'Having a little too much headache'),
    PostnatalModel(id: 2, isSelected: false, problem: 'Bleeding from vagina'),
    PostnatalModel(
        id: 3, isSelected: false, problem: 'Hands and feet tremble or faint'),
    PostnatalModel(id: 4, isSelected: false, problem: 'Fever'),
    PostnatalModel(
        id: 5,
        isSelected: false,
        problem: 'Smelling water from vagina or lower abdominal pain'),
    PostnatalModel(
        id: 6, isSelected: false, problem: 'Fever above 100.4 degrees'),
    PostnatalModel(
        id: 7, isSelected: false, problem: 'Difficulty in breathing'),
    PostnatalModel(id: 8, isSelected: false, problem: 'Cough and cold'),
  ];

  List<PregnancyModel> pregnancyComplications = [
    PregnancyModel(
        id: 1, isSelected: false, problem: 'Having a little too much headache'),
    PregnancyModel(id: 2, isSelected: false, problem: 'Bleeding from vagina'),
    PregnancyModel(
        id: 3, isSelected: false, problem: 'Hands and feet tremble or faint'),
    PregnancyModel(id: 4, isSelected: false, problem: 'Eyes blurred'),
    PregnancyModel(
        id: 5,
        isSelected: false,
        problem: 'Abdominal pain in the first month of pregnancy'),
    PregnancyModel(
        id: 6, isSelected: false, problem: 'Fever above 100.4 degrees'),
    PregnancyModel(
        id: 7, isSelected: false, problem: 'Difficulty in breathing'),
    PregnancyModel(id: 8, isSelected: false, problem: 'Cough and cold'),
  ];

  List<DeliveryModel> deliveryComplications = [
    DeliveryModel(
        id: 1, isSelected: false, problem: 'Labor pain for more than 8 hours'),
    DeliveryModel(
        id: 2,
        isSelected: false,
        problem: 'First hand,leg or umbilical cord protrusion'),
    DeliveryModel(
        id: 3, isSelected: false, problem: 'Hands and feet tremble or faint'),
    DeliveryModel(
        id: 4,
        isSelected: false,
        problem: 'A lot of bleeding before or after the baby was born'),
    DeliveryModel(id: 5, isSelected: false, problem: 'Difficulty in breathing'),
    DeliveryModel(id: 6, isSelected: false, problem: 'Cough and cold'),
  ];
  void togglePage(int page) {
    emit(page);
  }
}
