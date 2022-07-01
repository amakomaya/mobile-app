import 'dart:async';

import 'package:aamako_maya/src/features/video/model/video_model.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoChangeCubit extends Cubit<VideoChangeState> {
  VideoChangeCubit() : super(VideoChangeState());

  void selectVideo({required VideoModel value, required BetterPlayerController betterPlayerController}) async{
     emit(VideoChangeState(
        betterPlayerController: state.betterPlayerController,
        videoModel: state.videoModel,
      ));
    if(state.betterPlayerController != null){  
    
    //  state.betterPlayerController?.pause();
      state.betterPlayerController?.dispose(forceDispose: true);
      // state.betterPlayerController?.videoPlayerController?.dispose();
      emit(VideoChangeState(
        betterPlayerController: state.betterPlayerController,
        videoModel: state.videoModel,
      ));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(VideoChangeState(
        betterPlayerController: betterPlayerController,
        videoModel: value,
      ));
    }else{
      emit(VideoChangeState(
        betterPlayerController: betterPlayerController,
        videoModel: value,
      ));
    }
  }
}

class VideoChangeState{
  final VideoModel? videoModel;
  final BetterPlayerController? betterPlayerController;

  VideoChangeState({this.videoModel, this.betterPlayerController});
}
