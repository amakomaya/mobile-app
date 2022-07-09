import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/core/widgets/scaffold/primary_scaffold.dart';
import 'package:aamako_maya/src/features/audio/cubit/audio_cubit.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/audio_container_widget.dart';
import 'audio_player_section.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({Key? key}) : super(key: key);

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  @override
  void initState() {
    context.read<AudioCubit>().getAudio();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
        appBartitle: 'Audio',
        body:  BlocConsumer<AudioCubit, AudioState>(
              listener: (ctx, st) {
                if (st.error != null) {
                  BotToast.showText(
                      text:
                          'There was an error fetching audio at the moment');
                }
              },
              builder: (ctx, st) {
                return st.audioModel == null
                    ? ShimmerLoading(
                        boxHeight: 45.h,
                        itemCount: 10,
                        inBetweenSpace: 20.h,
                      )
                    : AudioPlayerSection(
                      audios: st.audioModel??[],
                    );
              },
            ),);
  }
}
