import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/features/audio/model/audio_model.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AudioPlayerWidget extends StatefulWidget {
  final AudioModel? audio;
  const AudioPlayerWidget({Key? key, this.audio}) : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget>
    with WidgetsBindingObserver {
  late AudioPlayer _audioPlayer;

  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying = false;

  _play() async {
    await _audioPlayer.play(UrlSource(widget.audio?.path ?? ""));
  }

  @override
  void initState() {
    _audioPlayer = AudioPlayer(playerId: widget.audio?.id.toString());

    _play();
    _audioPlayer.onPlayerStateChanged.listen((event) {
      // setState(() {
      isPlaying = event == PlayerState.playing;
      // });
    });

    _audioPlayer.onDurationChanged.listen((event) {
      // setState(() {
      duration = event;
      // });
    });

    _audioPlayer.onPositionChanged.listen((event) {
      // setState(() {
      position = event;
      // });s
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
    return Scaffold(
        body: Padding(
      padding: defaultPadding,
      child: Column(
        children: [
          Image.network(
            widget.audio?.thumbnail ?? '',
            height: 200.h,
            width: 185.w,
            errorBuilder: ((context, error, stackTrace) =>
                const Icon(Icons.image_not_supported)),
          ),
          Slider(
            activeColor: Colors.red,
            inactiveColor: Colors.amber,
            min: 0,
            max: duration.inSeconds.toDouble(),
            onChanged: (double value) async {
              final position = Duration(seconds: value.toInt());
              await _audioPlayer.seek(position);
            },
            value: position.inSeconds.toDouble(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(formatTime(position)),
              Text(formatTime(duration - position))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () async {
                    await _audioPlayer.seek(position - Duration(seconds: 10));
                  },
                  icon: Icon(
                    Icons.skip_previous,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: () async {
                    if (isPlaying) {
                      await _audioPlayer.pause();
                    } else {
                      await _audioPlayer.resume();
                    }
                  },
                  icon: Icon(
                    isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_arrow_rounded,
                    size: 40,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: () async {
                    await _audioPlayer.seek(position + Duration(seconds: 10));
                  },
                  icon: Icon(
                    Icons.skip_next,
                    color: Colors.black,
                  )),
            ],
          )
        ],
      ),
    ));
  }
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));

  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return [if (duration.inHours > 0) hours, minutes, seconds].join(":");
}
