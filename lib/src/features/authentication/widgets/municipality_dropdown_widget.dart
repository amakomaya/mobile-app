import 'dart:convert';

import 'package:Amakomaya/l10n/locale_keys.g.dart';
import 'package:Amakomaya/src/features/authentication/cubit/toggle_district_municipality.dart';
import 'package:Amakomaya/src/features/authentication/model/municipality_district_model.dart';
import 'package:easy_localization/easy_localization.dart';
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
  final TextEditingController retainId;
  final ValidatorFunc? validator;
  final bool isEditable;

  const MunicipalityDropdownListWidget(
      {Key? key,
      required this.municipalityId,
      required this.retainId,
      required this.validator,
      required this.districtId,
      required this.controller,
      this.isEditable = true})
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
          .where((element) =>
              int.parse(element.districtId!.toString()) == widget.districtId)
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
              .where((element) =>
                  int.parse(element.districtId!.toString()) == stateId)
              .toList();
        }
      },
      builder: (context, state) {
        return PrimaryTextField(
          isEditable: widget.isEditable,
          validator: widget.validator,
          controller: widget.controller,
          readOnly: true,
          labelText: LocaleKeys.lable_municipality_vdc.tr(),
          hintText: LocaleKeys.label_select_municipality.tr(),
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
                                  LocaleKeys.label_select_municipality.tr(),
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
                                      widget.retainId.text =
                                          (municipalities[ind].id ?? 0)
                                              .toString();
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
