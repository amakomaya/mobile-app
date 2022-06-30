part of 'video_cubit.dart';

@freezed
class VideoState with _$VideoState {
  const factory VideoState.initial({
    @Default(false) bool isLoading,
    String? error,
  }) = _Initial;
  const factory VideoState.success(
      {@Default(false) bool isLoading,
      String? error,
      required List<VideoModel> videos}) = _Success;
}
