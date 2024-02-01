import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../injection_container.dart';
import '../../../l10n/locale_keys.g.dart';
import '../../core/connection_checker/network_connection.dart';
import '../../core/padding/padding.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/helper_widgets/blank_space.dart';
import '../../core/widgets/helper_widgets/shadow_container.dart';
import 'cubit/notification_cubit.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  checkInternet() async {
    if (await sl<NetworkInfo>().isConnected) {
      context.read<NotificationCubit>().getNotification(true);
    } else {
      context.read<NotificationCubit>().getNotification(false);
      BotToast.showText(text: LocaleKeys.no_internet_connection.tr());
    }
  }

  @override
  void initState() {
    // checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isEnglish =
        EasyLocalization.of(context)?.currentLocale?.languageCode == 'en';
    return BlocProvider(
      create: (context) => sl<NotificationCubit>()..getNotification(true),
      child: BlocConsumer<NotificationCubit, NotificationState>(
          builder: (ctx, state) {
        if (state is NotificationSuccess) {
          final list = state.data;
          return RefreshIndicator(
              onRefresh: () async {
                if (await sl<NetworkInfo>().isConnected) {
                  context.read<NotificationCubit>().getNotification(true);
                } else {
                  BotToast.showText(
                      text: LocaleKeys.no_internet_connection.tr());
                }
              },
              child: SingleChildScrollView(
                primary: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListView.separated(
                        padding: defaultPadding.copyWith(bottom: 25.h),
                        primary: false,
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              VerticalSpace(20.h),
                              ShadowContainer(
                                radius: 30.r,
                                padding: REdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        isEnglish
                                            ? (list[index].titleEn)
                                            : (list[index].titleNp),
                                        style: theme.textTheme.labelMedium),
                                    SizedBox(height: 10.h,),
                                    Text(
                                        isEnglish
                                            ? (list[index].titleEn)
                                            : (list[index].titleNp),
                                        style: theme.textTheme.labelMedium),
                                    SizedBox(height: 10.h,),
                                    Text(
                                        isEnglish
                                            ? (list[index].titleEn)
                                            : (list[index].titleNp),
                                        style: theme.textTheme.labelMedium),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (ctx, index) => VerticalSpace(20.h),
                        itemCount: list.length)
                  ],
                ),
              ));
        } else if (state is NotificationLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        } else if (state is NotificationFailure) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(LocaleKeys.error_msg_someting_went_wrong.tr()),
              IconButton(
                  onPressed: () async {
                    if (await sl<NetworkInfo>().isConnected) {
                      context.read<NotificationCubit>().getNotification(true);
                    } else {
                      BotToast.showText(
                          text: LocaleKeys.no_internet_connection.tr());
                    }
                  },
                  icon: Icon(
                    Icons.refresh,
                    size: 20.sm,
                    color: Colors.black,
                  ))
            ],
          );
        } else {
          return SizedBox();
        }
      }, listener: (state, cs) {
        // if (cs is WeeklyTipsSucces && cs.isRefreshed) {
        //   BotToast.showText(text: LocaleKeys.msg_tips_fetch_success.tr());
        // }
      }),
    );
  }
}

CustomRenderMatcher customTagMatcher() =>
    (context) => context.tree.element?.localName == 'img';
