import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../../core/padding/padding.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/helper_widgets/blank_space.dart';
import '../../audio/screens/audio_player_section.dart';

class HomeVideoPlayer extends StatefulWidget {
  final String selectedUrl;
  const HomeVideoPlayer(this.selectedUrl, {Key? key}) : super(key: key);

  @override
  State<HomeVideoPlayer> createState() => _HomeVideoPlayerState();
}

class _HomeVideoPlayerState extends State<HomeVideoPlayer> {
  late VideoPlayerController _controller;
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
    currentUrl =
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
    _controller = VideoPlayerController.network(currentUrl)
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
          AspectRatio(
           aspectRatio: 16/9,
            child: VideoPlayer(_controller)),
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
                      Icons.skip_previous_rounded,
                      color: AppColors.accentGrey,
                      size: 35.sm,
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
                                ? Icons.pause_outlined
                                : Icons.play_arrow_rounded,
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
                      Icons.skip_next_rounded,
                      color: AppColors.accentGrey,
                      size: 35.sm,
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
        ],
      )),
    );
  }
}
