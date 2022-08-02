import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/features/video/model/video_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:video_player/video_player.dart';

import '../../../core/widgets/helper_widgets/blank_space.dart';
import '../../../core/widgets/helper_widgets/shadow_container.dart';
import '../../audio/screens/audio_player_section.dart';

class VideoPlayingPage extends StatefulWidget {
  final List<VideoModel> list;
  final VideoModel selected;
  const VideoPlayingPage(this.list, this.selected, {Key? key})
      : super(key: key);

  @override
  State<VideoPlayingPage> createState() => _VideoPlayingPageState();
}

class _VideoPlayingPageState extends State<VideoPlayingPage> {
  late VideoPlayerController _controller;
  final ItemScrollController _scrollController = ItemScrollController();
  ValueNotifier<bool> isPlaying = ValueNotifier(false);
  ValueNotifier<Duration> position = ValueNotifier(Duration.zero);
  ValueNotifier<Duration> duration = ValueNotifier(Duration.zero);
  late String currentUrl;
  changevideo(String url) async {
    if (url != currentUrl) {
      await _controller.pause();

      _controller = VideoPlayerController.network(url)
        ..initialize().then((value) {
          currentUrl = url;
          setState(() {});
        });

      await _controller.play();
      _controller.addListener(() {
        isPlaying.value = _controller.value.isPlaying;
        duration.value = _controller.value.duration;
        position.value = _controller.value.position;
      });
    }
  }

  @override
  void initState() {
    currentUrl = widget.selected.path;
    _controller = VideoPlayerController.network(widget.selected.path)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.

        setState(() {});
      });
    //   audioPlayer.onPlayerStateChanged.listen((event) {
    //   isPlaying.value = event == PlayerState.playing;
    // });

    _controller.addListener(() {
      isPlaying.value = _controller.value.isPlaying;
      duration.value = _controller.value.duration;
      position.value = _controller.value.position;
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.pause();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          SizedBox(
            height: 60.h,
            width: MediaQuery.of(context).size.width,
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 5),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.accentGrey,
                  ),
                ),
              ),
            ),
          ),
          Stack(
            children: [
              AspectRatio(
                aspectRatio: isPortrait ? 16 / 9 : 4 / 1,
                child: VideoPlayer(_controller),
              ),
            ],
          ),
          //  ValueListenableBuilder(
          //    valueListenable: duration,
          //    builder: (context,d,r) {
          //      return ValueListenableBuilder(
          //       valueListenable: position,
          //        builder: (context,f,h) {
          //          return LinearProgressIndicator(
          //           minHeight: 5.h,
          //          backgroundColor: Colors.black,
          //             value: (_controller.value.position.inSeconds)/_controller.value.duration.inSeconds,
          //             semanticsLabel: 'Linear progress indicator',
          //           );
          //        }
          //      );
          //    }
          //  ),
          ValueListenableBuilder(
              valueListenable: duration,
              builder: (context, r, t) {
                return ValueListenableBuilder(
                    valueListenable: position,
                    builder: (context, m, j) {
                      return Slider(
                        thumbColor: Colors.white,
                        activeColor: AppColors.primaryRed,
                        inactiveColor: AppColors.primaryRed.withOpacity(0.2),
                        max: duration.value.inSeconds.toDouble(),
                        min: 0,
                        value: position.value.inSeconds.toDouble(),
                        onChanged: (double value) async {
                          final position = Duration(seconds: value.toInt());
                          await _controller.seekTo(position);
                        },
                      );
                    });
              }),
          Padding(
            padding: defaultPadding,
            child: Row(
              children: [
                ValueListenableBuilder(
                    valueListenable: position,
                    builder: (context, c, v) {
                      return Text(
                        formatTime(
                          position.value,
                        ),
                      );
                    }),
                Spacer(),
                IconButton(
                    onPressed: () {
                      _controller
                          .seekTo(position.value - const Duration(seconds: 10));
                    },
                    icon: Icon(
                      CupertinoIcons.arrow_counterclockwise,
                      color: AppColors.accentGrey,
                    )),
                HorizSpace(10.w),
                ValueListenableBuilder(
                    valueListenable: isPlaying,
                    builder: (a, b, c) {
                      return IconButton(
                          onPressed: () {
                            isPlaying.value
                                ? _controller.pause()
                                : _controller.play();
                          },
                          icon: Icon(
                            _controller.value.isPlaying
                                ? CupertinoIcons.pause
                                : CupertinoIcons.play,
                            color: AppColors.accentGrey,
                            size: 35.sm,
                          ));
                    }),
                HorizSpace(10.w),
                IconButton(
                    onPressed: () {
                      _controller
                          .seekTo(position.value + const Duration(seconds: 10));
                    },
                    icon: Icon(
                      CupertinoIcons.arrow_clockwise,
                      color: AppColors.accentGrey,
                    )),
                Spacer(),
                ValueListenableBuilder(
                    valueListenable: position,
                    builder: (context, c, v) {
                      return Text(
                        formatTime(
                          duration.value,
                        ),
                      );
                    }),
              ],
            ),
          ),
          Expanded(
            child: ScrollablePositionedList.builder(
                shrinkWrap: true,
                itemScrollController: _scrollController,
                itemCount: widget.list.length,
                itemBuilder: (ctx, ind) {
                  return InkWell(
                    onTap: () async {
                      changevideo(widget.list[ind].path);

                      _scrollController.scrollTo(
                          index: ind, duration: const Duration(seconds: 1));
                    },
                    child: ShadowContainer(
                      color: currentUrl == widget.list[ind].path
                          ? AppColors.grey
                          : null,
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
                              imageUrl: widget.list[ind].thumbnail,
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
                                Html(data: widget.list[ind].titleEn),
                                Html(data: widget.list[ind].descriptionEn)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      )),
    );
  }
}
