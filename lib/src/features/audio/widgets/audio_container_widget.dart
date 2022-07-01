import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/features/audio/model/audio_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_assets/app_assets.dart';
import '../../../core/widgets/helper_widgets/shadow_container.dart';

class AudioContainerWidget extends StatelessWidget {
  final AudioModel audio;
  const AudioContainerWidget({Key? key, required this.audio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ShadowContainer(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      radius: 25,
      color: Colors.white,
      child: Row(children: [
        Image.asset(AppAssets.musicIcon),
         Expanded(child: Text(audio.titleEn,style: theme.textTheme.labelSmall,))
      ]),
    );
  }
}
