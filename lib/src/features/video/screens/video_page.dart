import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/features/video/cubit/video_cubit.dart';
import 'package:aamako_maya/src/features/video/model/video_model.dart';
import 'package:aamako_maya/src/features/video/screens/video_playing_page.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../injection_container.dart';
import '../../../../l10n/locale_keys.g.dart';
import '../../../core/connection_checker/network_connection.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {

  checkInternet()async{
    if (await sl<NetworkInfo>().isConnected) {
      context.read<VideoCubit>().getVideos(true);
    } else {
      context.read<VideoCubit>().getVideos(false);
      BotToast.showText(
          text: LocaleKeys.no_internet_connection.tr());
    }
  }

  @override
  void initState() {
    checkInternet();
    super.initState();
  }



  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<VideoCubit, VideoState>(
      listener: (context, state) {
        // if (state is VideoSuccessState && state.isRefreshed) {
        //   BotToast.showText(text: LocaleKeys.msg_video_fetch_success.tr());
        // }
      },
      builder: (ct, st) {
        if (st is VideoLoadingState) {
          return ShimmerLoading(boxHeight: 200.h, itemCount: 4);
        } else if (st is VideoSuccessState) {
          final bool isEnglish =
              EasyLocalization.of(context)?.currentLocale?.languageCode == 'en';
              return VideoListPage(
                isEnglish: isEnglish,
                list: st.data,
              );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(LocaleKeys.error_msg_someting_went_wrong.tr()),
              IconButton(
                  onPressed: () async {
                    if (await sl<NetworkInfo>().isConnected) {
                      context.read<VideoCubit>().getVideos(true);
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

class VideoListPage extends StatefulWidget {
  // final List videoPlayerController;
  final List<VideoModel> list;
  final bool isEnglish;

  const VideoListPage({
    Key? key,
    required this.list,
    required this.isEnglish,
  }) : super(key: key);

  @override
  State<VideoListPage> createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        if (await sl<NetworkInfo>().isConnected) {
          context.read<VideoCubit>().getVideos(true);
        } else {
          BotToast.showText(text: LocaleKeys.no_internet_connection.tr());
        }
      },
      child: ListView.separated(
          separatorBuilder: (ctx, index) {
            return VerticalSpace(20.h);
          },
          padding: defaultPadding.copyWith(bottom: 22.h, top: 22.h),
          shrinkWrap: true,
          itemCount: widget.list.length,
          itemBuilder: (ctx, index) => GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => VideoPlayingPage(
                          widget.list, widget.list[index], index)));
                },
                child: ShadowContainer(
                  padding: REdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 100.w,
                          height: 100.w,
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: widget.list[index].thumbnail,
                                placeholder: (ctx, url) => Container(
                                  height: 100.w,
                                  width: 100.w,
                                  color: AppColors.accentGrey,
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              Align(
                                child: Icon(
                                  Icons.play_circle,
                                  color: AppColors.white,
                                  size: 35.sm,
                                ),
                              )
                            ],
                          )),
                      HorizSpace(10.w),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Html(
                                data: widget.isEnglish
                                    ? widget.list[index].titleEn
                                    : widget.list[index].titleNp),
                            Html(
                                data: widget.isEnglish
                                    ? widget.list[index].descriptionEn
                                    : widget.list[index].descriptionNp)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
    );
  }
}
