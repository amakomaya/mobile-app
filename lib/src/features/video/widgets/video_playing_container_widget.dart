import 'package:aamako_maya/src/features/video/model/video_model.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoPlayingContainerWidget extends StatefulWidget {
  final VideoModel videoModel;
  final BetterPlayerController betterPlayerController;
  const VideoPlayingContainerWidget({
    Key? key,
    required this.videoModel,
    required this.betterPlayerController,
  }) : super(key: key);

  @override
  State<VideoPlayingContainerWidget> createState() =>
      _VideoPlayingContainerWidgetState();
}

class _VideoPlayingContainerWidgetState
    extends State<VideoPlayingContainerWidget> {
 

  @override
  Widget build(BuildContext context) {
    return 
    
     ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: AspectRatio(
        aspectRatio: 16 / 9,

        child: BetterPlayer(
          controller: widget.betterPlayerController,
        ),
       
      ),
    );
  }
}
