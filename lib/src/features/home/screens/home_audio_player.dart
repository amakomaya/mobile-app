import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/helper_widgets/blank_space.dart';
import '../../audio/screens/audio_player_section.dart';

class HomeAudioPlayerPage extends StatefulWidget {
  final String audioUrl;

  const HomeAudioPlayerPage({Key? key, required this.audioUrl})
      : super(key: key);

  @override
  State<HomeAudioPlayerPage> createState() => _HomeAudioPlayerPageState();
}

class _HomeAudioPlayerPageState extends State<HomeAudioPlayerPage>
    with WidgetsBindingObserver {
  ValueNotifier<bool> isPlaying = ValueNotifier(false);

  late AudioPlayer _audioPlayer;

  ValueNotifier<Duration> dur = ValueNotifier(Duration.zero);
  ValueNotifier<Duration> pos = ValueNotifier(Duration.zero);

  ValueNotifier<String?> currentUrl = ValueNotifier(null);

  ValueNotifier<String?> currentAudio = ValueNotifier(null);
  ValueNotifier<String?> currentThumbnail = ValueNotifier(null);

  playAudio(String url) async {
    try {
      await _audioPlayer.play(UrlSource(widget.audioUrl));
    } catch (e) {
      BotToast.showText(text: 'Something is wrong!');
    }
  }

  @override
  void initState() {
    _audioPlayer = AudioPlayer(
      playerId: widget.audioUrl,
    );
    playAudio(widget.audioUrl);

    _audioPlayer.onPlayerStateChanged.listen((event) {
      isPlaying.value = event == PlayerState.playing;
    });
    _audioPlayer.onDurationChanged.listen((event) {
      dur.value = event;
    });
    _audioPlayer.onPositionChanged.listen((event) {
      pos.value = event;
    });
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _audioPlayer.pause();
    }
    if (state == AppLifecycleState.resumed) {
      _audioPlayer.resume();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(_audioPlayer),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0) {
          _audioPlayer.pause();
        } else if (visibility.visibleFraction == 1) {
          _audioPlayer.resume();
        }
      },
      child: SafeArea(
          child: Scaffold(
        // appBar: AppBar(automaticallyImplyLeading: true,),
        body: Column(
          children: [
            SizedBox(
              height: 60.h,
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.accentGrey,
                  ),
                ),
              ),
            ),
            Container(
              width: 360.w,
              height: 360.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(33),
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://img.freepik.com/free-psd/cover-compact-disc-mockup_7838-394.jpg?w=2000"))),
            ),
            const Spacer(),
            const Padding(
              padding: defaultPadding,
              child: Text('Title'),
            ),
            VerticalSpace(10.h),
            const Padding(
              padding: defaultPadding,
              child: Text('Author'),
            ),
            ValueListenableBuilder(
                valueListenable: dur,
                builder: (ctx, d, w) {
                  return ValueListenableBuilder(
                      valueListenable: pos,
                      builder: (context, positionValue, widgetValue) {
                        return Slider(
                          thumbColor: Colors.white,
                          activeColor: AppColors.primaryRed,
                          inactiveColor: AppColors.primaryRed.withOpacity(0.2),
                          max: dur.value.inSeconds.toDouble(),
                          min: 0,
                          value: pos.value.inSeconds.toDouble(),
                          onChanged: (double value) async {
                            final position = Duration(seconds: value.toInt());
                            // await _controller.seekTo(position);
                          },
                        );
                      });
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  ValueListenableBuilder(
                      valueListenable: pos,
                      builder: (context, position, widget) {
                        return Text(
                          formatTime(
                            pos.value,
                          ),
                        );
                      }),
                  Spacer(),
                  ValueListenableBuilder(
                      valueListenable: dur,
                      builder: (context, duration, wid) {
                        return Text(formatTime(dur.value - pos.value)
                            // formatTime(
                            //   duration.value,

                            );
                      })
                ],
              ),
            ),
            VerticalSpace(20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _audioPlayer.seek(pos.value - const Duration(seconds: 10));
                  },
                  child: Icon(
                    Icons.skip_previous_rounded,
                    color: AppColors.accentGrey,
                    size: 66.sm,
                  ),
                ),
                ValueListenableBuilder(
                    valueListenable: isPlaying,
                    builder: (context, listen, widget) {
                      return GestureDetector(
                        onTap: () {
                          if (isPlaying.value) {
                            _audioPlayer.pause();
                          } else {
                            _audioPlayer.resume();
                          }
                        },
                        child: Icon(
                          isPlaying.value
                              ? Icons.pause
                              : Icons.play_arrow_rounded,
                          color: AppColors.accentGrey,
                          size: 66.sm,
                        ),
                      );
                    }),
                GestureDetector(
                  onTap: () {
                    _audioPlayer.seek(pos.value + const Duration(seconds: 10));
                  },
                  child: Icon(
                    Icons.skip_next_rounded,
                    color: AppColors.accentGrey,
                    size: 66.sm,
                  ),
                )
              ],
            ),
            Spacer(),
          ],
        ),
      )),
    );
  }
}
