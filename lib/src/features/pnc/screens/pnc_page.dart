import 'package:Amakomaya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:Amakomaya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:Amakomaya/src/features/fetch%20user%20data/cubit/get_user_cubit.dart';
import 'package:Amakomaya/src/features/labtest/cubit/toggle_page_view_cubit.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../injection_container.dart';
import '../../../../l10n/locale_keys.g.dart';
import '../../../core/connection_checker/network_connection.dart';
import '../../../core/padding/padding.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/helper_widgets/shadow_container.dart';
import '../../ancs/screens/ancs_page.dart';
import '../cubit/pnc_cubit.dart';
import '../cubit/pnc_info_cubit.dart';

class PncsPage extends StatefulWidget {
  const PncsPage({Key? key}) : super(key: key);

  @override
  State<PncsPage> createState() => _PncsPageState();
}

class _PncsPageState extends State<PncsPage> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  PageController controller = PageController();

  @override
  void initState() {
    context.read<PncsCubit>().getPncs(false);
    context
        .read<PncsInfoCubit>()
        .getPncsInfo(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    var shortDesc = "";
    var contentDesc = "";
    var title = "";
    return BlocBuilder<GetUserCubit, GetUserState>(
      builder: (userCtx, userState) {
        return (userState is GetUserSuccess &&
                (userState.user.tole?.isEmpty ?? true))
            ? Text(LocaleKeys.msg_please_complete_profile_first.tr(),textAlign: TextAlign.center,)
            : BlocProvider(
                create: (context) => TogglePageViewCubit(),
                child: Builder(builder: (context) {
                  context.read<TogglePageViewCubit>().togglePage(0);
                  return SizedBox(
                    height: size.height,
                    width: size.width,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        BlocConsumer<TogglePageViewCubit, int>(
                          listener: (context, state) {
                            if (controller.page == 1) {
                              controller.previousPage(
                                  duration: const Duration(milliseconds: 600),
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
                                BlocBuilder<PncsInfoCubit, PncInfoState>(
                                  builder: (context, st) {
                                    final bool isEnglish =
                                        EasyLocalization.of(context)?.currentLocale?.languageCode == 'en';
                                    if(st is PncInfoSuccessState){
                                      shortDesc = isEnglish ? st.data.shortDescEn : st.data.shortDescNp;
                                      contentDesc = isEnglish ? st.data.contentEn : st.data.contentNp;
                                      title = isEnglish ? st.data.titleEn : st.data.titleNp;
                                    }
                                    return (st is PncInfoSuccessState)
                                        ? RefreshIndicator(
                                      onRefresh: () async {
                                        if (await sl<NetworkInfo>()
                                            .isConnected) {
                                          context
                                              .read<PncsInfoCubit>()
                                              .getPncsInfo(true);
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
                                            child:  Column(
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
                                BlocBuilder<PncsCubit, PncState>(
                                  builder: (context, state) {
                                    if (state is PncSuccessState) {
                                      return RefreshIndicator(
                                          onRefresh: () async {
                                            if (await sl<NetworkInfo>()
                                                .isConnected) {
                                              context
                                                  .read<PncsCubit>()
                                                  .getPncs(true);
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
                                                final list = state.data
                                                    .data[index].reportData;
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
                                                              "${LocaleKeys.pnc.tr() } ${LocaleKeys.label_report.tr()}${index + 1}"
                                                                  .toUpperCase(),
                                                              style: theme
                                                                  .textTheme
                                                                  .labelMedium
                                                                  ?.copyWith(
                                                                      color: AppColors
                                                                          .primaryRed)),
                                                          VerticalSpace(10.h),
                                                          ShadowContainer(
                                                            radius: 20.r,
                                                            width: 380.w,
                                                            color: Colors.white,
                                                            padding:
                                                                defaultPadding
                                                                    .copyWith(
                                                                        top: 10
                                                                            .h,
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
                                                          VerticalSpace(15.h),
                                                        ],
                                                      );
                                              }),
                                              separatorBuilder: (ctx, index) {
                                                return const Divider(
                                                  color: AppColors.white,
                                                );
                                              },
                                              itemCount: state.data.data.isEmpty
                                                  ? 1
                                                  : state.data.data.length));
                                    } else {
                                      return ShimmerLoading(
                                          boxHeight: 400.h, itemCount: 3);
                                    }
                                  },
                                ),
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
