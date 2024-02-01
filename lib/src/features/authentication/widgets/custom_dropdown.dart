import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/locale_keys.g.dart';

List<String> bloodGroups = ["A +ve", "A -ve", "B +ve", "B -ve", "O +ve", "O -ve", "AB +ve", "AB -ve"];
List<String> gender = ["Male", "Female", "Others"];

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    Key? key,
    required this.controller,
    this.isEditable = false,
    this.isFromGender = false,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final List<String> items;
  final bool isEditable;
  final bool? isFromGender;
  final Function(String? v)? onChanged;

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(1, 1), blurRadius: 2)
          ]),
      child: DropdownButtonFormField(
          hint: Text( isFromGender==true ?  LocaleKeys.msg_select_gender.tr() :
            LocaleKeys.label_select_blood_group.tr(),

            style: TextStyle(color: Colors.grey),
          ),
          icon: Visibility(
              visible: isEditable ? true : false,
              child: Icon(Icons.arrow_drop_down_outlined)),
          value: controller.text.isNotEmpty ? controller.text : null,
          decoration: InputDecoration(
              contentPadding: REdgeInsets.symmetric(horizontal: 16),
              border: InputBorder.none),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: isEditable ? onChanged : null),
    );
    // return PrimaryTextField(
    //   isEditable: isEditable,
    //   controller: controller,
    //   onTap: () {},
    // );
  }
}
