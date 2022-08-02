//District Dropdown
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/district_municipality_cubit.dart';
import '../cubit/toggle_district_municipality.dart';
import '../model/municipality_district_model.dart';

class MunicipalityDropdownListWidget extends StatelessWidget {
  const MunicipalityDropdownListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DistrictFieldToggleCubit, int>(
      listener: (ctx, id) {},
      builder: (ctx, id) {
        return BlocConsumer<DistrictMunicipalityCubit,
            DistrictMunicipalityState>(
          listener: (context, state) {},
          builder: (context, state) {
            final List<MunicipalityModel> municipalityList = state
                .municipalityModelList
                .where((element) => int.parse(element.districtId!) == id)
                .toList();

            String? selectedItem;
            return DropdownButton<String>(
              borderRadius: BorderRadius.circular(33),
              isExpanded: true,
              onChanged: ((value) {
                selectedItem = value;
              }),
              items: municipalityList
                  .map((item) => DropdownMenuItem<String>(
                      value: item.municipalityName,
                      child: Text(
                        item.municipalityName ?? '',
                      )))
                  .toList(),
              value: selectedItem,
            );
          },
        );
      },
    );
  }
}
