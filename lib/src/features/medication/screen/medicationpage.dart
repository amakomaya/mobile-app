import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/features/fetch%20user%20data/cubit/get_user_cubit.dart';
import 'package:aamako_maya/src/features/labtest/cubit/toggle_page_view_cubit.dart';
import 'package:aamako_maya/src/features/medication/cubit/medication_cubit.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/custom_render.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../injection_container.dart';
import '../../../../l10n/locale_keys.g.dart';
import '../../../core/connection_checker/network_connection.dart';
import '../../ancs/screens/ancs_page.dart';
import '../cubit/medication_info_cubit.dart';

class MedicationPage extends StatefulWidget {
  const MedicationPage({Key? key}) : super(key: key);

  @override
  State<MedicationPage> createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  var controller = PageController(initialPage: 0);

  @override
  void initState() {
    context.read<MedicationCubit>().getMedication(false);
    context
        .read<MedicationInfoCubit>()
        .getMedicationInfo(false);
    super.initState();
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    var shortDesc = "";
    var contentDesc = "";
    var title = "";
    return BlocBuilder<GetUserCubit, GetUserState>(
      builder: (userCtx, userState) {
        return (userState is GetUserSuccess &&
                (userState.user.tole?.isEmpty ?? true))
            ? Text(LocaleKeys.msg_please_complete_profile_first.tr())
            : BlocProvider(
                create: (context) => TogglePageViewCubit(),
                child: Builder(builder: (context) {
                  // context.read<TogglePageViewCubit>().togglePage(0);
                  return SizedBox(
                    height: size.height,
                    width: size.width,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        BlocConsumer<TogglePageViewCubit, int>(
                          listener:(context, state) {
                            if (controller.page==1) {
                              controller.previousPage(
                                  duration: const Duration(
                                      milliseconds: 600),
                                  curve: Curves.easeIn);
                            }
                          },
                          builder: (context, state) {
                            return PageView(
                              onPageChanged: (value) {
                                context
                                    .read<TogglePageViewCubit>()
                                    .togglePage(value);
                              },
                              controller: controller,
                              children: [
                                BlocBuilder<MedicationInfoCubit, MedicationInfoState>(
                                  builder: (context, st) {
                                    final bool isEnglish =
                                        EasyLocalization.of(context)?.currentLocale?.languageCode == 'en';
                                    if(st is MedicationInfoSuccessState){
                                      shortDesc = isEnglish ? st.data.shortDescEn : st.data.shortDescNp;
                                      contentDesc = isEnglish ? st.data.contentEn : st.data.contentNp;
                                      title = isEnglish ? st.data.titleEn : st.data.titleNp;
                                    }
                                    return (st is MedicationInfoSuccessState)
                                        ? RefreshIndicator(
                                      onRefresh: () async {
                                        if (await sl<NetworkInfo>()
                                            .isConnected) {
                                          context
                                              .read<MedicationInfoCubit>()
                                              .getMedicationInfo(true);
                                        } else {
                                          BotToast.showText(
                                              text: LocaleKeys
                                                  .no_internet_connection.tr());
                                        }
                                      },
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 50.h),
                                          child: Center(
                                            child :Column(
                                                  children: [
                                                    shadowContainerWithHtm(context,
                                                        shortDesc),
                                                    SizedBox(
                                                        height: 24.h),
                                                    shadowContainerWithHtm(
                                                        context,
                                                        contentDesc,
                                                        title: title,
                                                        theme: theme),
                                                  ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                        : ShimmerLoading(
                                        boxHeight: 330.h, itemCount: 4);
                                    ;
                                  },
                                ),
                                BlocBuilder<MedicationCubit, MedicationState>(
                                  builder: (context, state) {
                                    if (state is MedicationSuccess) {
                                      return RefreshIndicator(
                                        onRefresh: () async {
                                          if (await sl<NetworkInfo>()
                                              .isConnected) {
                                            context
                                                .read<MedicationCubit>()
                                                .getMedication(true);
                                          } else {
                                            BotToast.showText(
                                                text: LocaleKeys
                                                    .no_internet_connection.tr());
                                          }
                                        },
                                        child: ListView.separated(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 50.h),
                                            itemBuilder: ((context, index) {
                                              final list = state
                                                  .data.data[index].reportData;

                                              return (state.data.data.isEmpty)
                                                  ? Center(
                                                      child: Padding(
                                                        padding:
                                                            REdgeInsets.only(
                                                                top: 30.h),
                                                        child: Text(
                                                            'No Records Found!',
                                                            style: theme
                                                                .textTheme
                                                                .bodySmall
                                                                ?.copyWith(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        15.sm)),
                                                      ),
                                                    )
                                                  : Column(
                                                      children: [
                                                        Text(
                                                            "${LocaleKeys.medication.tr() } ${LocaleKeys.label_report.tr() } ${index + 1}"
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "lato",
                                                                color: AppColors
                                                                    .primaryRed,
                                                                fontSize:
                                                                    17.sm)),
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                        ShadowContainer(
                                                          radius: 20.r,
                                                          width: 380.w,
                                                          color: Colors.white,
                                                          padding:
                                                              defaultPadding
                                                                  .copyWith(
                                                                      top: 10.h,
                                                                      bottom:
                                                                          20.h),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              for (var item
                                                                  in list)
                                                                ListTile(
                                                                  title: Text(
                                                                      item
                                                                          .label,
                                                                      style: theme
                                                                          .textTheme
                                                                          .labelSmall),
                                                                  trailing: Text(
                                                                      item
                                                                          .value,
                                                                      style: theme
                                                                          .textTheme
                                                                          .labelSmall),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                            }),
                                            separatorBuilder: (ctx, index) {
                                              return Divider(
                                                color: AppColors.white,
                                              );
                                            },
                                            itemCount: state.data.data.length),
                                      );
                                    } else {
                                      return ShimmerLoading(
                                          boxHeight: 400, itemCount: 4);
                                    }
                                  },
                                )
                              ],
                            );
                          },
                        ),
                        Positioned(
                            left: 100.w,
                            right: 100.w,
                            top: -20,
                            child: BlocBuilder<TogglePageViewCubit, int>(
                              builder: (context, state) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(30.r),
                                  child: ShadowContainer(
                                    shadowColor: Colors.black,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: TextButton(
                                              onPressed: () {
                                                context
                                                    .read<TogglePageViewCubit>()
                                                    .togglePage(0);
                                                if (state == 1) {
                                                  controller.previousPage(
                                                      duration: const Duration(
                                                          milliseconds: 600),
                                                      curve: Curves.easeIn);
                                                }
                                              },
                                              child: Text(LocaleKeys.label_info.tr().toUpperCase(),
                                                style: theme
                                                    .textTheme.labelSmall
                                                    ?.copyWith(
                                                    fontSize: 16.sm,
                                                        color: state == 0
                                                            ? AppColors
                                                                .primaryRed
                                                            : Colors.black),
                                              )),
                                        ),
                                        Expanded(
                                          child: TextButton(
                                              onPressed: () {
                                                context
                                                    .read<TogglePageViewCubit>()
                                                    .togglePage(1);
                                                if (state == 0) {
                                                  controller.nextPage(
                                                      duration: const Duration(
                                                          milliseconds: 600),
                                                      curve: Curves.easeIn);
                                                }
                                              },
                                              child: Text(
                                                LocaleKeys.label_report.tr()
                                                    .toUpperCase(),
                                                style: theme
                                                    .textTheme.labelSmall
                                                    ?.copyWith(
                                                    fontSize: 16.sm,
                                                        color: state == 1
                                                            ? AppColors
                                                                .primaryRed
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
      },
    );
  }
}
