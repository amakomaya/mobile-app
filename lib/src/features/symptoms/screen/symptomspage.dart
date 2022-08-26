import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/features/symptoms/cubit/symptoms_cubit.dart';
import 'package:bot_toast/bot_toast.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../injection_container.dart';
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
                },
                children: [
                  AssessmentWidget(
                  controller: controller
                 ),
                  BlocBuilder<SymptomsCubit, SymptomsState>(
                    builder: (context, state) {
                      if (state is SymptomsSuccess) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            if (await sl<NetworkInfo>().isConnected) {
                              context.read<SymptomsCubit>().getSymptoms(true);
                            } else {
                              BotToast.showText(
                                  text: 'No Internet Connection !');
                            }
                          },
                          child: ListView.separated(
                              padding: defaultPadding.copyWith(
                                  top: 27.h, bottom: 27.h),
                              itemBuilder: ((context, index) {
                                return Column(
                                  children: [
                                    Text(" Report ${index + 1}".toUpperCase(),
                                        style: theme.textTheme.labelMedium
                                            ?.copyWith(
                                                color: AppColors.primaryRed)),
                                    VerticalSpace(10.h),
                                    ShadowContainer(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ListTile(
                                            trailing: Text(
                                              getYesNoValue(state
                                                  .symptoms[index].vaginaBleed),
                                            ),
                                            leading: Text(
                                                "Bleeding from the vagina",
                                                style:
                                                    theme.textTheme.labelSmall),
                                          ),
                                          ListTile(
                                            trailing: Text(
                                              getYesNoValue(state
                                                  .symptoms[index].headache),
                                            ),
                                            leading: Text(
                                                "Headache a little too much headache",
                                                style:
                                                    theme.textTheme.labelSmall),
                                          ),
                                          ListTile(
                                            trailing: Text(
                                              getYesNoValue(state
                                                  .symptoms[index]
                                                  .trembleOrFaint),
                                            ),
                                            leading: Text(
                                                "Hands and feet tremable or faint",
                                                style:
                                                    theme.textTheme.labelSmall),
                                          ),
                                          ListTile(
                                            trailing: Text(
                                              getYesNoValue(state
                                                  .symptoms[index].eyesBlur),
                                            ),
                                            leading: Text("Eyes blurred",
                                                style:
                                                    theme.textTheme.labelSmall),
                                          ),
                                          ListTile(
                                            trailing: Text(
                                              getYesNoValue(state
                                                  .symptoms[index]
                                                  .abdominalPain),
                                            ),
                                            leading: Text(
                                                "Abominal pain in the first month of pregnancy",
                                                style:
                                                    theme.textTheme.labelSmall),
                                          ),
                                          ListTile(
                                            trailing: Text(
                                              getYesNoValue(state
                                                  .symptoms[index]
                                                  .feverHundred),
                                            ),
                                            leading: Text(
                                                "Fever above 100.4 degree",
                                                style:
                                                    theme.textTheme.labelSmall),
                                          ),
                                          ListTile(
                                            trailing: Text(
                                              getYesNoValue(state
                                                  .symptoms[index]
                                                  .difficultBreathe),
                                            ),
                                            leading: Text(
                                                "Difficulty in breathing",
                                                style:
                                                    theme.textTheme.labelSmall),
                                          ),
                                          ListTile(
                                            trailing: Text(
                                              getYesNoValue(state
                                                  .symptoms[index]
                                                  .coughAndCold),
                                            ),
                                            leading: Text("Cough and cold",
                                                style:
                                                    theme.textTheme.labelSmall),
                                          ),
                                          Padding(
                                            padding: defaultPadding.copyWith(
                                                bottom: 5),
                                            child: Text(
                                              'Other Problems:',
                                              style: theme.textTheme.labelSmall
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                          ),
                                          Padding(
                                            padding: defaultPadding.copyWith(
                                                bottom: 10),
                                            child: Text(
                                              state.symptoms[index]
                                                      .otherProblems ??
                                                  "",
                                              style: theme.textTheme.labelSmall
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                          ),
                                          Padding(
                                            padding: defaultPadding.copyWith(
                                              bottom: 10,
                                            ),
                                            child: RichText(
                                                text: TextSpan(
                                                    text: 'Comments: ',
                                                    style: theme
                                                        .textTheme.labelSmall
                                                        ?.copyWith(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                    children: [
                                                  TextSpan(
                                                    text: state.symptoms[index]
                                                            .comments ??
                                                        '',
                                                    style: theme
                                                        .textTheme.labelSmall
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
                                      'Assessment'.toUpperCase(),
                                      style: theme.textTheme.labelSmall
                                          ?.copyWith(
                                              color: state == 0
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
                                    },
                                    child: Text(
                                      'History'.toUpperCase(),
                                      style: theme.textTheme.labelSmall
                                          ?.copyWith(
                                              color: state == 1
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
      return "No";
    } else {
      return "Yes";
    }
  }
}
