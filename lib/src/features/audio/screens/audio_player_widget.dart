import 'package:aamako_maya/src/core/app_assets/app_assets.dart';
import 'package:aamako_maya/src/features/audio/model/audio_model.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AudioPlayerWidget extends StatefulWidget {
  final AudioModel? audio;
  const AudioPlayerWidget({Key? key,  this.audio}) : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _audioPlayer  ;

  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  // final PlayerState _playerState = PlayerState.stopped;
  // bool get _isPlaying => _playerState == PlayerState.playing;
  bool isPlaying = false;

  @override
  void initState() {
    _audioPlayer=AudioPlayer(playerId: widget.audio?.id.toString());
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Image.network(widget.audio?.thumbnail??'',
        height: 200.h,
        width: 185.w,
        errorBuilder: ((context, error, stackTrace) => Icon(Icons.image_not_supported)),
        ),
        Slider(
          min: 0,
          max: duration.inSeconds.toDouble(),
          onChanged: (double value) {},
          value: position.inSeconds.toDouble(),
        ),
        IconButton(
            onPressed: () async {
              setState(() {
                isPlaying = !isPlaying;
              });
              if (isPlaying) {
                await _audioPlayer.pause();
              } else {
                await _audioPlayer.play(UrlSource(widget.audio?.path??""));
              }
            },
            icon: Icon(
              isPlaying ? Icons.play_arrow_rounded : Icons.pause_circle_filled,
              color: Colors.red,
            ))
      ],
    ));
  }
}
