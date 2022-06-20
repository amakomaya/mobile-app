import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/onboarding_model.dart';

class OnboardingRepo {
  Future<List<GuidePagesList>> getOnboardingList() async {
  
    
    Timer(const Duration(seconds: 3), () {
    });

    try{

    final String response =
        await rootBundle.loadString('assets/images/stepper.json');
    List<GuidePagesList> onboarrdingList =
        ((jsonDecode(response))['guide_pages_list'] as List)
            .map((e) => GuidePagesList.fromJson(e))
            .toList();

    return onboarrdingList;
    }catch(e){
      rethrow;
    }
  }
}
