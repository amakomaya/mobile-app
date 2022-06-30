import 'package:aamako_maya/src/features/video/model/video_model.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class VideoPlayingContainerWidget extends StatefulWidget {
 final VideoModel videoModel;
 final BetterPlayerController betterPlayerController;
   const VideoPlayingContainerWidget({Key? key,required this.videoModel, required  this.betterPlayerController,}) : super(key: key);

  @override
  State<VideoPlayingContainerWidget> createState() =>
      _VideoPlayingContainerWidgetState();
}

class _VideoPlayingContainerWidgetState
    extends State<VideoPlayingContainerWidget> {
  // late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    // BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
    //     BetterPlayerDataSourceType.network,
    //     widget.urlWalavideo.path);
    // _betterPlayerController = BetterPlayerController(
    //     const BetterPlayerConfiguration(),
    //     betterPlayerDataSource:
    //         betterPlayerDataSource); 
    super.initState();
  }

  @override
  void dispose() {
    widget.betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    return ClipRRect(
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
