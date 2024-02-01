import 'package:Amakomaya/src/core/theme/app_colors.dart';
import 'package:Amakomaya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:Amakomaya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:Amakomaya/src/features/symptoms/cubit/symptoms_cubit.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../injection_container.dart';
import '../../../../l10n/locale_keys.g.dart';
import '../../../core/connection_checker/network_connection.dart';
import '../../../core/padding/padding.dart';
import '../../../core/widgets/helper_widgets/shadow_container.dart';
import '../cubit/symptoms_page_change.dart';
import 'assessment_widget.dart';

class SymptomsPAge extends StatefulWidget {
  const SymptomsPAge({Key? key}) : super(key: key);

  @override
  State<SymptomsPAge> createState() => _SymptomsPAgeState();
}

class _SymptomsPAgeState extends State<SymptomsPAge> {
  PageController controller = PageController();

  @override
  void initState() {
    context.read<SymptomsCubit>().getSymptoms(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => SymptomsPagChangeCubit(),
      child: Builder(builder: (context) {
        return SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              PageView(
                controller: controller,
                onPageChanged: (value) {
                  context.read<SymptomsPagChangeCubit>().togglePage(value);
                  if(value == 1){
                    context.read<SymptomsCubit>().getSymptoms(false);
                  }
                },
                children: [
                  AssessmentWidget(),
                  BlocBuilder<SymptomsCubit, SymptomsState>(
                    builder: (context, state) {
                      if (state is SymptomsSuccess) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            if (await sl<NetworkInfo>().isConnected) {
                              context.read<SymptomsCubit>().getSymptoms(true);
                            } else {
                              BotToast.showText(
                                  text: LocaleKeys.no_internet_connection.tr());
                            }
                          },
                          child: ListView.separated(
                              padding: defaultPadding.copyWith(
                                  top: 27.h, bottom: 27.h),
                              itemBuilder: ((context, index) {
                                return Column(
                                  children: [
                                    Text(
                                        " ${LocaleKeys.label_report.tr()}${index + 1}"
                                            .toUpperCase(),
                                        style: theme.textTheme.labelMedium
                                            ?.copyWith(
                                                color: AppColors.primaryRed)),
                                    VerticalSpace(10.h),
                                    state.symptoms[index].healthCondition == 3
                                        ? ShadowContainer(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ListTile(
                                                  trailing: Text(
                                                    LocaleKeys
                                                        .label_postnatal
                                                        .tr(),
                                                  ),
                                                  leading: Text(
                                                      "Health Condition",
                                                      style: theme.textTheme
                                                          .labelSmall),
                                                ),
                                                ListTile(
                                                  trailing: Text(
                                                    getYesNoValue(state
                                                        .symptoms[index]
                                                        .headache),
                                                  ),
                                                  leading: Text(
                                                      LocaleKeys.label_headache
                                                          .tr(),
                                                      style: theme.textTheme
                                                          .labelSmall),
                                                ),
                                                ListTile(
                                                  trailing: Text(
                                                    getYesNoValue(state
                                                        .symptoms[index]
                                                        .vaginaBleed),
                                                  ),
                                                  leading: Text(
                                                      LocaleKeys.label_bleeding
                                                          .tr(),
                                                      style: theme.textTheme
                                                          .labelSmall),
                                                ),
                                                ListTile(
                                                  trailing: Text(
                                                    getYesNoValue(state
                                                        .symptoms[index]
                                                        .trembleOrFaint),
                                                  ),
                                                  leading: Text(
                                                      LocaleKeys.label_faint
                                                          .tr(),
                                                      style: theme.textTheme
                                                          .labelSmall),
                                                ),
                                                ListTile(
                                                  trailing: Text(
                                                    getYesNoValue(state
                                                        .symptoms[index].fever),
                                                  ),
                                                  leading: Text(
                                                      LocaleKeys.label_fever
                                                          .tr(),
                                                      style: theme.textTheme
                                                          .labelSmall),
                                                ),
                                                ListTile(
                                                  trailing: Text(
                                                    getYesNoValue(state
                                                        .symptoms[index]
                                                        .lowerAbdominalPain),
                                                  ),
                                                  leading: Text(
                                                      LocaleKeys
                                                          .label_abdominal_pain
                                                          .tr(),
                                                      style: theme.textTheme
                                                          .labelSmall),
                                                ),
                                                ListTile(
                                                  trailing: Text(
                                                    getYesNoValue(state
                                                        .symptoms[index]
                                                        .feverDegree),
                                                  ),
                                                  leading: Text(
                                                      LocaleKeys
                                                          .label_fever_degrees
                                                          .tr(),
                                                      style: theme.textTheme
                                                          .labelSmall),
                                                ),
                                                ListTile(
                                                  trailing: Text(
                                                    getYesNoValue(state
                                                        .symptoms[index]
                                                        .difficultBreathe),
                                                  ),
                                                  leading: Text(
                                                      LocaleKeys.label_breathing
                                                          .tr(),
                                                      style: theme.textTheme
                                                          .labelSmall),
                                                ),
                                                ListTile(
                                                  trailing: Text(
                                                    getYesNoValue(state
                                                        .symptoms[index]
                                                        .coughAndCold),
                                                  ),
                                                  leading: Text(
                                                      LocaleKeys
                                                          .label_cough_cold
                                                          .tr(),
                                                      style: theme.textTheme
                                                          .labelSmall),
                                                ),
                                                Padding(
                                                  padding: defaultPadding
                                                      .copyWith(bottom: 5),
                                                  child: Text(
                                                    LocaleKeys
                                                        .label_other_problems
                                                        .tr(),
                                                    style: theme
                                                        .textTheme.labelSmall
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: defaultPadding
                                                      .copyWith(bottom: 10),
                                                  child: Text(
                                                    state.symptoms[index]
                                                            .otherProblems ??
                                                        " N/A",
                                                    style: theme
                                                        .textTheme.labelSmall
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      defaultPadding.copyWith(
                                                    bottom: 10,
                                                  ),
                                                  child: RichText(
                                                      text: TextSpan(
                                                          text: "${LocaleKeys
                                                              .label_comments
                                                              .tr()} :",
                                                          style: theme.textTheme
                                                              .labelSmall
                                                              ?.copyWith(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                          children: [
                                                        TextSpan(
                                                          text: state
                                                                  .symptoms[
                                                                      index]
                                                                  .comments ??
                                                              ' N/A',
                                                          style: theme.textTheme
                                                              .labelSmall
                                                              ?.copyWith(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        )
                                                      ])),
                                                )
                                              ],
                                            ),
                                          )
                                        : state.symptoms[index]
                                                    .healthCondition ==
                                                1
                                            ? ShadowContainer(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ListTile(
                                                      trailing: Text(
                                                          LocaleKeys
                                                              .label_pregnancy
                                                              .tr()
                                                      ),
                                                      leading: Text(
                                                          "Health Condition",
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    ListTile(
                                                      trailing: Text(
                                                        getYesNoValue(state
                                                            .symptoms[index]
                                                            .headache),
                                                      ),
                                                      leading: Text(
                                                          LocaleKeys
                                                              .label_headache
                                                              .tr(),
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    ListTile(
                                                      trailing: Text(
                                                        getYesNoValue(state
                                                            .symptoms[index]
                                                            .vaginaBleed),
                                                      ),
                                                      leading: Text(
                                                          LocaleKeys
                                                              .label_bleeding
                                                              .tr(),
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    ListTile(
                                                      trailing: Text(
                                                        getYesNoValue(state
                                                            .symptoms[index]
                                                            .trembleOrFaint),
                                                      ),
                                                      leading: Text(
                                                          LocaleKeys.label_faint
                                                              .tr(),
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    ListTile(
                                                      trailing: Text(
                                                        getYesNoValue(state
                                                            .symptoms[index]
                                                            .eyesBlur),
                                                      ),
                                                      leading: Text(
                                                          LocaleKeys.label_eyes_blurred
                                                              .tr(),
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    ListTile(
                                                      trailing: Text(
                                                        getYesNoValue(state
                                                            .symptoms[index]
                                                            .abdominalPain),
                                                      ),
                                                      leading: Text(
                                                          LocaleKeys
                                                              .label_month_of_pregnancy
                                                              .tr(),
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    ListTile(
                                                      trailing: Text(
                                                        getYesNoValue(state
                                                            .symptoms[index]
                                                            .feverDegree),
                                                      ),
                                                      leading: Text(
                                                          LocaleKeys
                                                              .label_fever_degrees
                                                              .tr(),
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    ListTile(
                                                      trailing: Text(
                                                        getYesNoValue(state
                                                            .symptoms[index]
                                                            .difficultBreathe),
                                                      ),
                                                      leading: Text(
                                                          LocaleKeys
                                                              .label_breathing
                                                              .tr(),
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    ListTile(
                                                      trailing: Text(
                                                        getYesNoValue(state
                                                            .symptoms[index]
                                                            .coughAndCold),
                                                      ),
                                                      leading: Text(
                                                          LocaleKeys
                                                              .label_cough_cold
                                                              .tr(),
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    Padding(
                                                      padding: defaultPadding
                                                          .copyWith(bottom: 5),
                                                      child: Text(
                                                        LocaleKeys
                                                            .label_other_problems
                                                            .tr(),
                                                        style: theme.textTheme
                                                            .labelSmall
                                                            ?.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: defaultPadding
                                                          .copyWith(bottom: 10),
                                                      child: Text(
                                                        state.symptoms[index]
                                                                .otherProblems ??
                                                            " N/A",
                                                        style: theme.textTheme
                                                            .labelSmall
                                                            ?.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: defaultPadding
                                                          .copyWith(
                                                        bottom: 10,
                                                      ),
                                                      child: RichText(
                                                          text: TextSpan(
                                                              text: "${LocaleKeys
                                                                  .label_comments
                                                                  .tr()} :",
                                                              style: theme
                                                                  .textTheme
                                                                  .labelSmall
                                                                  ?.copyWith(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                              children: [
                                                            TextSpan(
                                                              text: state
                                                                      .symptoms[
                                                                          index]
                                                                      .comments ??
                                                                  ' N/A',
                                                              style: theme
                                                                  .textTheme
                                                                  .labelSmall
                                                                  ?.copyWith(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                            )
                                                          ])),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : ShadowContainer(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ListTile(
                                                      trailing: Text(
                                                        LocaleKeys
                                                            .label_delivery_labor
                                                                    .tr()
                                                        ,
                                                      ),
                                                      leading: Text(
                                                          "Health Condition",
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    ListTile(
                                                      trailing: Text(
                                                        getYesNoValue(state
                                                            .symptoms[index]
                                                            .laborPain),
                                                      ),
                                                      leading: Text(
                                                          LocaleKeys
                                                              .label_labor_pain
                                                              .tr(),
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    ListTile(
                                                      trailing: Text(
                                                        getYesNoValue(state
                                                            .symptoms[index]
                                                            .cordProtrusion),
                                                      ),
                                                      leading: Text(
                                                          LocaleKeys
                                                              .label_cord_protrusion
                                                              .tr(),
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    ListTile(
                                                      trailing: Text(
                                                        getYesNoValue(state
                                                            .symptoms[index]
                                                            .trembleOrFaint),
                                                      ),
                                                      leading: Text(
                                                          LocaleKeys.label_faint
                                                              .tr(),
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    ListTile(
                                                      trailing: Text(
                                                        getYesNoValue(state
                                                            .symptoms[index]
                                                            .excessiveBleedingBirth),
                                                      ),
                                                      leading: Text(
                                                          LocaleKeys.label_baby_born
                                                              .tr(),
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    ListTile(
                                                      trailing: Text(
                                                        getYesNoValue(state
                                                            .symptoms[index]
                                                            .difficultBreathe),
                                                      ),
                                                      leading: Text(
                                                          LocaleKeys
                                                              .label_breathing
                                                              .tr(),
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    ListTile(
                                                      trailing: Text(
                                                        getYesNoValue(state
                                                            .symptoms[index]
                                                            .coughAndCold),
                                                      ),
                                                      leading: Text(
                                                          LocaleKeys
                                                              .label_cough_cold
                                                              .tr(),
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    Padding(
                                                      padding: defaultPadding
                                                          .copyWith(bottom: 5),
                                                      child: Text(
                                                        LocaleKeys
                                                            .label_other_problems
                                                            .tr(),
                                                        style: theme.textTheme
                                                            .labelSmall
                                                            ?.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: defaultPadding
                                                          .copyWith(bottom: 10),
                                                      child: Text(
                                                        state.symptoms[index]
                                                                .otherProblems ??
                                                            " N/A",
                                                        style: theme.textTheme
                                                            .labelSmall
                                                            ?.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: defaultPadding
                                                          .copyWith(
                                                        bottom: 10,
                                                      ),
                                                      child: RichText(
                                                          text: TextSpan(
                                                              text: "${LocaleKeys
                                                                  .label_comments
                                                                  .tr()} :",
                                                              style: theme
                                                                  .textTheme
                                                                  .labelSmall
                                                                  ?.copyWith(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                              children: [
                                                            TextSpan(
                                                              text: state
                                                                      .symptoms[
                                                                          index]
                                                                      .comments ??
                                                                  ' N/A',
                                                              style: theme
                                                                  .textTheme
                                                                  .labelSmall
                                                                  ?.copyWith(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                            )
                                                          ])),
                                                    )
                                                  ],
                                                ),
                                              )
                                  ],
                                );
                              }),
                              separatorBuilder: (ctx, index) {
                                return VerticalSpace(10.h);
                              },
                              itemCount: state.symptoms.length),
                        );
                      } else {
                        return ShimmerLoading(boxHeight: 500.h, itemCount: 2);
                      }
                    },
                  )
                ],
              ),
              Positioned(
                  left: 100.w,
                  right: 100.w,
                  top: -20,
                  child: BlocBuilder<SymptomsPagChangeCubit, int>(
                    builder: (context, state) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: ShadowContainer(
                          shadowColor: Colors.black,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextButton(
                                    onPressed: () {
                                      context
                                          .read<SymptomsPagChangeCubit>()
                                          .togglePage(0);
                                      if (state == 1) {
                                        controller.previousPage(
                                            duration: const Duration(
                                                milliseconds: 600),
                                            curve: Curves.easeIn);
                                      }
                                    },
                                    child: Text(
                                      LocaleKeys.label_assessment
                                          .tr()
                                          .toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(fontSize: 14.sm, color:state == 0
                                          ? AppColors.primaryRed
                                          : Colors.black),
                                    )),
                              ),
                              Expanded(
                                child: TextButton(
                                    onPressed: () {
                                      context
                                          .read<SymptomsPagChangeCubit>()
                                          .togglePage(1);
                                      if (state == 0) {
                                        controller.nextPage(
                                            duration: const Duration(
                                                milliseconds: 600),
                                            curve: Curves.easeIn);
                                      }
                                      context.read<SymptomsCubit>().getSymptoms(false);
                                    },
                                    child: Text(
                                      LocaleKeys.label_history
                                          .tr()
                                          .toUpperCase(),
                                      style:Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(fontSize: 14.sm, color:state == 1
                                          ? AppColors.primaryRed
                                          : Colors.black),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
            ],
          ),
        );
      }),
    );
  }

  String getYesNoValue(int? value) {
    if (value == 0) {
      return LocaleKeys.label_no.tr();
    } else {
      return LocaleKeys.label_yes.tr();
    }
  }
}
