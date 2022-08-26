// //District Dropdown
// import 'package:aamako_maya/src/core/widgets/textfield/primary_textfield.dart';
// import 'package:aamako_maya/src/features/authentication/cubit/select_district_municipality_cubit.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../core/padding/padding.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/widgets/helper_widgets/shadow_container.dart';
// import '../cubit/district_municipality_cubit.dart';
// import '../cubit/toggle_district_municipality.dart';
// import '../model/municipality_district_model.dart';

// class MunicipalityDropdownListWidget extends StatefulWidget {
//   final TextEditingController controller;
//   final int municipalityId;
//   const MunicipalityDropdownListWidget({Key? key,required this.municipalityId, required this.controller})
//       : super(key: key);

//   @override
//   State<MunicipalityDropdownListWidget> createState() =>
//       _MunicipalityDropdownListWidgetState();
// }

// class _MunicipalityDropdownListWidgetState
//     extends State<MunicipalityDropdownListWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: BlocConsumer<DistrictFieldToggleCubit, int>(
//         listener: (ctx, id) {},
//         builder: (ctx, id) {
//           return BlocConsumer<DistrictMunicipalityCubit,
//               DistrictMunicipalityState>(
//             listener: (context, state) {},
//             builder: (context, state) {
//               final List<MunicipalityModel> municipalityList =  (state is DistrictMuniciSuccess)? state
//                   .municipalityModelList
//                   .where((element) => int.parse(element.districtId!) == id)
//                   .toList() :[];

//               // if (widget.controller.text.trim().isNotEmpty) {

//               //   final currentDistrict = municipalityList.firstWhere(
//               //       (element) =>
//               //           element.id!.toString().trim() == widget.controller.text.trim(),
//               //       orElse: () => MunicipalityModel());

//               //   widget.controller.text = currentDistrict.municipalityName ?? '';
//               // }

//               return BlocBuilder<SelectDistrictMunicipalityCubit,
//                   SelectDistrictMunicipalityState>(
//                 builder: (ctx, st) {
//                   return PrimaryTextField(
//                     controller: widget.controller,
//                     labelText: "Municipality",
//                     hintText: 'Select Your municipality',
//                     suffix: Icons.arrow_drop_down,
//                     readOnly: true,
//                     onTap: () {
//                       showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return ShadowContainer(
//                                 margin: defaultPadding.copyWith(
//                                     top: 27.h, bottom: 27.h),
//                                 child: Column(
//                                   children: [
//                                     Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Padding(
//                                         padding: defaultPadding.copyWith(
//                                             top: 10.h, bottom: 10.h),
//                                         child: Text(
//                                           'Select your municipality',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .labelMedium
//                                               ?.copyWith(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 22.sm),
//                                         ),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: BlocBuilder<
//                                           SelectDistrictMunicipalityCubit,
//                                           SelectDistrictMunicipalityState>(
//                                         builder:
//                                             (selectionCon, selectionState) {
//                                           return ListView.separated(
//                                             shrinkWrap: true,
//                                             padding: defaultPadding.copyWith(
//                                                 top: 18, bottom: 18),
//                                             itemBuilder: (ctx, ind) {
//                                               return GestureDetector(
//                                                   onTap: () {
//                                                     print(municipalityList[
//                                                                 ind].id.toString());

