import 'dart:async';
import 'dart:math';

import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/buttons/primary_action_button.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/features/symptoms/model/assessment_model.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssessmentWidget extends StatefulWidget {
  PageController controller;
  AssessmentWidget({Key? key, required this.controller}) : super(key: key);

  static void restartApp(BuildContext context) {}

  @override
  State<AssessmentWidget> createState() => _AssessmentWidgetState();
}

class _AssessmentWidgetState extends State<AssessmentWidget> {
  String? _dropdownValue;

  List<PostnatalModel> postnatalComplications = [
    PostnatalModel(
        id: 1, isSelected: false, problem: 'Having a little too much headache'),
    PostnatalModel(id: 2, isSelected: false, problem: 'Bleeding from vagina'),
    PostnatalModel(
        id: 3, isSelected: false, problem: 'Hands and feet tremble or faint'),
    PostnatalModel(id: 4, isSelected: false, problem: 'Fever'),
    PostnatalModel(
        id: 5,
        isSelected: false,
        problem: 'Smelling water from vagina or lower abdominal pain'),
    PostnatalModel(
        id: 6, isSelected: false, problem: 'Fever above 100.4 degrees'),
    PostnatalModel(
        id: 7, isSelected: false, problem: 'Difficulty in breathing'),
    PostnatalModel(id: 8, isSelected: false, problem: 'Cough and cold'),
  ];

  List<PregnancyModel> pregnancyComplications = [
    PregnancyModel(
        id: 1, isSelected: false, problem: 'Having a little too much headache'),
    PregnancyModel(id: 2, isSelected: false, problem: 'Bleeding from vagina'),
    PregnancyModel(
        id: 3, isSelected: false, problem: 'Hands and feet tremble or faint'),
    PregnancyModel(id: 4, isSelected: false, problem: 'Eyes blurred'),
    PregnancyModel(
        id: 5,
        isSelected: false,
        problem: 'Abdominal pain in the first month of pregnancy'),
    PregnancyModel(
        id: 6, isSelected: false, problem: 'Fever above 100.4 degrees'),
    PregnancyModel(
        id: 7, isSelected: false, problem: 'Difficulty in breathing'),
    PregnancyModel(id: 8, isSelected: false, problem: 'Cough and cold'),
  ];

