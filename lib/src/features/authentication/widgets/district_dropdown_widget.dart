//District Dropdown
import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        // return DropdownButton<DistrictModel>(
        //   borderRadius: BorderRadius.circular(33),
        //   isExpanded: true,
        //   onChanged: ((value) {
        //     selectedItem = value;
        //     context
        //         .read<DistrictFieldToggleCubit>()
        //         .toggleDistrict(selectedItem?.id ?? 0);
        //   }),
        //   items: districtList
        //       .map((item) => DropdownMenuItem<DistrictModel>(
        //           value: item,
        //           child: Text(
        //             item.districtName ?? '',
        //           )))
        //       .toList(),
        //   value: selectedItem,
        // );

        return TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ShadowContainer(
                      child: ListView.separated(
                          shrinkWrap: true,
                        padding: defaultPadding.copyWith(top: 18, bottom: 18),
                        itemBuilder: (ctx, ind) {
                          return Text(districtList[ind].districtName ?? '');
                        },
                        itemCount: districtList.length,
                        separatorBuilder: (ctx, ind) {
                          return VerticalSpace(20.h);
                        },
                      ),
                    );
                  });
            },
            child: Text('Select a district'));
      },
    );
  }
}
