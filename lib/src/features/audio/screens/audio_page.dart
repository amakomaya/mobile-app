import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/features/audio/cubit/audio_cubit.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../injection_container.dart';
import '../../../core/connection_checker/network_connection.dart';
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
    context.read<AudioCubit>().getAudio(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AudioCubit, AudioState>(
      listener: (ctx, st) {
        if(st is AudioSuccessState&& st.isRefreshed){
          BotToast.showText(text: 'Audio Successfully fetched');
        }
      },
      builder: (ctx, st) {
         final bool isEnglish =
            EasyLocalization.of(context)?.currentLocale?.languageCode == 'en';

        if (st is AudioSuccessState) {
          return AudioPlayerSection(
            isEnglish:isEnglish,
            audios: st.data,
          );
        } else if (st is AudioLoadingState) {
          return ShimmerLoading(
            boxHeight: 45.h,
            itemCount: 10,
            inBetweenSpace: 18.h,
          );
        }else{
         return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Something Went Wrong!"),
              IconButton(
                  onPressed: () async {
                    if (await sl<NetworkInfo>().isConnected) {
                      context.read<AudioCubit>().getAudio(true);
                    } else {
                      BotToast.showText(text: 'No Internet Connection !');
                    }
                  },
                  icon: Icon(
                    Icons.refresh,
                    size: 22.sm,
                    color: Colors.black,
                  ))
            ],);
        }
      },
    );
  }
}
