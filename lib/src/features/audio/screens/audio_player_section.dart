
import 'package:audioplayers/audioplayers.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../injection_container.dart';
import '../../../../l10n/locale_keys.g.dart';
import '../../../core/connection_checker/network_connection.dart';
import '../../../core/padding/padding.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/drawer/drawer_widget.dart';
import '../../../core/widgets/helper_widgets/blank_space.dart';
import '../../fetch user data/cubit/get_user_cubit.dart';
import '../cubit/audio_cubit.dart';
import '../model/audio_model.dart';
import '../widgets/audio_container_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AudioPlayerSection extends StatefulWidget {
  final List<AudioModel> audios;
  final bool isEnglish;

  const AudioPlayerSection(
      {Key? key, required this.audios, required this.isEnglish})
      : super(key: key);

  @override
  State<AudioPlayerSection> createState() => _AudioPlayerSectionState();
}

class _AudioPlayerSectionState extends State<AudioPlayerSection>
    with WidgetsBindingObserver {
  final ItemScrollController _scrollController = ItemScrollController();
  ValueNotifier<bool> isPlaying = ValueNotifier(false);

  late AudioPlayer _audioPlayer;

  ValueNotifier<Duration> dur = ValueNotifier(Duration.zero);
  ValueNotifier<Duration> pos = ValueNotifier(Duration.zero);

  ValueNotifier<String?> currentUrl = ValueNotifier(null);

  ValueNotifier<String?> currentAudio = ValueNotifier(null);
  ValueNotifier<String?> currentThumbnail = ValueNotifier(null);

  _play(String url, String title, String thumbnail) async {
    if (url != currentUrl.value) {
      _audioPlayer.pause();
      try {
        await _audioPlayer.play(UrlSource(url));
        currentUrl.value = url;
        currentAudio.value = title;
        currentThumbnail.value = thumbnail;
      } catch (e) {
        _audioPlayer.pause();
        currentUrl.value = null ;
        BotToast.showText(text: 'Cannot Play Audio');
      }


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
    _audioPlayer.onPlayerComplete.listen((event) {
      _audioPlayer.stop();
      currentUrl.value = null ;
    });
    _audioPlayer.onDurationChanged.listen((event) {
      dur.value = event;
    });
    _audioPlayer.onPositionChanged.listen((event) {
      pos.value = event;
    });
    WidgetsBinding.instance?.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    currentUrl.value = null ;
    WidgetsBinding.instance?.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _audioPlayer.stop();
      currentUrl.value = null ;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return VisibilityDetector(
      key: const ValueKey('AudioWidgetKey'),
      onVisibilityChanged: (visibilityInfo) {
        var visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage < 100.0) {
          if (isPlaying.value) {
            _audioPlayer.pause();
            currentUrl.value = null ;
          }
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<GetUserCubit, GetUserState>(
              builder: (userCtx, userState) {
            String weeks = '';
            String day = '';
            String days = '';
            if (userState is GetUserSuccess) {
              final date = DateTime.parse(userState.user.lmpDateNp ?? '');

              DateTime earlier = DateTime.utc(date.year, date.month, date.day);
              final later = DateTime.utc(NepaliDateTime.now().year,
                  NepaliDateTime.now().month, NepaliDateTime.now().day);
              day = differenceInCalendarDays(later, earlier).toString();

              weeks = ((int.parse(day) % 365) / 7).toStringAsFixed(0);
              days =( (int.parse(day) % 365) % 7 ).toString();
            }
            final thisWeek = widget.audios.firstWhere(
                (element) => (element.weekId) == int.parse(weeks),
                orElse: () => AudioModel(
                    id: 0,
                    titleEn: '',
                    titleNp: '',
                    thumbnail: '',
                    path: '',
                    weekId: 0,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now()));

            return Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: defaultPadding.copyWith(top: 15.h),
                    child: Text(
                      LocaleKeys.label_this_week_audio.tr(),
                      style: theme.textTheme.labelMedium,
                    ),
                  ),
                ),
                VerticalSpace(10.h),
                Align(
                  alignment: Alignment.center,
                  child: thisWeek.id != 0
                      ? GestureDetector(
                          onTap: () async {
                            _play(
                              thisWeek.path,
                              thisWeek.titleEn,
                              thisWeek.thumbnail,
                            );
                          },
                          child: ValueListenableBuilder(
                              valueListenable: currentUrl,
                              builder: (context, b, bb) {
                                return Padding(
                                  padding: defaultPadding,
                                  child: AudioContainerWidget(
                                    isEnglish: widget.isEnglish,
                                    isPlaying: currentUrl.value == null
                                        ? false
                                        : thisWeek.path == currentUrl.value,
                                    audio: thisWeek,
                                  ),
                                );
                              }),
                        )
                      : Center(
                          child: Text(
                            "No Audio Found",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: defaultPadding.copyWith(top: 15.h),
                    child: Text(
                      LocaleKeys.label_other_week_audio.tr(),
                      style: theme.textTheme.labelMedium,
                    ),
                  ),
                ),
              ],
            );
          }),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                if (await sl<NetworkInfo>().isConnected) {
                  context.read<AudioCubit>().getAudio(true);
                } else {
                  BotToast.showText(
                      text: LocaleKeys.no_internet_connection.tr());
                }
              },
              child: ScrollablePositionedList.builder(
                  itemScrollController: _scrollController,
                  padding: defaultPadding.copyWith(
                    top: 15.h,
                    bottom: 15.h,
                  ),
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: REdgeInsets.symmetric(vertical: 10),
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
                                isEnglish: widget.isEnglish,
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
          ),
          SizedBox(height: 10.h),
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
                            height: 0.h,
                            color: Colors.transparent.withOpacity(0.1),
                            key: const ValueKey('switchAnimation1'),
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
                          key: const ValueKey('switchAnimation2'),
                          // curve: Curves.fastOutSlowIn,
                          // duration: Duration(seconds: 1),

                          width: double.infinity,
                          padding:
                              defaultPadding.copyWith(top: 10.h, bottom: 30.h),
                          child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.topRight,
                                  child:  InkWell(
                                    onTap: () {
                                      _audioPlayer.stop();
                                      currentUrl.value = null;
                                    },
                                    child: Icon(Icons.cancel,
                                        color: AppColors.accentGrey,
                                        size: 30.r),
                                  )),
                              SizedBox(height: 10.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ValueListenableBuilder(
                                      valueListenable: currentThumbnail,
                                      builder: (context, snapshot, c) {
                                        print(currentThumbnail.toString() +
                                            'ads');
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          child: SizedBox(
                                            height: 70.h,
                                            width: 70.h,
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: currentThumbnail
                                                      .value ??
                                                  widget.audios[0].thumbnail,
                                              placeholder: (ctx, url) =>
                                                  Container(
                                                height: 100.h,
                                                width: 100.h,
                                                color: AppColors.accentGrey,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                        );
                                      }),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      Row(
                                        children: [
                                          ValueListenableBuilder(
                                              valueListenable: dur,
                                              builder: (c, cc, ccc) {
                                                print(
                                                    dur.value.toString() + "dffd");
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
                                                              seconds:
                                                                  value.toInt());
                                                          await _audioPlayer
                                                              .seek(position);
                                                        },
                                                      );
                                                    });
                                              }),
                                          ValueListenableBuilder<bool>(
                                              valueListenable: isPlaying,
                                              builder: (context, s, c) {
                                                return IconButton(
                                                    padding:
                                                    REdgeInsets.only(right: 10),
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
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      HorizSpace(95.w),
                                                      Text(
                                                        formatTime(dur.value -
                                                            pos.value),
                                                        style: TextStyle(
                                                            fontSize: 12.sm),
                                                      )
                                                    ],
                                                  );
                                                });
                                          }),
                                    ],
                                  ),

                                ],
                              ),
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
