import 'package:aamako_maya/src/features/authentication/model/municipality_district_model.dart';
import 'package:dio/dio.dart';

import '../../../core/network_services/urls.dart';

class MunicipalityDistrictRepository {
  Response? response;
  var dio = Dio();

  getMunicipalityDistrict() async {
    try {
      final response = await Future.wait(
          [dio.get(Urls.getDistrict), dio.get(Urls.getMunicipality)]);
      if (response[0].statusCode == 200 && response[1].statusCode == 200) {
        List<DistrictModel> disList = (response[0].data as List)
            .map((e) => DistrictModel.fromJson(e))
            .toList();
        List<MunicipalityModel> muList = (response[1].data as List)
            .map((e) => MunicipalityModel.fromJson(e))
            .toList();
      

        return [muList, disList];
      } else {
        print(response[0].statusCode);
        throw response[0].data['message'];
      }
    } on DioError catch (e) {
      throw e.message;
    }
  }
}
