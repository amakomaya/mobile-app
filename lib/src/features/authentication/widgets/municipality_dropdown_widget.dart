//District Dropdown
import 'package:aamako_maya/src/features/authentication/cubit/select_district_municipality_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/padding/padding.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/helper_widgets/shadow_container.dart';
import '../cubit/district_municipality_cubit.dart';
import '../cubit/toggle_district_municipality.dart';
import '../model/municipality_district_model.dart';

class MunicipalityDropdownListWidget extends StatefulWidget {
  const MunicipalityDropdownListWidget({Key? key}) : super(key: key);

  @override
  State<MunicipalityDropdownListWidget> createState() =>
      _MunicipalityDropdownListWidgetState();
}

class _MunicipalityDropdownListWidgetState
    extends State<MunicipalityDropdownListWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: defaultPadding,
        child: BlocConsumer<DistrictFieldToggleCubit, int>(
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

                return GestureDetector(onTap: () {
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
                              child: BlocBuilder<
                                  SelectDistrictMunicipalityCubit,
                                  SelectDistrictMunicipalityState>(
                                builder: (selectionCon, selectionState) {
                                  return ListView.separated(
                                    shrinkWrap: true,
                                    padding: defaultPadding.copyWith(
                                        top: 18, bottom: 18),
                                    itemBuilder: (ctx, ind) {
                                      return GestureDetector(
                                          onTap: () {
                                            context
                                                .read<
                                                    SelectDistrictMunicipalityCubit>()
                                                .selectedDistrictMunicipality(
                                                    selectionState.district,
                                                    (municipalityList[ind]));
                                            Navigator.pop(context);
                                          },
                                          child: Text(municipalityList[ind]
                                                  .municipalityName ??
                                              ''));
                                    },
                                    itemCount: municipalityList.length,
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
                }, child: BlocBuilder<SelectDistrictMunicipalityCubit,
                    SelectDistrictMunicipalityState>(
                  builder: (context, state) {
                    return Text( state.municipality==null? "Tap to select municipality": "${state.municipality?.municipalityName} (Tap to change)");
                  },
                ));
              },
            );
          },
        ),
      ),
    );
  }
}
