import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../injection_container.dart';
import '../../../../l10n/locale_keys.g.dart';
import '../../../core/connection_checker/network_connection.dart';
import '../../../core/padding/padding.dart';
import '../../../core/snackbar/error_snackbar.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/helper_widgets/blank_space.dart';
import '../../../core/widgets/helper_widgets/shadow_container.dart';
import '../../../core/widgets/loading_shimmer/shimmer_loading.dart';
import '../../authentication/authentication_cubit/auth_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../fetch user data/cubit/get_user_cubit.dart';
import '../../labtest/cubit/toggle_page_view_cubit.dart';
import '../cubit/ancs_cubit.dart';
import '../cubit/ancs_info_cubit.dart';

class AncsPage extends StatefulWidget {
  const AncsPage({Key? key}) : super(key: key);

  @override
  State<AncsPage> createState() => _AncsPageState();
}

class _AncsPageState extends State<AncsPage> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  PageController controller = PageController();

  @override
  void initState() {
    context.read<AncsCubit>().getAncs(false);
    context.read<AncsInfoCubit>().getAncsInfo(false);
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
                                BlocBuilder<AncsInfoCubit, AncsInfoState>(
                                  builder: (context, st) {
                                    final bool isEnglish =
                                        EasyLocalization.of(context)?.currentLocale?.languageCode == 'en';
                                    if(st is AncInfoSuccessState){
                                       shortDesc = isEnglish ? st.data.shortDescEn : st.data.shortDescNp;
                                       contentDesc = isEnglish ? st.data.contentEn : st.data.contentNp;
                                       title = isEnglish ? st.data.titleEn : st.data.titleNp;
                                    }
                                    return (st is AncInfoSuccessState)
                                        ? RefreshIndicator(
                                            onRefresh: () async {
                                              if (await sl<NetworkInfo>()
                                                  .isConnected) {
                                                context
                                                    .read<AncsInfoCubit>()
                                                    .getAncsInfo(true);
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
                                BlocBuilder<AncsCubit, AncsState>(
                                  builder: (context, state) {
                                    return (state is AncSuccessState)
                                        ? RefreshIndicator(
                                            onRefresh: () async {
                                              if (await sl<NetworkInfo>()
                                                  .isConnected) {
                                                context
                                                    .read<AncsCubit>()
                                                    .getAncs(true);
                                              } else {
                                                BotToast.showText(
                                                    text: LocaleKeys
                                                        .no_internet_connection.tr());
                                              }
                                            },
                                            child: ListView.separated(
                                                shrinkWrap: true,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 50.h),
                                                itemBuilder: ((context, index) {
                                                  final ancs = state.data
                                                      .data[index].reportData;
                                                  return (state
                                                          .data.data.isEmpty)
                                                      ? Center(
                                                          child: Padding(
                                                            padding: REdgeInsets
                                                                .only(
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
                                                                "${LocaleKeys.anc.tr() } ${LocaleKeys.label_report.tr() } ${index + 1}"
                                                                    .toUpperCase(),
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "lato",
                                                                    color: AppColors
                                                                        .primaryRed,
                                                                    fontSize:
                                                                        17.sm)),
                                                            VerticalSpace(10.h),
                                                            ShadowContainer(
                                                              radius: 20.r,
                                                              width: 380.w,
                                                              color:
                                                                  Colors.white,
                                                              padding: defaultPadding
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
                                                                      in ancs)
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
                                                itemCount:
                                                    state.data.data.length),
                                          )
                                        : ShimmerLoading(
                                            boxHeight: 330.h, itemCount: 4);
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
                                              child: Text(
                                                LocaleKeys.label_info.tr()
                                                    .toUpperCase(),
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
Widget shadowContainerWithHtm(
    BuildContext context,
    String dataContent,
    {String? title, ThemeData? theme}) {
  return ShadowContainer(
    radius: 20.r,
    width: 380.w,
    color: Colors.white,
    padding: defaultPadding.copyWith(top: 10.h, bottom: 10.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(title,
              style: theme?.textTheme.headlineMedium
                  ?.copyWith(fontSize: 20.sm, fontWeight: FontWeight.bold)),
          Divider(thickness: 2)
        ],
        Html(data: dataContent, style: {
          "h2": Style(
              fontSize: FontSize(16.0.sm), fontWeight: FontWeight.normal)
        }, customRenders: {
          customTagMatcher(dataContent):
          CustomRender.widget(widget: (ctx, buildChildren) {
            final element = ctx.tree.element!.text;
            String text = element;
            String link = 'amakomaya.com/en';
            final urlRegExp = RegExp(
                r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");

            final urlMatches = urlRegExp.allMatches(text);
            List<String> urls = urlMatches
                .map((urlMatch) =>
                text.substring(urlMatch.start, urlMatch.end))
                .toList();
            for (var x in urls) {
              link = x;
            }

            final htmlText = dataContent.replaceAll(urlRegExp, ' ');

            return Column(
              children: [
                Html(data: htmlText, style: {
                  "body": Style(
                    fontSize: FontSize(16.0.sm),
                  )
                }),
                GestureDetector(
                  onLongPress: () {
                    Clipboard.setData(ClipboardData(text: link))
                        .then((value) {
                      BotToast.showText(
                          text: LocaleKeys.msg_copied_to_clipboard.tr());
                    });
                  },
                  onTap: () async {
                    if (await canLaunchUrl(Uri.parse(link))) {
                      await launchUrl(Uri.parse(link));
                    } else {
                      BotToast.showText(
                          text: LocaleKeys.error_msg_cannot_launch_url.tr());
                    }
                  },
                  child: Text(
                    link,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.primaryRed, fontSize: 14.sm),
                  ),
                ),
              ],
            );
          }),
        })
      ],
    ),
  );
}

CustomRenderMatcher customTagMatcher(String sff) => (context) {
  String text = sff;
  String link = '';
  final urlRegExp = RegExp(
      r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");
  final urlMatches = urlRegExp.allMatches(text);
  List<String> urls = urlMatches
      .map((urlMatch) => text.substring(urlMatch.start, urlMatch.end))
      .toList();
  for (var x in urls) {
    link = x;
  }

  return link.isNotEmpty;
};