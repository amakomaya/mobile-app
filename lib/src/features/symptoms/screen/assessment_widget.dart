import 'dart:async';
import 'dart:math';

import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/buttons/primary_action_button.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/features/symptoms/cubit/symptoms_cubit.dart';
import 'package:aamako_maya/src/features/symptoms/model/assessment_model.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../injection_container.dart';
import '../../../../l10n/locale_keys.g.dart';
import '../../../core/connection_checker/network_connection.dart';
import '../model/data.dart';

class AssessmentWidget extends StatefulWidget {
  static void restartApp(BuildContext context) {}

  @override
  State<AssessmentWidget> createState() => _AssessmentWidgetState();
}

class _AssessmentWidgetState extends State<AssessmentWidget> {
  String? _dropdownValue;
  List<DeliveryModel> complications = [];
  final other_symptoms = TextEditingController();
  var loading = false;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    clearAll();
    _dropdownValue = "Pregnancy";
    super.initState();
  }

  void clearAll() async {
    complications = [];

    complications = _dropdownValue == 'Postnatal'
        ? postnatal
        : _dropdownValue == 'Delivery'
            ? delivery
            : pregnancy;

    complications.forEach((e) => {e.isSelected = false, e.selected = false});

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isEnglish =
        EasyLocalization.of(context)?.currentLocale?.languageCode == 'en';
    return SingleChildScrollView(
        controller: scrollController,
        padding: EdgeInsets.symmetric(vertical: 27.h),
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
                  hint: Text(LocaleKeys.label_choose_heath_condition.tr(),
                      style: theme.textTheme.displaySmall?.copyWith(
                          color: AppColors.accentGrey, fontSize: 16.sm)),
                  isExpanded: true,
                  value: _dropdownValue,
                  items: [
                    DropdownMenuItem(
                      child: Text(LocaleKeys.label_pregnancy.tr(),
                          style: theme.textTheme.displaySmall?.copyWith(
                              color: AppColors.accentGrey, fontSize: 16.sm)),
                      value: 'Pregnancy',
                    ),
                    DropdownMenuItem(
                      child: Text(LocaleKeys.label_delivery_labor.tr(),
                          style: theme.textTheme.displaySmall?.copyWith(
                              color: AppColors.accentGrey, fontSize: 16.sm)),
                      value: 'Delivery',
                    ),
                    DropdownMenuItem(
                      child: Text(LocaleKeys.label_postnatal.tr(),
                          style: theme.textTheme.displaySmall?.copyWith(
                              color: AppColors.accentGrey, fontSize: 16.sm)),
                      value: 'Postnatal',
                    ),
                  ],
                  onChanged: (String? value) async {
                    _dropdownValue = value!;

                    clearAll();
                    other_symptoms.text = "";
                  }),
            ),
            VerticalSpace(30.h),
            if (_dropdownValue != null) ...[
              Text(
                '$_dropdownValue ${LocaleKeys.label_danger_signs.tr()}',
                style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.primaryRed),
              ),
              VerticalSpace(30.h),
              if (loading)
                CircularProgressIndicator()
              else
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: defaultPadding,
                    itemCount: complications.length,
                    separatorBuilder: (ctx, ind) => VerticalSpace(20.h),
                    itemBuilder: (ctx, ind) {
                      DeliveryModel item = complications[ind];

                      return ShadowContainer(
                        radius: 30,
                        padding: defaultPadding.copyWith(
                            top: 0, right: 0, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Text(
                              isEnglish ? item.problem : item.problemNp,
                              style: theme.textTheme.displaySmall?.copyWith(
                                  color: AppColors.accentGrey, fontSize: 16.sm),
                            )),
                            Row(children: [
                              InkWell(
                                onTap: () {
                                  item.isSelected = true;
                                  item.selected = true;

                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 18),
                                  child: Row(
                                    children: [
                                      Text(LocaleKeys.label_yes.tr(),
                                          style: theme.textTheme.displaySmall
                                              ?.copyWith(
                                                  color: AppColors.accentGrey,
                                                  fontSize: 16.sm)),
                                      HorizSpace(5.w),
                                      item.isSelected && item.selected
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
                              ),
                              InkWell(
                                onTap: () {
                                  item.isSelected = false;
                                  item.selected = true;
                                  // !postnatalComplications[ind].isSelected;
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 18),
                                  child: Row(
                                    children: [
                                      Text(LocaleKeys.label_no.tr(),
                                          style: theme.textTheme.displaySmall
                                              ?.copyWith(
                                                  color: AppColors.accentGrey,
                                                  fontSize: 16.sm)),
                                      HorizSpace(5.w),
                                      !item.isSelected && item.selected
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
                            ])
                          ],
                        ),
                      );
                    }),
              VerticalSpace(30.h),
              ShadowContainer(
                radius: 30,
                width: 380.w,
                padding: defaultPadding,
                child: TextField(
                  controller: other_symptoms,
                  decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: LocaleKeys.label_write_symptoms.tr()),
                ),
              ),
              VerticalSpace(30.h),
              PrimaryActionButton(
                  width: 380.w,
                  onpress: () async {
                    if (await sl<NetworkInfo>().isConnected) {
                      var proceed = null;
                      try {
                        proceed = complications.firstWhere(
                            (e) => e.selected == false,
                            orElse: null);
                      } catch (e) {
                        proceed = null;
                      }
                      if (proceed == null) {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.remove("symptoms_history");
                        try {
                          BotToast.showLoading();
                          var resp = await context
                              .read<SymptomsCubit>()
                              .postSymptoms(complications, _dropdownValue,
                                  other_symptoms.text);
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(content: Text(resp.toString())));
                          BotToast.closeAllLoading();
                          BotToast.showText(text: resp.toString());
                          BotToast.showText(
                              text: "Successfully Updated");
                        } on ApiException catch (e) {
                          BotToast.closeAllLoading();
                          BotToast.showText(text: e.message.toString());
                        }
                        other_symptoms.text = "";
                        clearAll();
                        scrollController.jumpTo(scrollController
                            .position.minScrollExtent);
                        setState(() {});
                      } else {
                        BotToast.showText(
                            text: LocaleKeys.warning_msg_fill_all_field.tr());
                      }
                    } else {
                      BotToast.showText(
                          text: LocaleKeys.no_internet_connection.tr());
                    }
                  },
                  title: LocaleKeys.label_submit.tr()),
            ],
            VerticalSpace(40.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: Text(
                LocaleKeys.msg_problem_contact_call_number.tr(),
                style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400, color: AppColors.accentGrey),
              ),
            ),
            VerticalSpace(20.h)
          ],
        ));
  }
}
