import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/core/widgets/scaffold/primary_scaffold.dart';
import 'package:aamako_maya/src/features/video/cubit/video_cubit.dart';
import 'package:aamako_maya/src/features/video/model/video_model.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                return BlocProvider(
                  create: (context) => VideoChangeCubit(),
                  child: Builder(builder: (context) {
                    return Padding(
                        padding:
                            defaultPadding.copyWith(top: 20.h, bottom: 20.h),
                        child: Column(
                          children: [
                            BlocBuilder<VideoChangeCubit, VideoChangeState>(
                              builder: (c, s) {
                                if (s.videoModel != null) {
                                  // print('dkjfkdjf ${s.path}');

                                  betterPlayerDataSource =
                                      BetterPlayerDataSource(
                                          BetterPlayerDataSourceType.network,
                                          s.videoModel!.path,
                                          headers: {
                                        "Access-Control-Allow-Origin": "*"
                                      });

                                  _betterPlayerController =
                                      BetterPlayerController(
                                    const BetterPlayerConfiguration(),
                                    betterPlayerDataSource:
                                        betterPlayerDataSource,
                                  );

                                  return VideoPlayingContainerWidget(
                                      videoModel: s.videoModel!,
                                      betterPlayerController:
                                          _betterPlayerController);
                                }
                                betterPlayerDataSource = BetterPlayerDataSource(
                                    BetterPlayerDataSourceType.network,
                                    videos[0].path);
                                _betterPlayerController =
                                    BetterPlayerController(
                                  const BetterPlayerConfiguration(),
                                  betterPlayerDataSource:
                                      betterPlayerDataSource,
                                );
                                return VideoPlayingContainerWidget(
                                    videoModel: videos[0],
                                    betterPlayerController:
                                        _betterPlayerController);
                              },
                            ),
                            VerticalSpace(30.h),
                            Expanded(
                              child: ScrollablePositionedList.builder(
                                padding: EdgeInsets.only(bottom: 40),
                                itemScrollController: _scrollController,
                                itemBuilder: (ctx, ind) => GestureDetector(
                                  onTap: () {
                                    _betterPlayerController.pause();
                                    _scrollController.scrollTo(index: ind, duration: Duration(seconds: 1));
                                    context
                                        .read<VideoChangeCubit>()
                                        .selectVideo(
                                            betterPlayerController:
                                                _betterPlayerController,
                                            value: videos[ind]);
                                  },
                                  child: BlocBuilder<VideoChangeCubit,
                                      VideoChangeState>(
                                    builder: (co, st) {
                                      return ShadowContainer(
                                          radius: 25,
                                          width: 380.w,
                                          margin: EdgeInsets.symmetric(vertical: 10),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 20.h),
                                          color: (st.videoModel?.id ==
                                                  videos[ind].id)
                                              ? Colors.grey.withOpacity(0.3)
                                              : (ind == 0 &&
                                                      st.videoModel == null)
                                                  ? Colors.grey.withOpacity(0.3)
                                                  : Colors.white,
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 113.h,
                                                width: 121.w,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          videos[ind].thumbnail,
                                                        ),
                                                        fit: BoxFit.cover),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                child: const Center(
                                                    child: Icon(
                                                  Icons
                                                      .play_circle_fill_rounded,
                                                  size: 40,
                                                )),
                                              ),
                                              HorizSpace(12.w),
                                              Flexible(
                                                child: Column(
                                                  children: [
                                                    Html(
                                                      data: videos[ind].titleEn,
                                                    ),
                                                    Divider(
                                                      endIndent: 5,
                                                      indent: 5,
                                                      height: 15.w,
                                                      color:
                                                          AppColors.accentGrey,
                                                    ),
                                                    Html(
                                                      data: videos[ind]
                                                          .descriptionEn,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ));
                                    },
                                  ),
                                ),
                                // separatorBuilder: (ctx, ind) =>
                                //     VerticalSpace(20.h),
                                itemCount: videos.length,
                                // primary: false,
                              ),
                            )
                          ],
                        ));
                  }),
                );
              }));
        },
      ),
    );
  }
}
