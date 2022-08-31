import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/features/video/model/video_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/widgets/helper_widgets/blank_space.dart';
import '../../../core/widgets/helper_widgets/shadow_container.dart';
import '../../audio/screens/audio_player_section.dart';

class VideoPlayingPage extends StatefulWidget {
  final List<VideoModel> list;
  final VideoModel selected;
  final int initialScroll;
  const VideoPlayingPage(this.list, this.selected, this.initialScroll, {Key? key})
      : super(key: key);

  @override
  State<VideoPlayingPage> createState() => _VideoPlayingPageState();
}

class _VideoPlayingPageState extends State<VideoPlayingPage> {
  final ItemScrollController _scrollController = ItemScrollController();

  late FlickManager flickManager;
  late VideoModel currentVideo;
 
  changevideo(VideoModel video) async {
    if (currentVideo.path != video.path) {
    
      currentVideo=video;
      await flickManager.handleChangeVideo(
        VideoPlayerController.network(
          currentVideo.path,
        ),
      );
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      setState(() {
        _scrollController.scrollTo(
            index: widget.initialScroll, duration: const Duration(seconds: 1));
      });
    });
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        widget.selected.path,
      ),
    );

    currentVideo=widget.selected;

    super.initState();
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
          VisibilityDetector(
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
          
          
          ExpansionTile(
            iconColor: AppColors.accentGrey,
            collapsedIconColor: AppColors.accentGrey,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            expandedAlignment: Alignment.centerLeft,
            initiallyExpanded: false,
            title: Text(currentVideo.titleNp,
                style: theme.textTheme.titleSmall?.copyWith(
                    fontSize: 18.sm,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            children: [
              Html(
                data: currentVideo.descriptionNp,
              ),
            ],
          ),
          Expanded(
            child: ScrollablePositionedList.builder(
                shrinkWrap: true,
                itemScrollController: _scrollController,
                itemCount: widget.list.length,
                itemBuilder: (ctx, ind) {
                  return InkWell(
                    onTap: () async {
                      changevideo(widget.list[ind]);
                      setState(() {});
 
                      _scrollController.scrollTo(
                          index: ind, duration: const Duration(seconds: 1));
                    },
                    child: ShadowContainer(
                      color: currentVideo.path == widget.list[ind].path
                          ? AppColors.grey
                          : null,
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 100.w,
                            height: 100.h,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: widget.list[ind].thumbnail,
                              placeholder: (ctx, url) => Container(
                                height: 100.h,
                                width: 100.w,
                                color: AppColors.accentGrey,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          HorizSpace(10.w),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Html(data: widget.list[ind].titleEn),
                                Html(data: widget.list[ind].descriptionEn)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      )),
    );
  }
}