//                                                     widget.controller
//                                                         .text = (municipalityList[
//                                                                 ind]
//                                                             .municipalityName ??
//                                                         '');
//                                                     context
//                                                         .read<
//                                                             SelectDistrictMunicipalityCubit>()
//                                                         .selectedDistrictMunicipality(
//                                                             selectionState
//                                                                 .district,
//                                                             (municipalityList[
//                                                                 ind]));
//                                                     Navigator.pop(context);
//                                                   },
//                                                   child: Text(municipalityList[
//                                                               ind]
//                                                           .municipalityName ??
//                                                       ''));
//                                             },
//                                             itemCount: municipalityList.length,
//                                             separatorBuilder: (ctx, ind) {
//                                               return Divider(
//                                                 height: 30.h,
//                                               );
//                                             },
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                     Align(
//                                         alignment: Alignment.centerRight,
//                                         child: Padding(
//                                           padding:
//                                               const EdgeInsets.only(right: 8.0),
//                                           child: TextButton(
//                                             child: Text('Close'),
//                                             onPressed: () {
//                                               Navigator.of(context).pop();
//                                             },
//                                           ),
//                                         )),
//                                   ],
//                                 ));
//                           });
//                     },
//                   );
//                   // return state.municipality == null
//                   //     ? Text(
//                   //         "Tap to select municipality",
//                   //         style: Theme.of(context)
//                   //             .textTheme
//                   //             .headlineMedium
//                   //             ?.copyWith(color: AppColors.primaryRed),
//                   //       )
//                   //     : RichText(
//                   //         text: TextSpan(
//                   //             text: "${state.municipality?.municipalityName}",
//                   //             style: Theme.of(context).textTheme.labelMedium,
//                   //             children: [
//                   //             TextSpan(
//                   //               text: " (Tap to change)",
//                   //               style: Theme.of(context)
//                   //                   .textTheme
//                   //                   .headlineMedium
//                   //                   ?.copyWith(color: AppColors.primaryRed),
//                   //             )
//                   //           ]));
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:aamako_maya/src/features/authentication/cubit/toggle_district_municipality.dart';
import 'package:aamako_maya/src/features/authentication/model/municipality_district_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/padding/padding.dart';
import '../../../core/widgets/helper_widgets/shadow_container.dart';
import '../../../core/widgets/textfield/primary_textfield.dart';

class MunicipalityDropdownListWidget extends StatefulWidget {
  final TextEditingController controller;
  final int districtId;
  final int municipalityId;
  const MunicipalityDropdownListWidget(
      {Key? key,
      required this.municipalityId,
      required this.districtId,
      required this.controller})
      : super(key: key);

  @override
  State<MunicipalityDropdownListWidget> createState() =>
      _MunicipalityDropdownListWidgetState();
}

class _MunicipalityDropdownListWidgetState
    extends State<MunicipalityDropdownListWidget> {
  List<MunicipalityModel> municipalities = [];
  List<MunicipalityModel> allMunicipalities = [];
  void getMunicipality() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = prefs.getString('municipality');
    if (response != null) {
      final data = (jsonDecode(response) as List)
          .map((e) => MunicipalityModel.fromJson(e))
          .toList();
      allMunicipalities = data;
      final municipal = data
          .where(
              (element) => int.parse(element.districtId!) == widget.districtId)
          .toList();

      municipalities = municipal;

      final current = municipalities.firstWhere(
          (element) => element.id == widget.municipalityId,
          orElse: () => MunicipalityModel());
      widget.controller.text = current.municipalityName ?? '';
    }
  }

  @override
  void initState() {
    getMunicipality();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DistrictFieldToggleCubit, int>(
      listener: (context, stateId) {
        if (stateId != 0) {
          municipalities.clear();
          municipalities = allMunicipalities
              .where((element) => int.parse(element.districtId!) == stateId)
              .toList();
        }
      },
      builder: (context, state) {
        return PrimaryTextField(
          controller: widget.controller,
          readOnly: true,
          labelText: 'Municipality/VDC',
          hintText: 'Select Your Municipality/VDC',
          suffix: Icons.arrow_drop_down,
          onTap: () async {
            if (municipalities.isNotEmpty) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ShadowContainer(
                        margin:
                            defaultPadding.copyWith(top: 27.h, bottom: 27.h),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: defaultPadding.copyWith(
                                    top: 10.h, bottom: 10.h),
                                child: Text(
                                  'Select your municipality',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22.sm),
                                ),
                              ),
                            ),
                            Expanded(
                                child: ListView.separated(
                              shrinkWrap: true,
                              padding:
                                  defaultPadding.copyWith(top: 18, bottom: 18),
                              itemBuilder: (ctx, ind) {
                                return GestureDetector(
                                    onTap: () async {
                                      widget.controller.text =
                                          municipalities[ind]
                                                  .municipalityName ??
                                              '';
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                        municipalities[ind].municipalityName ??
                                            ''));
                              },
                              itemCount: municipalities.length,
                              separatorBuilder: (ctx, ind) {
                                return Divider(
                                  height: 30.h,
                                );
                              },
                            )),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: TextButton(
                                    child: const Text('Close'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                )),
                          ],
                        ));
                  });
            }
          },
        );
      },
    );
  }
}
