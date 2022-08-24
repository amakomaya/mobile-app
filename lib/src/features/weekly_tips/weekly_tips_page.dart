import 'package:aamako_maya/src/core/connection_checker/network_connection.dart';
import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/snackbar/error_snackbar.dart';
import 'package:aamako_maya/src/core/snackbar/success_snackbar.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/features/weekly_tips/cubit/weekly_tips_cubit.dart';
import 'package:aamako_maya/src/features/weekly_tips/model/weekly_tips_model.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../injection_container.dart';
import '../../core/cache/weekly_cache/cache_values.dart';
import '../../core/theme/app_colors.dart';

class WeeklyTipsPage extends StatefulWidget {
  const WeeklyTipsPage({Key? key}) : super(key: key);

  @override
  State<WeeklyTipsPage> createState() => _WeeklyTipsPageState();
}

class _WeeklyTipsPageState extends State<WeeklyTipsPage> {
  @override
  void initState() {
    context.read<WeeklyTipsCubit>().getWeeklyTips(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<WeeklyTipsCubit, WeeklyTipsState>(
        builder: (ctx, state) {
      if (state is WeeklyTipsSucces) {
        final list = state.data;
        final bool isEnglish =
            EasyLocalization.of(context)?.currentLocale?.languageCode == 'en';
        return RefreshIndicator(
          onRefresh: () async {
            if (await sl<NetworkInfo>().isConnected) {
              context.read<WeeklyTipsCubit>().getWeeklyTips(true);
            } else {
              BotToast.showText(text: 'No Internet Connection !');
            }
          },
          child: ListView.separated(
              padding: defaultPadding.copyWith(bottom: 25.h),
              primary: false,
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalSpace(20.h),
                    ShadowContainer(
                      radius: 30,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              isEnglish
                                  ? (list[index].titleEn)
                                  : (list[index].titleNp),
                              style: theme.textTheme.labelMedium),
                          Divider(
                            height: 15.w,
                            color: AppColors.accentGrey,
                          ),
                          Html(
                            data: (list[index].descriptionNp),
                            onImageError: (sd, f) {},
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (ctx, index) => VerticalSpace(20.h),
              itemCount: list.length),
        );
      } else {
        return ShimmerLoading(boxHeight: 500.h, itemCount: 2);
      }
    }, listener: (state, cs) {
      if (cs is WeeklyTipsSucces) {
        if (cs.isRefreshed == true) {
          BotToast.showText(text: 'Successfully Refreshed !');
        }
      }
    });
  }
}
