import 'dart:convert';

import 'package:Amakomaya/l10n/locale_keys.g.dart';
import 'package:Amakomaya/src/core/widgets/textfield/primary_textfield.dart';
import 'package:Amakomaya/src/features/appointment_booking/model/scheme_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/padding/padding.dart';
import '../../../core/widgets/helper_widgets/shadow_container.dart';

class SchemePayingDropDownListWidget extends StatefulWidget {
  final TextEditingController controller;
  final ValidatorFunc? validator;
  final bool isEditable;
  final TextEditingController retainId;

  const SchemePayingDropDownListWidget(
      {Key? key,
      required this.controller,
      required this.validator,
      required this.retainId,
      this.isEditable = false})
      : super(key: key);

  @override
  State<SchemePayingDropDownListWidget> createState() =>
      _SchemePayingDropDownListWidgetState();
}

class _SchemePayingDropDownListWidgetState
    extends State<SchemePayingDropDownListWidget> {
  List<SchemePayingModel> payingScheme = [];

  void getGeneralScheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = prefs.getString('paying_scheme');
    if (response != null) {
      final data = (jsonDecode(response) as List)
          .map((e) => SchemePayingModel.fromJson(e))
          .toList();
      payingScheme = data;
    }
  }

  @override
  void initState() {
    getGeneralScheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryTextField(
      isEditable: widget.isEditable,
      validator: widget.validator,
      controller: widget.controller,
      readOnly: true,
      labelText:"",
      hintText: LocaleKeys.label_select_doctor.tr(),
      suffix: Icons.arrow_drop_down,
      onTap: () async {
        if (payingScheme.isNotEmpty) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return DialogWidget(
                  retainId: widget.retainId,
                  controller: widget.controller,
                  payingScheme: payingScheme,
                );
              });
        }
      },
    );
  }
}

class DialogWidget extends StatefulWidget {
  List<SchemePayingModel> payingScheme;
  TextEditingController controller;
  TextEditingController retainId;

  DialogWidget(
      {Key? key,
      required this.controller,
      required this.retainId,
      required this.payingScheme})
      : super(key: key);

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  List<SchemePayingModel> _foundPayingScheme = [];

  @override
  void initState() {
    _foundPayingScheme = widget.payingScheme;
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
                  LocaleKeys.label_select_doctor.tr(),
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
                          _foundPayingScheme[ind].name ?? '';
                      widget.retainId.text =
                          (_foundPayingScheme[ind].id ?? 0).toString();
                      Navigator.pop(context);
                    },
                    child: Text(_foundPayingScheme[ind].name ?? ''));
              },
              itemCount: _foundPayingScheme.length,
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
  }
}
