import 'package:aamako_maya/localization_cubit/localization_cubit.dart';
import 'package:aamako_maya/src/core/connection_checker/network_connection.dart';
import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/snackbar/error_snackbar.dart';
import 'package:aamako_maya/src/core/snackbar/success_snackbar.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/features/weekly_tips/cubit/weekly_tips_cubit.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../injection_container.dart';
import '../../core/theme/app_colors.dart';

class WeeklyTipsPage extends StatefulWidget {
  const WeeklyTipsPage({Key? key}) : super(key: key);

  @override
  State<WeeklyTipsPage> createState() => _WeeklyTipsPageState();
}

class _WeeklyTipsPageState extends State<WeeklyTipsPage> {
  @override
  void initState() {
    context.read<WeeklyTipsCubit>().getWeeklyTips();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<WeeklyTipsCubit, WeeklyTipsState>(
        listener: (context, state) {
      if (state.error != null) {
        BotToast.showCustomText(toastBuilder: (e) {
          return ErrorSnackBar(message: state.error ?? '');
        });
      }
      if (state.success != null) {
        BotToast.showCustomText(toastBuilder: (e) {
          return SuccessSnackBar(message: state.success ?? '');
        });
      }
    }, builder: (context, state) {

    // ignore: unused_local_variable
      if (state.data == null) {
        return ShimmerLoading(boxHeight: 400.h, itemCount: 2);
      } else {
        return RefreshIndicator(
          onRefresh: () async {
            if (await sl<NetworkInfo>().isConnected) {
              context.read<WeeklyTipsCubit>().getWeeklyTips(isRefreshed: true);
            } else {
              BotToast.showCustomText(toastBuilder: (e) {
                return ErrorSnackBar(message: 'No Internet Connectivity !!');
              });
            }
          },
          child: ListView.separated(
              padding: defaultPadding,
              primary: false,
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(data[index].titleEn,
                    //     style: theme.textTheme.headlineMedium),
                    VerticalSpace(20.h),
                    ShadowContainer(
                      radius: 30,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.data?[index].titleEn ?? '',
                              style: theme.textTheme.labelMedium),
                          Divider(
                            height: 15.w,
                            color: AppColors.accentGrey,
                          ),
                          Html(
                            data: state.data?[index].descriptionEn,
                            onImageError: (sd, f) {},
                          )
                        ],
                      ),
                    ),

                    // Text(
                    //   'Other Week Information',
                    //   style: theme.textTheme.headlineMedium,
                    // ),
                    // VerticalSpace(20.h),
                    // ShadowContainer(
                    //   radius: 30,
                    //   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text('Special consideration:',
                    //           style: theme.textTheme.labelMedium),
                    //       Divider(
                    //         height: 15.w,
                    //         color: AppColors.accentGrey,
                    //       ),
                    //       Text(
                    //         "It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.",
                    //         style: theme.textTheme.labelSmall,
                    //         textAlign: TextAlign.left,
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // VerticalSpace(30.h),
                    // ShadowContainer(
                    //   radius: 30,
                    //   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text('Special consideration:',
                    //           style: theme.textTheme.labelMedium),
                    //       Divider(
                    //         height: 15.w,
                    //         color: AppColors.accentGrey,
                    //       ),
                    //       Text(
                    //         "It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.",
                    //         style: theme.textTheme.labelSmall,
                    //         textAlign: TextAlign.left,
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                );
              },
              separatorBuilder: (ctx, index) => VerticalSpace(20.h),
              itemCount: state.data?.length ?? 0),
        );
      }
    });
  }
}
