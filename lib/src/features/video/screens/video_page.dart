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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../injection_container.dart';
import '../../../core/connection_checker/network_connection.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  void initState() {
    context.read<VideoCubit>().getVideos(false);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoCubit, VideoState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is VideoLoadingState) {
          return ShimmerLoading(boxHeight: 200.h, itemCount: 4);
        } else if (state is VideoSuccessState) {
          final urlList = [];
          for (VideoModel path in state.data) {
            final controller = VideoPlayerController.network(path.path);
            urlList.add(controller);
          }

          return VideoListPage(
            videoPlayerController: urlList,
            list: state.data,
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Something Went Wrong!"),
              IconButton(
                  onPressed: () async {
                    if (await sl<NetworkInfo>().isConnected) {
                      context.read<VideoCubit>().getVideos(true);
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
        }
      },
    );
  }
}

class VideoListPage extends StatefulWidget {
  final List videoPlayerController;
  final List<VideoModel> list;
  const VideoListPage(
      {Key? key, required this.list, required this.videoPlayerController})
      : super(key: key);

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
          BotToast.showText(text: 'No Internet Connection !');
        }
      },
      child: ListView.separated(
          separatorBuilder: (ctx, index) {
            return VerticalSpace(20.h);
          },
          padding: defaultPadding.copyWith(bottom: 22.h, top: 22.h),
          shrinkWrap: true,
          itemCount: widget.videoPlayerController.length,
          itemBuilder: (ctx, index) => GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => VideoPlayingPage(
                          widget.list, widget.list[index], index)));
                },
                child: ShadowContainer(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100.w,
                        height: 100.h,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: widget.list[index].thumbnail,
                          placeholder: (ctx, url) => Container(
                            height: 100.h,
                            width: 100.w,
                            color: AppColors.accentGrey,
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      HorizSpace(10.w),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Html(data: widget.list[index].titleEn),
                            Html(data: widget.list[index].descriptionEn)
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
