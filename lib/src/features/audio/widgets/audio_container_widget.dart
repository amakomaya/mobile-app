
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../../core/app_assets/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/helper_widgets/blank_space.dart';
import '../../../core/widgets/helper_widgets/shadow_container.dart';
import '../model/audio_model.dart';

class AudioContainerWidget extends StatelessWidget {
  final AudioModel audio;
  final bool isPlaying;
  final bool isEnglish;
  const AudioContainerWidget({
    Key? key,
    required this.audio,
    required this.isPlaying, required this.isEnglish,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ShadowContainer(
      gradient:isPlaying? LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.white.withOpacity(0.6),
            Colors.red.withOpacity(0.4)
          ]) : null,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      radius: 25,
      color: Colors.white,
      child: Row(children: [
        Image.asset(AppAssets.musicIcon),
        Expanded(
            child: Text(
          isEnglish?audio.titleEn:audio.titleNp,
          style: theme.textTheme.labelSmall,
        )),
        Visibility(
            visible: isPlaying,
            child: Row(
              children: [
                // Text('Playing..',   style: theme.textTheme.labelSmall?.copyWith(
                //   color: AppColors.primaryRed
                // ),),
                AnimatedTextKit(repeatForever: true, animatedTexts: [
                  TyperAnimatedText('Playing...',
                      textStyle: theme.textTheme.labelSmall
                          ?.copyWith(color: AppColors.white))
                ]),
                HorizSpace(5.w),
                Icon(
                  Icons.multitrack_audio_rounded,
                  color: AppColors.white,
                )
              ],
            ))
      ]),
    );
  }
}
