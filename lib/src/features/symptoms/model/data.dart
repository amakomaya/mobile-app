import 'package:aamako_maya/src/features/symptoms/model/assessment_model.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../l10n/locale_keys.g.dart';


List<DeliveryModel> postnatal = [
  DeliveryModel(  key: 'headache',
      id: 1, isSelected: false, problem: "Having a little too much headache", problemNp: 'धेरै टाउको दुख्नु '),
  DeliveryModel( key: 'vaginal_bleeding',id: 2, isSelected: false, problem: "Bleeding from vagina", problemNp: 'पाठेघरबाट रगत बग्नु'),
  DeliveryModel( key: 'trembling_hands_feet',
      id: 3, isSelected: false, problem:  "Hands and feet tremble or faint", problemNp: 'हात र खुट्टा काम्नु वा बेहोस हुनु'),
  DeliveryModel(   key: 'fever',id: 4, isSelected: false, problem: "Fever", problemNp: 'ज्वरो आउनु '),
  DeliveryModel( key: 'lower_abdominal_pain',
      id: 5,
      isSelected: false,
      problem: "Smelling water from vagina or lower abdominal pain", problemNp: 'पाठेघरबाट पानी बग्नु वा तल्लो पेट दुख्नु '),
  DeliveryModel( key: 'fever_degree',
      id: 6, isSelected: false, problem: "Fever above 100.4 degrees", problemNp: '100.4 डिग्री भन्दा माथि ज्वरो आउनु '),
  DeliveryModel(    key: 'breathing_difficulty',

      id: 7, isSelected: false, problem:"Difficulty in breathing", problemNp: 'सास फेर्न गाह्रो हुनु'),
  DeliveryModel(key: 'cough_cold',id: 8, isSelected: false, problem: "Cough and cold", problemNp: 'रुघाखोकी र चिसो लग्नु '),
];

List<DeliveryModel> pregnancy = [
  DeliveryModel( key: 'headache',
      id: 1, isSelected: false, problem: "Having a little too much headache", problemNp: 'धेरै टाउको दुख्नु '),
  DeliveryModel( key: 'vaginal_bleeding',id: 2, isSelected: false,problem: "Bleeding from vagina", problemNp: 'पाठेघरबाट रगत बग्नु'),
  DeliveryModel( key: 'trembling_hands_feet',
      id: 3, isSelected: false, problem:  "Hands and feet tremble or faint", problemNp: 'हात र खुट्टा काम्नु वा बेहोस हुनु'),
  DeliveryModel( key: 'blurred_eyes',id: 4, isSelected: false, problem:  "Eyes blurred", problemNp: 'आँखा धमिलो हुनु '),
  DeliveryModel(   key: 'first_month_abdominal_pain',
      id: 5,
      isSelected: false,
      problem: "Abdominal pain in the first month of pregnancy", problemNp: 'गर्भावस्थाको पहिलो महिनामा पेट दुख्नु '),
  DeliveryModel(key: 'fever_degree',
      id: 6, isSelected: false, problem: "Fever above 100.4 degrees", problemNp: '100.4 डिग्री भन्दा माथि ज्वरो आउनु '),
  DeliveryModel(    key: 'breathing_difficulty',

      id: 7, isSelected: false, problem:"Difficulty in breathing", problemNp: 'सास फेर्न गाह्रो हुनु'),
  DeliveryModel(  key: 'cough_cold',id: 8, isSelected: false, problem: "Cough and cold", problemNp: 'रुघाखोकी र चिसो लग्नु '),
];

List<DeliveryModel> delivery = [
  DeliveryModel( key: 'labor_pain',
      id: 1, isSelected: false, problem:"Labor pain for more than 8 hours", problemNp: '८ घण्टाभन्दा बढी समयसम्म सुत्केरी व्यथा लाग्नु '),
  DeliveryModel( key: 'cord_protrusion',
      id: 2,
      isSelected: false,
      problem: "First hand,leg or umbilical cord protrusion", problemNp: 'पहिलो हात, खुट्टा वा गर्भनाल प्रोट्रुसन'),
  DeliveryModel( key: 'trembling_hands_feet',
      id: 3, isSelected: false,  problem:  "Hands and feet tremble or faint", problemNp: 'हात र खुट्टा काम्नु वा बेहोस हुनु'),
  DeliveryModel( key: 'excessive_bleeding_birth',
      id: 4,
      isSelected: false,
      problem: "A lot of bleeding before or after the baby was born", problemNp: 'बच्चा जन्मनु अघि वा पछि धेरै रगत बग्नु '),
  DeliveryModel(    key: 'breathing_difficulty',
      id: 5, isSelected: false, problem:"Difficulty in breathing", problemNp: 'सास फेर्न गाह्रो हुनु'),
  DeliveryModel(  key: 'cough_cold',id: 6, isSelected: false,problem: "Cough and cold", problemNp: 'रुघाखोकी र चिसो लग्नु '),
];
