import 'dart:async';
import 'dart:convert';

import 'package:Amakomaya/src/core/network_services/urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../models/onboarding_model.dart';

class OnboardingRepo {
  Dio dio;
  OnboardingRepo(this.dio);
  Future<List<WizardModel>> getOnboardingList() async {
    try {
      final Response response = await dio.get(Urls.onboardUrl);
      print(response.data.toString());

      if (response.statusCode == 200) {
        print(200.toString());

        List<WizardModel> wizardList = (response.data as List)
            .map((e) => WizardModel.fromJson(e))
            .toList();
        print(wizardList.toString());

        return wizardList;
      } else {
        return Future.error('error');
      }
    } catch (e) {
      debugPrint('kklad');
      rethrow;
    }
  }
}
