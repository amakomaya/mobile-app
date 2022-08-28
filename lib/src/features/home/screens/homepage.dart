import 'package:aamako_maya/l10n/locale_keys.g.dart';
import 'package:aamako_maya/src/core/app_assets/app_assets.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/border_container.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/features/audio/cubit/audio_cubit.dart';
import 'package:aamako_maya/src/features/authentication/drawer_cubit/drawer_cubit.dart';
import 'package:aamako_maya/src/features/home/cubit/newsfeed_cubit.dart';
import 'package:aamako_maya/src/features/home/screens/home_audio_player.dart';
import 'package:aamako_maya/src/features/video/cubit/video_cubit.dart';
import 'package:aamako_maya/src/features/weekly_tips/cubit/weekly_tips_cubit.dart';
import 'package:aamako_maya/src/features/weekly_tips/model/weekly_tips_model.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../injection_container.dart';
import '../../../core/connection_checker/network_connection.dart';
import '../../../core/padding/padding.dart';
import '../../../core/widgets/drawer/drawer_widget.dart';
import '../../authentication/authentication_cubit/auth_cubit.dart';
import '../../bottom_nav/cubit/cubit/navigation_index_cubit.dart';
import '../../fetch user data/cubit/get_user_cubit.dart';
import '../../video/screens/video_playing_page.dart';
import 'home_video_player.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  @override
  void initState() {
    context.read<NewsfeedCubit>().getNewsFeed(false);
    context.read<GetUserCubit>().getUserFromLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        //  profile Complete container

        BlocBuilder<GetUserCubit, GetUserState>(
          builder: (context, state) {
            return Visibility(
              visible: false,
              // (state is GetUserSuccess && state.user.tole.isNullOrEmpty),
              child: ShadowContainer(
                  color: Color.fromARGB(255, 221, 77, 77),
                  margin: EdgeInsets.only(top: 10.h),
                  padding: defaultPadding.copyWith(top: 10, bottom: 10),
                  width: 380.w,
                  child: RichText(
                      text: TextSpan(
                          text: 'You have not completed your profile.',
                          style: theme.textTheme.titleSmall
                              ?.copyWith(color: AppColors.white),
                          children: [
                        TextSpan(
                            text: ' Complete Your Profile Now !',
                            style: theme.textTheme.titleSmall
                                ?.copyWith(color: AppColors.white))
                      ]))),
            );
          },
        ),

        Expanded(
          child: BlocConsumer<NewsfeedCubit, NewsfeedState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is NewsfeedSuccess) {
                return RefreshIndicator(
                  onRefresh: () async {
                    if (await sl<NetworkInfo>().isConnected) {
                      context.read<NewsfeedCubit>().getNewsFeed(true);
                    } else {
                      BotToast.showText(text: 'No Internet Connection !');
                    }
                  },
                  child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      itemBuilder: ((context, index) {
                        return Column(
                          children: [
                            //news container
                            ShadowContainer(
                              radius: 20,
                              width: 380.w,
                              color: Colors.white,
                              padding:
                                  defaultPadding.copyWith(top: 10, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/logo/profile.png',
                                        height: 80.sm,
                                        width: 80.sm,
                                      ),
                                      Flexible(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.newsfeed[index].author ?? '',
                                            style: theme
                                                .textTheme.headlineMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          Text(
                                            state.newsfeed[index].publishedAt ??
                                                '',
                                            style: theme.textTheme.labelMedium
                                                ?.copyWith(
                                                    color:
                                                        AppColors.accentGrey),
                                          ),
                                        ],
                                      ))
                                    ],
                                  ),
                                  VerticalSpace(20.h),
                                  CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        state.newsfeed[index].urlToImage ?? '',
                                    placeholder: (ctx, url) => Container(
                                      height: 380.h,
                                      width: 380.w,
                                      color: AppColors.grey,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error,
                                      color: Colors.black,
                                    ),
                                  ),
                                  VerticalSpace(20.h),
                                  Html(
                                      data: state.newsfeed[index].title,
                                      customRenders: {
                                        customTagMatcher(
                                            state.newsfeed[index].title ??
                                                ''): CustomRender.widget(
                                            widget: (ctx, buildChildren) {
                                          final element =
                                              ctx.tree.element!.text;
                                          String text = element;
                                          String link = '';
                                          final urlRegExp = RegExp(
                                              r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");

                                          final urlMatches =
                                              urlRegExp.allMatches(text);
                                          List<String> urls = urlMatches
                                              .map((urlMatch) => text.substring(
                                                  urlMatch.start, urlMatch.end))
                                              .toList();
                                          for (var x in urls) {
                                            link = x;
                                          }

                                          final htmlText = state
                                              .newsfeed[index].title
                                              ?.replaceAll(urlRegExp, '');

                                          return Column(
                                            children: [
                                              Html(data: htmlText),
                                              GestureDetector(
                                                onLongPress: () {
                                                  Clipboard.setData(
                                                          ClipboardData(
                                                              text: link))
                                                      .then((value) {
                                                    BotToast.showText(
                                                        text:
                                                            'Copied to clipboard');
                                                  });
                                                },
                                                onTap: () async {
                                                  if (await canLaunchUrl(
                                                      Uri.parse(link))) {
                                                    await launchUrl(
                                                        Uri.parse(link));
                                                  } else {
                                                    BotToast.showText(
                                                        text:
                                                            'Can not launch URL');
                                                  }
                                                },
                                                child: Text(
                                                  link,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.copyWith(
                                                          color: AppColors
                                                              .primaryRed,
                                                          fontSize: 18.sm),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                      })
                                ],
                              ),
                            ),
                            VerticalSpace(20.h),
                            //audio container
                            Visibility(
                              visible:
                                  !(state.newsfeed[index].url.isNullOrEmpty),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeAudioPlayerPage()));
                                },
                                child: ShadowContainer(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  radius: 25,
                                  color: Colors.white,
                                  width: 380.w,
                                  child: Row(children: [
                                    Image.asset(AppAssets.musicIcon),
                                    Expanded(
                                        child: Text(
                                      state.newsfeed[index].url ??
                                          'Unknown.mp3',
                                      style: theme.textTheme.labelSmall,
                                    ))
                                  ]),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                      separatorBuilder: (context, index) => VerticalSpace(40.h),
                      itemCount: state.newsfeed.length),
                );
              } else if (state is NewsfeedFailure) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Something Went Wrong!"),
                    IconButton(
                        onPressed: () async {
                          if (await sl<NetworkInfo>().isConnected) {
                            context.read<NewsfeedCubit>().getNewsFeed(true);
                          } else {
                            BotToast.showText(text: 'No Internet Connection !');
                          }
                        },
                        icon: Icon(
                          Icons.refresh,
                          size: 22.sm,
                          color: Colors.black,
                        ))
                  ],
                );
              } else {
                return ShimmerLoading(boxHeight: 200.h, itemCount: 4);
              }
            },
          ),
        )
      ],
    );
  }
}

//
extension on String? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }
}
