import 'dart:typed_data';

import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/buttons/primary_action_button.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:audioplayers/audioplayers.dart';

class SirenPage extends StatefulWidget {
  const SirenPage({Key? key}) : super(key: key);

  @override
  State<SirenPage> createState() => _SirenPageState();
}

class _SirenPageState extends State<SirenPage> {
  late AudioPlayer advancedPlayer;
  late AudioCache audioCache;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    advancedPlayer = AudioPlayer();
   
  }

  @override
  void dispose() {
    advancedPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: defaultPadding.copyWith(bottom: 27.h, top: 27.h),
      child: Column(
        children: [
          const Expanded(
            child: Image(
                image: AssetImage(
              "assets/images/siren_image.png",
            )),
          ),
          PrimaryActionButton(
            radius: 10,
            width: 380.w,
            onpress: () async {
              final player = AudioCache(prefix: 'assets/');
              final url = await player.load('siren.mp3');
              if (isPlaying==true) {
                advancedPlayer.pause();
                isPlaying=false;
              } else {
                advancedPlayer.play(UrlSource(url.path));
                isPlaying=true;
              }
            },
            title: '',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.emergency_outlined),
                HorizSpace(5.w),
                Text(
                  'Siren',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      ?.copyWith(color: AppColors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
