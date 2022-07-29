import 'package:aamako_maya/src/features/authentication/model/municipality_district_model.dart';
import 'package:bloc/bloc.dart';

import '../repository/municipality_district_repository.dart';

class DistrictMunicipalityCubit extends Cubit<DistrictMunicipalityState> {
  DistrictMunicipalityCubit()
      : super(DistrictMunicipalityState(
          disctrictModelList: [],
          municipalityModelList: [],
        ));

  void startDistrictMunicipalityFetch() async {
    try {
      final List<dynamic> response =
          await MunicipalityDistrictRepository().getMunicipalityDistrict();

      emit(
        DistrictMunicipalityState(
          municipalityModelList: response[0],
          disctrictModelList: response[1],
        ),
      );
    } catch (e) {
      emit(DistrictMunicipalityState(
        municipalityModelList: state.municipalityModelList,
        disctrictModelList: state.disctrictModelList,
      ));
    }
  }
}

class DistrictMunicipalityState {
  final List<MunicipalityModel> municipalityModelList;
  final List<DistrictModel> disctrictModelList;

  DistrictMunicipalityState({
    required this.municipalityModelList,
    required this.disctrictModelList,
  });
}
