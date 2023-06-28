import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/helper_widgets/shadow_container.dart';

class HomeVideoPlayer extends StatefulWidget {
  final String selectedUrl;
  final String imageUrl;

  const HomeVideoPlayer(this.selectedUrl,this.imageUrl, {Key? key}) : super(key: key);

  @override
  State<HomeVideoPlayer> createState() => _HomeVideoPlayerState();
}

class _HomeVideoPlayerState extends State<HomeVideoPlayer> {
  FlickManager? flickManager;
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();

  }

  onPlayClick() {
    _videoPlayerController = VideoPlayerController.network(
      widget.selectedUrl,
    );
    flickManager = FlickManager(
      videoPlayerController:_videoPlayerController ,
    );
    _videoPlayerController.addListener(() {
        if (!_videoPlayerController.value.isPlaying && _videoPlayerController.value.isInitialized && (_videoPlayerController.value
                .duration ==
            _videoPlayerController.value
                    .position)) {
          flickManager = null ;
          setState(() {});
        }
        print("");
    });
  }

  @override
  void dispose() {
    flickManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return flickManager == null
        ? Container(
            margin: REdgeInsets.only(top: 0.h, left: 12, right: 12),
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl),
                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                  fit: BoxFit.cover,
                ),
                color: AppColors.black,
                borderRadius: BorderRadius.circular(20)),
            height: 120.h,
            child: InkWell(
                onTap: () {
                  onPlayClick();
                  setState(() {});
                },
                child: Center(child: Icon(Icons.play_circle_outlined, size: 40.sp,))),
          )
        : Padding(
          padding:REdgeInsets.only(top: 0.h, left: 12, right: 12),
          child: VisibilityDetector(
              key: ObjectKey(flickManager),
              onVisibilityChanged: (visibility) {
                flickManager?.flickControlManager?.autoPause();
                flickManager?.flickDisplayManager?.hidePlayerControls();
                if (visibility.visibleFraction == 0 && mounted) {
                  flickManager = null ;
                  setState(() {
                  });
                }
                else if (visibility.visibleFraction == 1) {
                  flickManager?.flickControlManager?.autoResume();
                }
              },
              child: FlickVideoPlayer(
                flickManager: flickManager!,
                flickVideoWithControls: const FlickVideoWithControls(
                  playerErrorFallback:
                      Center(child: Text("Error Playing the media")),
                  closedCaptionTextStyle: TextStyle(fontSize: 8),
                  controls: FlickPortraitControls(),
                ),
                flickVideoWithControlsFullscreen: const FlickVideoWithControls(
                  controls: FlickLandscapeControls(),
                ),
              ),
            ),
        );
  }
}
