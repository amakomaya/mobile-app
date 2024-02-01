import 'dart:convert';
import 'dart:math';

import 'package:Amakomaya/l10n/locale_keys.g.dart';
import 'package:Amakomaya/src/core/widgets/textfield/primary_textfield.dart';
import 'package:Amakomaya/src/features/appointment_booking/model/scheme_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/padding/padding.dart';
import '../../../core/widgets/helper_widgets/shadow_container.dart';

class SchemeGeneralDropDownListWidget extends StatefulWidget {
  final TextEditingController controller;
  final ValidatorFunc? validator;
  final bool isEditable;
  final TextEditingController retainId;

  const SchemeGeneralDropDownListWidget(
      {Key? key,
      required this.controller,
      required this.validator,
      required this.retainId,
      this.isEditable = false})
      : super(key: key);

  @override
  State<SchemeGeneralDropDownListWidget> createState() =>
      _SchemeGeneralDropDownListWidgetState();
}

class _SchemeGeneralDropDownListWidgetState
    extends State<SchemeGeneralDropDownListWidget> {
  List<SchemeGeneralModel> generalScheme = [];

  void getGeneralScheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = prefs.getString('general_scheme');
    print("aaaaaa sd $response");

    if (response != null) {
      final data = (jsonDecode(response) as List)
          .map((e) => SchemeGeneralModel.fromJson(e))
          .toList();
      generalScheme = data;
    }
    print("aaaaaa $generalScheme");
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
      labelText: "",
      hintText:LocaleKeys.label_select_general_service.tr(),
      suffix: Icons.arrow_drop_down,
      onTap: () async {
        if (generalScheme.isNotEmpty) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return DialogWidget(
                  retainId: widget.retainId,
                  controller: widget.controller,
                  generalScheme: generalScheme,
                );
              });
        }
      },
    );
  }
}

class DialogWidget extends StatefulWidget {
  List<SchemeGeneralModel> generalScheme;
  TextEditingController controller;
  TextEditingController retainId;

  DialogWidget(
      {Key? key,
      required this.controller,
      required this.retainId,
      required this.generalScheme})
      : super(key: key);

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  List<SchemeGeneralModel> _foundGeneralScheme = [];

  @override
  void initState() {
    _foundGeneralScheme = widget.generalScheme;
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
                  LocaleKeys.label_select_general_service.tr(),
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
                          _foundGeneralScheme[ind].title ?? '';
                      widget.retainId.text =
                          (_foundGeneralScheme[ind].id ?? 0).toString();
                      Navigator.pop(context);
                    },
                    child: Text(_foundGeneralScheme[ind].title ?? ''));
              },
              itemCount: _foundGeneralScheme.length,
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
