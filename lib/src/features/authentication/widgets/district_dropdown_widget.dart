//District Dropdown
import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/district_municipality_cubit.dart';
import '../cubit/toggle_district_municipality.dart';
import '../model/municipality_district_model.dart';

class DistrictDropDownListWidget extends StatelessWidget {
  const DistrictDropDownListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DistrictMunicipalityCubit, DistrictMunicipalityState>(
      listener: (context, state) {},
      builder: (context, state) {
        final List<DistrictModel> districtList = state.disctrictModelList;

        DistrictModel? selectedItem;
        return DropdownButton<DistrictModel>(
          isExpanded: true,
          onChanged: ((value) {
            selectedItem = value;
            context
                .read<DistrictFieldToggleCubit>()
                .toggleDistrict(selectedItem?.id ?? 0);
          }),
          items: districtList
              .map((item) => DropdownMenuItem<DistrictModel>(
                  value: item,
                  child: Text(
                    item.districtName ?? '',
                  )))
              .toList(),
          value: selectedItem,
        );
      },
    );
  }
}


 