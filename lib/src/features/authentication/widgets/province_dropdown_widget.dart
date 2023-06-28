
import 'dart:convert';

import 'package:aamako_maya/l10n/locale_keys.g.dart';
import 'package:aamako_maya/src/core/widgets/textfield/primary_textfield.dart';
import 'package:aamako_maya/src/features/authentication/model/municipality_district_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/padding/padding.dart';
import '../../../core/widgets/helper_widgets/shadow_container.dart';
import '../cubit/toggle_district_municipality.dart';


class ProvinceDropDownListWidget extends StatefulWidget {
  final int provinceId;
  final TextEditingController controller;
  final ValidatorFunc? validator;
  final TextEditingController retainId;
  final TextEditingController districtController;
  final TextEditingController municipalityController;
  final bool isEditable;
  const ProvinceDropDownListWidget(
      {Key? key,
        required this.controller,
        required this.validator,
        required this.retainId,
        required this.districtController,
        required this.municipalityController,
        this.isEditable = false,
        required this.provinceId})
      : super(key: key);

  @override
  State<ProvinceDropDownListWidget> createState() =>
      _ProvinceDropDownListWidgetState();
}

class _ProvinceDropDownListWidgetState
    extends State<ProvinceDropDownListWidget> {
  List<ProvinceModel> province = [];

  void getDistrict() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = prefs.getString('province');
    if (response != null) {
      final data = (jsonDecode(response) as List)
          .map((e) => ProvinceModel.fromJson(e))
          .toList();
      province = data;
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
      isEditable: widget.isEditable,
      validator: widget.validator,
      controller: widget.controller,
      readOnly: true,
      labelText: LocaleKeys.label_province.tr(),
      hintText:  LocaleKeys.label_select_province.tr(),
      suffix: Icons.arrow_drop_down,
      onTap: () async {
        if (province.isNotEmpty) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return DialogWidget(
                  retainId: widget.retainId,
                  controller: widget.controller,
                  province: province,
                  districtController: widget.districtController,
                  municipalityController: widget.municipalityController,
                );
              });
        }
      },
    );
  }
}

class DialogWidget extends StatefulWidget {
  List<ProvinceModel> province;
  TextEditingController controller;
  TextEditingController retainId;
  TextEditingController districtController;
  TextEditingController municipalityController;
  DialogWidget(
      {Key? key,
        required this.controller,
        required this.retainId,
        required this.districtController,
        required this.municipalityController,
        required this.province})
      : super(key: key);

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  List<ProvinceModel> _foundProvince = [];
  @override
  void initState() {
    _foundProvince = widget.province;
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
                  LocaleKeys.label_select_province.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 22.sm),
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
                          widget.controller.text =
                              _foundProvince[ind].provinceName ?? '';
                          widget.retainId.text =
                              (_foundProvince[ind].provinceId ?? 0).toString();
                          context
                              .read<DistrictFieldToggleCubit>()
                              .toggleDistrict(_foundProvince[ind].provinceId!);
                          widget.districtController.clear();
                          widget.municipalityController.clear();
                          Navigator.pop(context);
                        },
                        child: Text(_foundProvince[ind].provinceName ?? ''));
                  },
                  itemCount: _foundProvince.length,
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
                    child:Text(LocaleKeys.label_close.tr()),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )),
          ],
        ));
  }
}
