import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../injection_container.dart';
import '../../../../l10n/locale_keys.g.dart';
import '../../../core/connection_checker/network_connection.dart';
import '../../../core/widgets/loading_shimmer/shimmer_loading.dart';
import '../cubit/audio_cubit.dart';
import 'audio_player_section.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({Key? key}) : super(key: key);

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  checkInternet(BuildContext ctx) async {
    if (await sl<NetworkInfo>().isConnected) {
    } else {
      ctx.read<AudioCubit>().getAudio(false);
      BotToast.showText(
          text: LocaleKeys.no_internet_connection.tr());
    }
  }

  @override
  void initState() {
    // checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AudioCubit>()..getAudio(true),
      child: BlocConsumer<AudioCubit, AudioState>(
        listener: (ctx, st) {
          // if (st is AudioSuccessState && st.isRefreshed) {
          //   BotToast.showText(text: LocaleKeys.msg_audio_fetch_success.tr());
          // }
        },
        builder: (ctx, st) {
          checkInternet(ctx);
          final bool isEnglish =
              EasyLocalization
                  .of(context)
                  ?.currentLocale
                  ?.languageCode == 'en';
          if (st is AudioSuccessState) {
            return AudioPlayerSection(
              isEnglish: isEnglish,
              audios: st.data,
            );
          } else if (st is AudioLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          } else if( st is AudioFailureState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(LocaleKeys.error_msg_someting_went_wrong.tr()),
                IconButton(
                    onPressed: () async {
                      if (await sl<NetworkInfo>().isConnected) {
                        ctx.read<AudioCubit>().getAudio(true);
                      } else {
                        ctx.read<AudioCubit>().getAudio(false);

                        BotToast.showText(
                            text: LocaleKeys.no_internet_connection.tr());
                      }
                    },
                    icon: Icon(
                      Icons.refresh,
                      size: 22.sm,
                      color: Colors.black,
                    ))
              ],
            );
          }
          else{
            return SizedBox();
          }
        },
      ),
    );
  }
}
