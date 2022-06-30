import 'package:aamako_maya/src/features/video/model/video_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoChangeCubit extends Cubit<VideoModel?> {
  VideoChangeCubit() : super(null);

  void selectVideo(VideoModel value) {
    emit(value);
  }
}
