import 'package:Amakomaya/src/core/padding/padding.dart';
import 'package:Amakomaya/src/core/theme/app_colors.dart';
import 'package:Amakomaya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:Amakomaya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:Amakomaya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:Amakomaya/src/features/faqs/cubit/faqs_cubit.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../injection_container.dart';
import '../../../../l10n/locale_keys.g.dart';
import '../../../core/connection_checker/network_connection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class FaqsPage extends StatefulWidget {
  const FaqsPage({Key? key}) : super(key: key);

  @override
  State<FaqsPage> createState() => _FaqsPageState();
}

class _FaqsPageState extends State<FaqsPage> {

  @override
  void initState() {
    context.read<FaqsCubit>().getfaqs(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    return BlocConsumer<FaqsCubit, FaqsState>(
      listener: (ctx, sta) {
        if (sta is FaqSuccessState && sta.isRefreshed) {
          BotToast.showText(text: LocaleKeys.msg_faqs_refresh_success.tr());
        }
      },
      builder: (context, state) {
        if (state is FaqLoadingState) {
          return ShimmerLoading(boxHeight: 200.h, itemCount: 4);
        } else if (state is FaqSuccessState) {
          final bool isEnglish =
              EasyLocalization.of(context)?.currentLocale?.languageCode == 'en';

          return RefreshIndicator(
            onRefresh: () async {
              if (await sl<NetworkInfo>().isConnected) {
                context.read<FaqsCubit>().getfaqs(true);
              } else {
                BotToast.showText(
                    text: LocaleKeys.no_internet_connection.tr());
              }
            },
            child: ListView.separated(
                padding: defaultPadding.copyWith(top: 27.h, bottom: 27.h),
                itemBuilder: ((context, index) {
                      return ShadowContainer(
                          radius: 20.r,
                          width: 380.w,
                          color: Colors.white,
                          padding: defaultPadding.copyWith(top: 10, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ExpansionTile(
                                title: Text(isEnglish ?
                                  state.faqs[index].questionEn :  state.faqs[index].questionNp ,
                                  style: TextStyle(
                                      fontFamily: "lato",
                                      color: AppColors.primaryRed,
                                      fontSize: 17.sm),
                                ),
                                children: [
                                  Text(isEnglish ?
                                    state.faqs[index].answerEn :state.faqs[index].answerNp,
                                    style: theme.textTheme.labelSmall,
                                  ),
                                  Builder(builder: (context) {
                                    final medialinks =
                                        state.faqs[index].mediaLinks;
                                    final splitted = medialinks.split(',');

                                    return splitted.isNotEmpty
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ...splitted
                                                  .map((e) => GestureDetector(
                                                      onTap: () async {
                                                        if (await canLaunchUrl(
                                                            Uri.parse(e))) {
                                                          await launchUrl(
                                                              Uri.parse(e));
                                                        } else {
                                                          BotToast.showText(
                                                              text: LocaleKeys
                                                                  .error_msg_cannot_launch_url.tr());
                                                        }
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 8.h),
                                                        child: Text(
                                                          e,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .labelMedium
                                                              ?.copyWith(
                                                                  color: AppColors
                                                                      .primaryRed,
                                                                  fontSize:
                                                                      20.sm),
                                                        ),
                                                      )))
                                                  .toList()
                                            ],
                                          )
                                        : GestureDetector(
                                            onTap: () async {
                                              if (await canLaunchUrl(Uri.parse(
                                                  state.faqs[index]
                                                          .mediaLinks))) {
                                                await launchUrl(Uri.parse(state
                                                        .faqs[index]
                                                        .mediaLinks ));
                                              } else {
                                                BotToast.showText(
                                                    text: LocaleKeys
                                                        .error_msg_cannot_launch_url.tr());
                                              }
                                            },
                                            child: Text(
                                              state.faqs[index].mediaLinks,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium
                                                  ?.copyWith(
                                                      color:
                                                          AppColors.primaryRed,
                                                      fontSize: 18.sm),
                                            ));
                                  })
                                ],
                              ),
                            ],
                          ));
                }),
                separatorBuilder: (ctx, index) {
                  return const Divider(
                    color: AppColors.white,
                  );
                },
                itemCount: state.faqs.length),
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(LocaleKeys.error_msg_someting_went_wrong.tr()),
              IconButton(
                  onPressed: () async {
                    if (await sl<NetworkInfo>().isConnected) {
                      context.read<FaqsCubit>().getfaqs(true);
                    } else {
                      BotToast.showText(
                          text: LocaleKeys.no_internet_connection.tr());
                    }
                  },
                  icon: Icon(
                    Icons.refresh,
                    size: 22.sm,
                    color: Colors.black,
                  ))
            ],
          );
        }
      },
    );
  }
}