  List<DeliveryModel> deliveryComplications = [
    DeliveryModel(
        id: 1, isSelected: false, problem: 'Labor pain for more than 8 hours'),
    DeliveryModel(
        id: 2,
        isSelected: false,
        problem: 'First hand,leg or umbilical cord protrusion'),
    DeliveryModel(
        id: 3, isSelected: false, problem: 'Hands and feet tremble or faint'),
    DeliveryModel(
        id: 4,
        isSelected: false,
        problem: 'A lot of bleeding before or after the baby was born'),
    DeliveryModel(id: 5, isSelected: false, problem: 'Difficulty in breathing'),
    DeliveryModel(id: 6, isSelected: false, problem: 'Cough and cold'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 27.h),
        primary: true,
        child: Column(
          children: [
            VerticalSpace(20.h),
            ShadowContainer(
              radius: 30,
              margin: defaultPadding,
              padding: defaultPadding,
              child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    border: InputBorder.none,
                  ),
                  hint: Text('Choose your health condition',
                      style: theme.textTheme.displaySmall?.copyWith(
                          color: AppColors.accentGrey, fontSize: 16.sm)),
                  isExpanded: true,
                  value: _dropdownValue,
                  items: [
                    DropdownMenuItem(
                      child: Text('Pregnancy',
                          style: theme.textTheme.displaySmall?.copyWith(
                              color: AppColors.accentGrey, fontSize: 16.sm)),
                      value: 'Pregnancy',
                    ),
                    DropdownMenuItem(
                      child: Text('Delivery/Labor',
                          style: theme.textTheme.displaySmall?.copyWith(
                              color: AppColors.accentGrey, fontSize: 16.sm)),
                      value: 'Delivery',
                    ),
                    DropdownMenuItem(
                      child: Text('Postnatal',
                          style: theme.textTheme.displaySmall?.copyWith(
                              color: AppColors.accentGrey, fontSize: 16.sm)),
                      value: 'Postnatal',
                    ),
                  ],
                  onChanged: (String? value) {
                    setState(() {
                      _dropdownValue = value!;
                    });
                  }),
            ),
            VerticalSpace(30.h),
            Text(
              'Danger Signs during Pregnancy',
              style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.primaryRed),
            ),
            VerticalSpace(30.h),
            Builder(builder: (context) {
              if (_dropdownValue == 'Postnatal') {
                return ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    padding: defaultPadding,
                    itemCount: postnatalComplications.length,
                    separatorBuilder: (ctx, ind) => VerticalSpace(20.h),
                    itemBuilder: (ctx, ind) {
                      return ShadowContainer(
                        radius: 30,
                        padding: defaultPadding.copyWith(
                            top: 0, right: 0, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Text(
                              postnatalComplications[ind].problem,
                              style: theme.textTheme.displaySmall?.copyWith(
                                  color: AppColors.accentGrey, fontSize: 16.sm),
                            )),
                            InkWell(
                              onTap: () {
                                postnatalComplications[ind].isSelected =
                                    !postnatalComplications[ind].isSelected;
                                setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 18),
                                child: Row(
                                  children: [
                                    Text('Yes',
                                        style: theme.textTheme.displaySmall
                                            ?.copyWith(
                                                color: AppColors.accentGrey,
                                                fontSize: 16.sm)),
                                    HorizSpace(5.w),
                                    postnatalComplications[ind].isSelected
                                        ? Icon(
                                            Icons.radio_button_checked,
                                            color: AppColors.primaryRed
                                                .withOpacity(0.7),
                                          )
                                        : const Icon(
                                            Icons.radio_button_off,
                                            color: Colors.grey,
                                          ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    });
              } else if (_dropdownValue == 'Delivery') {
                return ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    padding: defaultPadding,
                    itemCount: deliveryComplications.length,
                    separatorBuilder: (ctx, ind) => VerticalSpace(20.h),
                    itemBuilder: (ctx, ind) {
                      return ShadowContainer(
                        radius: 30,
                        padding: defaultPadding.copyWith(
                            top: 0, right: 0, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Text(
                              pregnancyComplications[ind].problem,
                              style: theme.textTheme.displaySmall?.copyWith(
                                  color: AppColors.accentGrey, fontSize: 16.sm),
                            )),
                            InkWell(
                              onTap: () {
                                deliveryComplications[ind].isSelected =
                                    !deliveryComplications[ind].isSelected;
                                setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 18),
                                child: Row(
                                  children: [
                                    Text('Yes',
                                        style: theme.textTheme.displaySmall
                                            ?.copyWith(
                                                color: AppColors.accentGrey,
                                                fontSize: 16.sm)),
                                    HorizSpace(5.w),
                                    deliveryComplications[ind].isSelected
                                        ? Icon(
                                            Icons.radio_button_checked,
                                            color: AppColors.primaryRed
                                                .withOpacity(0.7),
                                          )
                                        : const Icon(
                                            Icons.radio_button_off,
                                            color: Colors.grey,
                                          ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    });
              } else {
                return ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    padding: defaultPadding,
                    itemCount: pregnancyComplications.length,
                    separatorBuilder: (ctx, ind) => VerticalSpace(20.h),
                    itemBuilder: (ctx, ind) {
                      return ShadowContainer(
                        radius: 30,
                        padding: defaultPadding.copyWith(
                            top: 0, right: 0, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Text(
                              pregnancyComplications[ind].problem,
                              style: theme.textTheme.displaySmall?.copyWith(
                                  color: AppColors.accentGrey, fontSize: 16.sm),
                            )),
                            InkWell(
                              onTap: () {
                                pregnancyComplications[ind].isSelected =
                                    !pregnancyComplications[ind].isSelected;
                                setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 18),
                                child: Row(
                                  children: [
                                    Text('Yes',
                                        style: theme.textTheme.displaySmall
                                            ?.copyWith(
                                                color: AppColors.accentGrey,
                                                fontSize: 16.sm)),
                                    HorizSpace(5.w),
                                    pregnancyComplications[ind].isSelected
                                        ? Icon(
                                            Icons.radio_button_checked,
                                            color: AppColors.primaryRed
                                                .withOpacity(0.7),
                                          )
                                        : const Icon(
                                            Icons.radio_button_off,
                                            color: Colors.grey,
                                          ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    });
              }
            }),
            VerticalSpace(30.h),
            ShadowContainer(
              radius: 30,
              width: 380.w,
              padding: defaultPadding,
              child: const TextField(
                decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Write here if you have other symptoms'),
              ),
            ),
            VerticalSpace(30.h),
            PrimaryActionButton(
                width: 380.w,
                onpress: () {
                  for (var element in pregnancyComplications) {
                    element.isSelected = false;
                  }
                  setState(() {});
                  // widget.controller.nextPage(duration: Duration(seconds: 1), curve: Curves.bounceIn);
                  // widget.controller.jumpToPage(1);
                },
                title: 'Submit'),
            VerticalSpace(40.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: Text(
                'If there is any problem with you that requires an attention, feel free to call us at 9870568956',
                style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400, color: AppColors.accentGrey),
              ),
            ),
            VerticalSpace(20.h)
          ],
        ));
  }
}
