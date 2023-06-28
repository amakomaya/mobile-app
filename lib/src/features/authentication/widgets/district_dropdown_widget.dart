
import 'dart:convert';

import 'package:aamako_maya/l10n/locale_keys.g.dart';
import 'package:aamako_maya/src/features/authentication/cubit/toggle_district_municipality.dart';
import 'package:aamako_maya/src/features/authentication/model/municipality_district_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/padding/padding.dart';
import '../../../core/widgets/helper_widgets/shadow_container.dart';
import '../../../core/widgets/textfield/primary_textfield.dart';

class DistrictDropdownListWidget extends StatefulWidget {
  final TextEditingController controller;
  final int districtId;
  final int provinceId;
  final TextEditingController retainId;
  final ValidatorFunc? validator;
  final bool isEditable;
  final TextEditingController municipalityController;

  const DistrictDropdownListWidget(
      {Key? key,
      required this.provinceId,
      required this.retainId,
      required this.validator,
      required this.districtId,
      required this.controller,
      required this.municipalityController,
      this.isEditable = true})
      : super(key: key);

  @override
  State<DistrictDropdownListWidget> createState() =>
      _DistrictDropdownListWidgetState();
}

class _DistrictDropdownListWidgetState
    extends State<DistrictDropdownListWidget> {
  List<DistrictModel> districts = [];
  List<DistrictModel> allDistricts = [];
  void getMunicipality() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = prefs.getString('district');
    if (response != null) {
      final data = (jsonDecode(response) as List)
          .map((e) => DistrictModel.fromJson(e))
          .toList();
      allDistricts = data;
      final dist = data
          .where((element) =>
              int.parse(element.provinceId!.toString()) == widget.provinceId)
          .toList();

      districts = dist;

      final current = districts.firstWhere(
          (element) => element.id == widget.districtId,
          orElse: () => DistrictModel());
      widget.controller.text = current.districtName ?? '';
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
          districts.clear();
          districts = allDistricts
              .where((element) =>
                  int.parse(element.provinceId!.toString()) == stateId)
              .toList();
        }
      },
      builder: (context, state) {
        return PrimaryTextField(
          isEditable: widget.isEditable,
          validator: widget.validator,
          controller: widget.controller,
          readOnly: true,
          labelText: LocaleKeys.label_distrct.tr(),
          hintText: LocaleKeys.label_select_district.tr(),
          suffix: Icons.arrow_drop_down,
          onTap: () async {
            if (districts.isNotEmpty) {
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
                                  LocaleKeys.label_select_district.tr(),
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
                                          districts[ind]
                                                  .districtName ??
                                              '';
                                      widget.retainId.text =
                                          (districts[ind].id ?? 0)
                                              .toString();
                                      widget.municipalityController.clear();
                                      context
                                          .read<DistrictFieldToggleCubit>()
                                          .toggleDistrict(districts[ind].id!);
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                        districts[ind].districtName ??
                                            ''));
                              },
                              itemCount: districts.length,
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
                                    child: Text(LocaleKeys.label_close.tr()),
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
