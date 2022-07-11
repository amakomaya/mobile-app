import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/features/audio/model/audio_model.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/widgets/helper_widgets/blank_space.dart';
import '../widgets/audio_container_widget.dart';

class AudioPlayerSection extends StatefulWidget {
  final List<AudioModel> audios;
  const AudioPlayerSection({Key? key, required this.audios}) : super(key: key);

  @override
  State<AudioPlayerSection> createState() => _AudioPlayerSectionState();
}

class _AudioPlayerSectionState extends State<AudioPlayerSection>
    with WidgetsBindingObserver {
  final ItemScrollController _scrollController = ItemScrollController();
  ValueNotifier<bool> isPlaying = ValueNotifier(false);

  late AudioPlayer _audioPlayer;
  // Duration duration = Duration.zero;
  // Duration position = Duration.zero;
  ValueNotifier<Duration> dur = ValueNotifier(Duration.zero);
  ValueNotifier<Duration> pos = ValueNotifier(Duration.zero);

  ValueNotifier<String?> currentUrl = ValueNotifier(null);

  ValueNotifier<String?> currentAudio = ValueNotifier(null);
  ValueNotifier<String?> currentThumbnail = ValueNotifier(null);

  _play(String url, String title, String thumbnail) async {
    if (url != currentUrl.value) {
      _audioPlayer.pause();

      await _audioPlayer.play(UrlSource(url));

      currentUrl.value = url;
      currentAudio.value = title;
      currentThumbnail.value = thumbnail;
    }
  }

  @override
  void initState() {
    _audioPlayer = AudioPlayer(
      playerId: widget.audios[0].id.toString(),
    );

    _audioPlayer.onPlayerStateChanged.listen((event) {
      isPlaying.value = event == PlayerState.playing;
    });
    _audioPlayer.onDurationChanged.listen((event) {
      dur.value = event;
    });
    _audioPlayer.onPositionChanged.listen((event) {
      pos.value = event;
    });
    WidgetsBinding.instance!.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();

    WidgetsBinding.instance!.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _audioPlayer.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return VisibilityDetector(
      key: ValueKey('AudioWidgetKey'),
      onVisibilityChanged: (visibilityInfo) {
        var visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage < 100.0) {
          if (isPlaying.value) {
            _audioPlayer.pause();
          }
        }

        debugPrint(
            'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: defaultPadding.copyWith(top: 15.h),
            child: Text(
              'Other Week Audio',
              style: theme.textTheme.labelMedium,
            ),
          ),
          Expanded(
            child: ScrollablePositionedList.builder(
                itemScrollController: _scrollController,
                padding: defaultPadding.copyWith(
                  top: 15.h,
                  bottom: 15.h,
                ),
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                      onTap: () {
                        _play(
                          widget.audios[index].path,
                          widget.audios[index].titleEn,
                          widget.audios[index].thumbnail,
                        );
                        _scrollController.scrollTo(
                            index: index, duration: Duration(seconds: 1));
                      },
                      child: ValueListenableBuilder(
                          valueListenable: currentUrl,
                          builder: (context, b, bb) {
                            return AudioContainerWidget(
                              isPlaying: currentUrl.value == null
                                  ? false
                                  : widget.audios[index].path ==
                                      currentUrl.value,
                              audio: widget.audios[index],
                            );
                          }),
                    ),
                  );
                }),
                // separatorBuilder: (ctx, ind) => VerticalSpace(20.h),
                itemCount: widget.audios.length),
          ),
          ValueListenableBuilder(
              valueListenable: currentUrl,
              builder: (context, v, b) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 1000),
                  child: currentUrl.value == null
                      ? GestureDetector(
                          onVerticalDragStart: ((details) {
                            _play(
                              widget.audios[0].path,
                              widget.audios[0].titleEn,
                              widget.audios[0].thumbnail,
                            );
                          }),
                          child: Container(
                            height: 60.h,
                            color: Colors.transparent.withOpacity(0.1),
                            key: ValueKey('switchAnimation1'),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Colors.transparent.withOpacity(0.1),
                                    Colors.red.withOpacity(0.1)
                                  ]),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30.w))),
                          key: ValueKey('switchAnimation2'),
                          // curve: Curves.fastOutSlowIn,
                          // duration: Duration(seconds: 1),

                          height: 170.h,
                          width: double.infinity,
                          padding: defaultPadding.copyWith(top: 15, bottom: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ValueListenableBuilder(
                                  valueListenable: currentThumbnail,
                                  builder: (context, snapshot, c) {
                                    print(currentThumbnail.toString() + 'ads');
                                    return Container(
                                      height: 50.h,
                                      width: 50.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(17),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  currentThumbnail.value ??
                                                      widget.audios[0]
                                                          .thumbnail))),
                                    );
                                  }),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ValueListenableBuilder(
                                      valueListenable: currentAudio,
                                      builder: (context, obj, wi) {
                                        return Padding(
                                          padding: defaultPadding,
                                          child: Text(currentAudio.value ??
                                              widget.audios[0].titleEn),
                                        );
                                      }),
                                  VerticalSpace(10.h),
                                  ValueListenableBuilder(
                                      valueListenable: dur,
                                      builder: (c, cc, ccc) {
                                        print(dur.value.toString() + "dffd");
                                        return ValueListenableBuilder(
                                            valueListenable: pos,
                                            builder: (context, c, g) {
                                              return Slider.adaptive(
                                                activeColor:
                                                    AppColors.primaryRed,
                                                inactiveColor: Colors.white,
                                                max: dur.value.inSeconds
                                                    .toDouble(),
                                                min: 0,
                                                value: pos.value.inSeconds
                                                    .toDouble(),
                                                onChanged:
                                                    (double value) async {
                                                  final position = Duration(
                                                      seconds: value.toInt());
                                                  await _audioPlayer
                                                      .seek(position);
                                                },
                                              );
                                            });
                                      }),
                                  ValueListenableBuilder(
                                      valueListenable: dur,
                                      builder: (context, f, ff) {
                                        return ValueListenableBuilder(
                                            valueListenable: pos,
                                            builder: (context, f, ff) {
                                              return Row(
                                                children: [
                                                  Text(
                                                    formatTime(
                                                      pos.value,
                                                    ),
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                  HorizSpace(95.w),
                                                  Text(
                                                    formatTime(
                                                        dur.value - pos.value),
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  )
                                                ],
                                              );
                                            });
                                      }),
                                ],
                              ),
                              Spacer(),
                              ValueListenableBuilder<bool>(
                                  valueListenable: isPlaying,
                                  builder: (context, s, c) {
                                    return IconButton(
                                        padding: EdgeInsets.only(right: 10),
                                        onPressed: () async {
                                          if (isPlaying.value) {
                                            await _audioPlayer.pause();
                                          } else {
                                            await _audioPlayer.resume();
                                          }
                                        },
                                        icon: Icon(
                                          isPlaying.value
                                              ? Icons.pause_circle_filled
                                              : Icons.play_circle,
                                          size: 50.sm,
                                          color: Colors.grey,
                                        ));
                                  }),
                            ],
                          ),
                        ),
                );
              }),
        ],
      ),
    );
  }
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));

  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return [if (duration.inHours > 0) hours, minutes, seconds].join(":");
}
