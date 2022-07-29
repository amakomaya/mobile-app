import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/features/video/cubit/video_cubit.dart';
import 'package:aamako_maya/src/features/video/model/video_model.dart';
import 'package:aamako_maya/src/features/video/screens/video_playing_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../authentication/cache/cache_values.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  // late BetterPlayerController _betterPlayerController;
  @override
  void initState() {
    // context.read<VideoCubit>().getVideos(isRefreshed: false);
    super.initState();
  }

  final ItemScrollController _scrollController = ItemScrollController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return BlocConsumer<VideoCubit, VideoState>(
      listener: (context, state) {},
      builder: (context, state) {
        return state.maybeWhen(
            orElse: () => const Center(
                  child: Text('Can\'t load data!!'),
                ),
            initial: (isLoading, error) =>
                ShimmerLoading(boxHeight: 175.h, itemCount: 4),
            success: ((isLoading, error, videos) {
              print(videos.length.toString() + 'saas');
              final urlList = [];
              for (VideoModel path in videos) {
                final controller = VideoPlayerController.network(path.path);
                urlList.add(controller);
              }

              return VideoListPage(
                videoPlayerController: urlList,
                list: videos,
              );
            }));
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
  // ChewieController? _chewieController;
  // VideoPlayerController? _videoController;
  // final ItemScrollController _scrollController = ItemScrollController();
  // ValueNotifier<String?> currentUrl = ValueNotifier(null);
  // playVideo(int index, String url) {
  //   if (currentUrl.value != url) {
  //     _videoController?.pause();
  //     _chewieController?.pause();

  //     currentUrl.value = url;
  //     print(currentUrl.value);

  //     _videoController = VideoPlayerController.network(url)..initialize();

  //     _chewieController = ChewieController(
  //       videoPlayerController: _videoController!,
  //       aspectRatio: 16 / 9,
  //       autoInitialize: false,
  //       autoPlay: false,
  //       errorBuilder: (context, errorMessage) {
  //         return Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Center(
  //               child: Text(
  //                 "Error Playing Video",
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //             ),
  //             HorizSpace(10.w),
  //             IconButton(
  //                 onPressed: () {
  //                   playVideo(index, url);
  //                 },
  //                 icon: Icon(Icons.threesixty_sharp)),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  @override
  void initState() {
    // _videoController = VideoPlayerController.network(
    //   widget.list[0].path,
    // )..initialize();

    // _chewieController = ChewieController(
    //   videoPlayerController: _videoController!,
    //   aspectRatio: 16 / 9,
    //   autoInitialize: false,
    //   autoPlay: false,
    //   errorBuilder: (context, errorMessage) {
    //     return Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Center(
    //           child: Text(
    //             "Error Playing Video",
    //             style: TextStyle(color: Colors.white),
    //           ),
    //         ),
    //         HorizSpace(10.w),
    //         IconButton(
    //             onPressed: () {
    //               _chewieController?.play();
    //             },
    //             icon: Icon(Icons.threesixty_sharp)),
    //       ],
    //     );
    //   },
    // );

    super.initState();
  }

  @override
  void dispose() {
    // _chewieController?.dispose();
    // _videoController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      onVisibilityChanged: (visibilityInfo) {
        var visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage < 100.0) {
          // _chewieController?.pause();
        }

        debugPrint(
            'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible');
      },
      key: const ValueKey('VisiblekeyVideo'),
      child: Column(
        children: [
          VerticalSpace(5.h),
         
          Expanded(
              child: ListView.builder(
                  // itemScrollController: _scrollController,
                  padding: defaultPadding.copyWith(bottom: 20, top: 20),
                  shrinkWrap: true,
                  itemCount: widget.videoPlayerController.length,
                  itemBuilder: (ctx, index) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VideoPlayingPage(
                            widget.list,
                            widget.list[index]
                          )));
                          // playVideo(index, widget.list[index].path);

                          // _scrollController.scrollTo(
                          //     index: index, duration: Duration(seconds: 1));
                        },
                        child: ShadowContainer(
                          margin: const EdgeInsets.only(bottom: 20),
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
                      ))),
        ],
      ),
    );
  }
}
