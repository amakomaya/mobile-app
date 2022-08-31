// //District Dropdown
// import 'dart:convert';

// import 'package:aamako_maya/src/core/padding/padding.dart';
// import 'package:aamako_maya/src/core/theme/app_colors.dart';
// import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
// import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
// import 'package:aamako_maya/src/core/widgets/textfield/primary_textfield.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../cubit/district_municipality_cubit.dart';
// import '../cubit/select_district_municipality_cubit.dart';
// import '../cubit/toggle_district_municipality.dart';
// import '../model/municipality_district_model.dart';

// class DistrictDropDownListWidget extends StatefulWidget {
//   final TextEditingController controller;
//   final TextEditingController municipality;
//   final int districtId;
//   const DistrictDropDownListWidget(
//       {Key? key,
//       required this.municipality,
//       required this.districtId,
//       required this.controller})
//       : super(key: key);

//   @override
//   State<DistrictDropDownListWidget> createState() =>
//       _DistrictDropDownListWidgetState();
// }

// class _DistrictDropDownListWidgetState
//     extends State<DistrictDropDownListWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<DistrictMunicipalityCubit, DistrictMunicipalityState>(
//       listener: (context, state) {
//         // print(widget.districtId.toString() + 'gg');
//         // if (state.disctrictModelList.isNotEmpty && widget.districtId != 0) {
//         //   final currentDistrict = state.disctrictModelList.firstWhere(
//         //       (element) => element.id! == widget.districtId,
//         //       orElse: () => DistrictModel());
//         //   widget.controller.text = (currentDistrict.districtName ?? '');

//         //   context
//         //       .read<DistrictFieldToggleCubit>()
//         //       .toggleDistrict(widget.districtId);
//         // }

//         if (state is DistrictMuniciSuccess && widget.districtId == 0) {
//           final currentDistrict = state.disctrictModelList.firstWhere(
//               (element) => element.id! == widget.districtId,
//               orElse: () => DistrictModel());
//           widget.controller.text = (currentDistrict.districtName ?? '');

//           context
//               .read<DistrictFieldToggleCubit>()
//               .toggleDistrict(widget.districtId);

//           context
//               .read<SelectDistrictMunicipalityCubit>()
//               .selectedDistrictMunicipality(currentDistrict, (null));
//         }
//       },
//       builder: (context, state) {
// return Align(
//   alignment: Alignment.centerLeft,
//   child: BlocBuilder<SelectDistrictMunicipalityCubit,
//       SelectDistrictMunicipalityState>(
//     builder: (ctx, st) {
//       return PrimaryTextField(
//         labelText: 'District',
//         hintText: 'Select Your district',
//         controller: widget.controller,
//         readOnly: true,
//         suffix: Icons.arrow_drop_down,
//         onTap: () async {
//           final List<DistrictModel> districtList =
//               (state is DistrictMuniciSuccess)
//                   ? state.disctrictModelList
//                   : [];
//           showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return ShadowContainer(
//                     margin: defaultPadding.copyWith(
//                         top: 27.h, bottom: 27.h),
//                     child: Column(
//                       children: [
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: defaultPadding.copyWith(
//                                 top: 10.h, bottom: 10.h),
//                             child: Text(
//                               'Select your district',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .labelMedium
//                                   ?.copyWith(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 22.sm),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: BlocBuilder<
//                               SelectDistrictMunicipalityCubit,
//                               SelectDistrictMunicipalityState>(
//                             builder:
//                                 (selectionContext, selectionState) {
//                               return ListView.separated(
//                                 shrinkWrap: true,
//                                 padding: defaultPadding.copyWith(
//                                     top: 18, bottom: 18),
//                                 itemBuilder: (ctx, ind) {
//                                   return GestureDetector(
//                                       onTap: () async {
//                                         widget.controller.text =
//                                             (districtList[ind]
//                                                     .districtName ??
//                                                 '');
//                                         widget.municipality.clear();

//                                         context
//                                             .read<
//                                                 DistrictFieldToggleCubit>()
//                                             .toggleDistrict(
//                                                 districtList[ind].id ??
//                                                     0);

//                                         context
//                                             .read<
//                                                 SelectDistrictMunicipalityCubit>()
//                                             .selectedDistrictMunicipality(
//                                                 districtList[ind],
//                                                 (null));

//                                         Navigator.pop(context);
//                                       },
//                                       child: Text(districtList[ind]
//                                               .districtName ??
//                                           ''));
//                                 },
//                                 itemCount: districtList.length,
//                                 separatorBuilder: (ctx, ind) {
//                                   return Divider(
//                                     height: 30.h,
//                                   );
//                                 },
//                               );
//                             },
//                           ),
//                         ),
//                         Align(
//                             alignment: Alignment.centerRight,
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.only(right: 8.0),
//                               child: TextButton(
//                                 child: const Text('Close'),
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                               ),
//                             )),
//                       ],
//                     ));
//               });

