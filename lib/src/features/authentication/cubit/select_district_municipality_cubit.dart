import 'package:aamako_maya/src/features/authentication/model/municipality_district_model.dart';
import 'package:bloc/bloc.dart';


class SelectDistrictMunicipalityCubit
    extends Cubit<SelectDistrictMunicipalityState> {
  SelectDistrictMunicipalityCubit()
      : super(SelectDistrictMunicipalityState(
            district: null, municipality: null));
  void selectedDistrictMunicipality(
      DistrictModel? dis, MunicipalityModel? munici) {
   
    emit(SelectDistrictMunicipalityState(district: dis, municipality: munici));
  }
}

class SelectDistrictMunicipalityState {
  DistrictModel? district;
  MunicipalityModel? municipality;
  SelectDistrictMunicipalityState(
      {required this.district, required this.municipality});
}
