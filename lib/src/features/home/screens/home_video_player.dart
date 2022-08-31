import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomeVideoPlayer extends StatefulWidget {
  final String selectedUrl;
  const HomeVideoPlayer(this.selectedUrl, {Key? key}) : super(key: key);

  @override
  State<HomeVideoPlayer> createState() => _HomeVideoPlayerState();
}

class _HomeVideoPlayerState extends State<HomeVideoPlayer> {
  late FlickManager flickManager;

  @override
  void initState() {
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        widget.selectedUrl,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: VisibilityDetector(
          key: ObjectKey(flickManager),
          onVisibilityChanged: (visibility) {
            if (visibility.visibleFraction == 0 && mounted) {
              flickManager.flickControlManager?.autoPause();
            } else if (visibility.visibleFraction == 1) {
              flickManager.flickControlManager?.autoResume();
            }
          },
          child: FlickVideoPlayer(
            flickManager: flickManager,
            flickVideoWithControls: const FlickVideoWithControls(
              closedCaptionTextStyle: TextStyle(fontSize: 8),
              controls: FlickPortraitControls(),
            ),
            flickVideoWithControlsFullscreen: const FlickVideoWithControls(
              controls: FlickLandscapeControls(),
            ),
          ),
        ),
      ),
    );
  }
}