//         },
//       );
//     },
//   ),
//         );
//       },
//     );
//   }
// }

import 'dart:convert';

import 'package:aamako_maya/src/core/widgets/textfield/primary_textfield.dart';
import 'package:aamako_maya/src/features/authentication/model/municipality_district_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/padding/padding.dart';
import '../../../core/widgets/helper_widgets/shadow_container.dart';
import '../cubit/toggle_district_municipality.dart';

class DistrictDropDownListWidget extends StatefulWidget {
  final int districtId;
  final TextEditingController controller;
  final ValidatorFunc? validator;
  final TextEditingController retainId;
  final TextEditingController municipalityController;
  const DistrictDropDownListWidget(
      {Key? key,
      required this.controller,
      required this.validator,
      required this.retainId,
      required this.municipalityController,
      required this.districtId})
      : super(key: key);

  @override
  State<DistrictDropDownListWidget> createState() =>
      _DistrictDropDownListWidgetState();
}

class _DistrictDropDownListWidgetState
    extends State<DistrictDropDownListWidget> {
  List<DistrictModel> districts = [];
  void getDistrict() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = prefs.getString('district');
    if (response != null) {
      final data = (jsonDecode(response) as List)
          .map((e) => DistrictModel.fromJson(e))
          .toList();
      districts = data;

      final current = districts.firstWhere(
          (element) => element.id == widget.districtId,
          orElse: () => DistrictModel());
      widget.controller.text = current.districtName ?? '';
    }
  }

  @override
  void initState() {
    getDistrict();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryTextField(
      validator: widget.validator,
      controller: widget.controller,
      readOnly: true,
      labelText: 'District',
      hintText: 'Select Your District',
      suffix: Icons.arrow_drop_down,
      onTap: () async {
        if (districts.isNotEmpty) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return DialogWidget(
                  retainId: widget.retainId,
                  controller: widget.controller,
                  districts: districts,
                  municipalityController: widget.municipalityController,
                );
              });
        }
      },
    );
  }
}

class DialogWidget extends StatefulWidget {
  List<DistrictModel> districts;
  TextEditingController controller;
  TextEditingController municipalityController;
  TextEditingController retainId;
  DialogWidget(
      {Key? key,
      required this.controller,
      required this.retainId,
      required this.municipalityController,
      required this.districts})
      : super(key: key);

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  // filterSearch(String? value) {
  //   widget.districts
  //       .removeWhere((element) => !(element.districtName!.startsWith(value!)));
  //   setState(() {});
  // }

  void _runFilter(String enteredKeyword) {
    List<DistrictModel> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      print(enteredKeyword.toString());
      results = widget.districts;
    } else {
      results = widget.districts
          .where((elemnet) => elemnet.districtName!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    // Refresh the UI
    setState(() {
      _foundDistricts = results;
    });
  }

  List<DistrictModel> _foundDistricts = [];
  @override
  void initState() {
    _foundDistricts = widget.districts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
        width: 380.w,
        margin: defaultPadding.copyWith(top: 27.h, bottom: 27.h),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: defaultPadding.copyWith(top: 10.h, bottom: 10.h),
                child: Text(
                  'Select your district',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 22.sm),
                ),
              ),
            ),
            Material(
              child: Padding(
                padding: defaultPadding,
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Search'),
                  onChanged: (value) {
                    _runFilter(value);
                  },
                ),
              ),
            ),
            Expanded(
                child: ListView.separated(
              shrinkWrap: true,
              padding: defaultPadding.copyWith(top: 18, bottom: 18),
              itemBuilder: (ctx, ind) {
                return GestureDetector(
                    onTap: () async {
                      print('District Name:'+ _foundDistricts[ind].districtName.toString());
                      print('District ID:'+ _foundDistricts[ind].id.toString());
                      //when elements are selected
                      widget.controller.text =
                          _foundDistricts[ind].districtName ?? '';
                      widget.retainId.text =
                          (_foundDistricts[ind].id ?? 0).toString();

                      widget.municipalityController.clear();

                      context
                          .read<DistrictFieldToggleCubit>()
                          .toggleDistrict(_foundDistricts[ind].id!);
                      Navigator.pop(context);
                    },
                    child: Text(_foundDistricts[ind].districtName ?? ''));
              },
              itemCount: _foundDistricts.length,
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
  }
}
