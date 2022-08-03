//District Dropdown
import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/district_municipality_cubit.dart';
import '../cubit/select_district_municipality_cubit.dart';
import '../cubit/toggle_district_municipality.dart';
import '../model/municipality_district_model.dart';

class DistrictDropDownListWidget extends StatefulWidget {
  const DistrictDropDownListWidget({Key? key}) : super(key: key);

  @override
  State<DistrictDropDownListWidget> createState() =>
      _DistrictDropDownListWidgetState();
}

class _DistrictDropDownListWidgetState
    extends State<DistrictDropDownListWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DistrictMunicipalityCubit, DistrictMunicipalityState>(
      listener: (context, state) {},
      builder: (context, state) {
        final List<DistrictModel> districtList = state.disctrictModelList;


        return Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: defaultPadding,
            child: GestureDetector(onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ShadowContainer(
                        child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(18.0),
                                  child: Icon(
                                    Icons.close_sharp,
                                    color: AppColors.accentGrey,
                                  ),
                                ))),
                        Expanded(
                          child: BlocBuilder<SelectDistrictMunicipalityCubit,
                              SelectDistrictMunicipalityState>(
                            builder: (selectionContext, selectionState) {
                              return ListView.separated(
                                shrinkWrap: true,
                                padding: defaultPadding.copyWith(
                                    top: 18, bottom: 18),
                                itemBuilder: (ctx, ind) {
                                  return GestureDetector(
                                      onTap: () {
                                        context
                                            .read<DistrictFieldToggleCubit>()
                                            .toggleDistrict(
                                                districtList[ind].id ?? 0);

                                        context
                                            .read<
                                                SelectDistrictMunicipalityCubit>()
                                            .selectedDistrictMunicipality(
                                                districtList[ind],
                                                (null));
                                       
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                          districtList[ind].districtName ??
                                              ''));
                                },
                                itemCount: districtList.length,
                                separatorBuilder: (ctx, ind) {
                                  return Divider(
                                    height: 30.h,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ));
                  });
            }, child: BlocBuilder<SelectDistrictMunicipalityCubit, SelectDistrictMunicipalityState>(
              builder: (context, state) {
                return Text(state.district==null?"Tap to select district": "${state.district?.districtName} (Tap to change)");
              },
            )),
          ),
        );
      },
    );
  }
}
