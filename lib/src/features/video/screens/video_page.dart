import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/core/widgets/scaffold/primary_scaffold.dart';
import 'package:aamako_maya/src/features/video/cubit/video_cubit.dart';
import 'package:aamako_maya/src/features/video/model/video_model.dart';
import 'package:better_player/better_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../video_change_cubit/video_change_cubit.dart';
import '../widgets/video_playing_container_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  // late BetterPlayerController _betterPlayerController;
  @override
  void initState() {
    context.read<VideoCubit>().getVideos();
    super.initState();
  }

  late BetterPlayerDataSource betterPlayerDataSource;
  late BetterPlayerController _betterPlayerController;
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  void dispose() {
    // _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return PrimaryScaffold(
      appBartitle: 'Video',
      body: BlocConsumer<VideoCubit, VideoState>(
        listener: (context, state) {},
        builder: (context, state) {
          return state.maybeWhen(
              orElse: () => const Center(
                    child: Text('Can\'t load data!!'),
                  ),
              initial: (isLoading, error) =>
                  ShimmerLoading(boxHeight: 175.h, itemCount: 4),
              success: ((isLoading, error, videos) {
                final urlList = [];
                for (VideoModel path in videos) {
                  final controller = VideoPlayerController.network(path.path);
                  urlList.add(controller);
                }

                return VideoListPage(
                  videoPlayerController: urlList,
                  list: videos,
                );

                // return BlocProvider(
                //   create: (context) => VideoChangeCubit(),
                //   child: Builder(builder: (context) {
                //     return Padding(
                //         padding:
                //             defaultPadding.copyWith(top: 20.h, bottom: 20.h),
                //         child: Column(
                //           children: [
                //             BlocBuilder<VideoChangeCubit, VideoChangeState>(
                //               builder: (c, s) {
                //                 // if (s.videoModel != null) {
                //                 //   // print('dkjfkdjf ${s.path}');

                //                 //   betterPlayerDataSource =
                //                 //       BetterPlayerDataSource(
                //                 //           BetterPlayerDataSourceType.network,
                //                 //           s.videoModel!.path,
                //                 //           headers: {
                //                 //         "Access-Control-Allow-Origin": "*"
                //                 //       });

                //                 //   _betterPlayerController =
                //                 //       BetterPlayerController(
                //                 //     const BetterPlayerConfiguration(),
                //                 //     betterPlayerDataSource:
                //                 //         betterPlayerDataSource,
                //                 //   );

                //                 //   return VideoPlayingContainerWidget(
                //                 //       videoModel: s.videoModel!,
                //                 //       betterPlayerController:
                //                 //           _betterPlayerController);
                //                 // }
                //                 // betterPlayerDataSource = BetterPlayerDataSource(
                //                 //     BetterPlayerDataSourceType.network,
                //                 //     videos[0].path);
                //                 // _betterPlayerController =
                //                 //     BetterPlayerController(
                //                 //   const BetterPlayerConfiguration(),
                //                 //   betterPlayerDataSource:
                //                 //       betterPlayerDataSource,
                //                 // );
                //                 // return VideoPlayingContainerWidget(
                //                 //     videoModel: videos[0],
                //                 //     betterPlayerController:
                //                 //         _betterPlayerController);

                //              return   VideoPlayingContainerWidget();
                //               },
                //             ),
                //             VerticalSpace(30.h),
                //             Expanded(
                //               child: ScrollablePositionedList.builder(
                //                 padding: EdgeInsets.only(bottom: 40),
                //                 itemScrollController: _scrollController,
                //                 itemBuilder: (ctx, ind) => GestureDetector(
                //                   onTap: () {
                //                     _betterPlayerController.pause();
                //                     _scrollController.scrollTo(index: ind, duration: Duration(seconds: 1));
                //                     context
                //                         .read<VideoChangeCubit>()
                //                         .selectVideo(
                //                             betterPlayerController:
                //                                 _betterPlayerController,
                //                             value: videos[ind]);
                //                   },
                //                   child: BlocBuilder<VideoChangeCubit,
                //                       VideoChangeState>(
                //                     builder: (co, st) {
                                     
                //                     },
                //                   ),
                //                 ),
                //                 // separatorBuilder: (ctx, ind) =>
                //                 //     VerticalSpace(20.h),
                //                 itemCount: videos.length,
                //                 // primary: false,
                //               ),
                //             )
                //           ],
                //         ));
                //   }),
                // );
              }));
        },
      ),
    );
  }
}

class VideoListPage extends StatefulWidget {
  List videoPlayerController;
  List<VideoModel> list;
  VideoListPage(
      {Key? key, required this.list, required this.videoPlayerController})
      : super(key: key);

  @override
  State<VideoListPage> createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  // VideoPlayerController videoPlayerController= VideoPlayerController.network(
  //     'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4'
  // );
  late ChewieController _chewieController;

  playVideo(int index) {
    final old = _chewieController;
    old.pause();
    old.dispose();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController[index],
      aspectRatio: 16 / 9,
      autoInitialize: true,
      autoPlay: true,
      looping: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );

    // _chewieController = ChewieController(
    //   videoPlayerController: widget.videoPlayerController[index],
    //   aspectRatio: 16 / 9,
    //   autoInitialize: true,
    //   autoPlay: true,
    //   looping: true,
    //   errorBuilder: (context, errorMessage) {
    //     return Center(
    //       child: Text(
    //         errorMessage,
    //         style: TextStyle(color: Colors.white),
    //       ),
    //     );
    //   },
    // );
  }

  @override
  void initState() {
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController[0],
      aspectRatio: 16 / 9,
      autoInitialize: true,

      autoPlay: false,
      // looping: widget.looping,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      onVisibilityChanged: (visibilityInfo) {
        var visiblePercentage = visibilityInfo.visibleFraction * 100;
      if(visiblePercentage<100.0){
       
        _chewieController.pause();
      }
    
     
      debugPrint(
          'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible');
    },
      
      key: ValueKey('VisiblekeyVideo'),
      child: Column(
        children: [
          Visibility(
            visible: _chewieController != null,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Chewie(
                controller: _chewieController,
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.videoPlayerController.length,
                  itemBuilder: (ctx, index) => GestureDetector(
                        onTap: () {
                          setState(() {
                          playVideo(index);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(widget.list[index].path),
                        ),
                      ))),
        ],
      ),
    );
  }
}
