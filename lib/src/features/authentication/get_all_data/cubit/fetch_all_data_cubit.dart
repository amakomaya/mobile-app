// import 'package:aamako_maya/src/features/audio/model/audio_model.dart';
// import 'package:aamako_maya/src/features/weekly_tips/model/weekly_tips_model.dart';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// import '../../../audio/repository/audio_repository.dart';
// import '../../../video/repository/videoes_repository.dart';
// import '../../../weekly_tips/repository/weekly_tips_repository.dart';

// class FetchAllDataCubit extends Cubit<FetchAllDataState> {
//   final WeeklyTipsRepo tipsRepo;
//   final VideosRepo videoRepo;

//   final AudioRepositories audioRepo;

//   FetchAllDataCubit(
//       {required this.videoRepo,
//       required this.tipsRepo,
//       required this.audioRepo})
//       : super(FetchAllDataLoading());

//   void fetchAllData() async {
//     emit(FetchAllDataLoading());
//     try {
//       final tips = await tipsRepo.getWeeklyTips();
//       final audios = await audioRepo.getAudioList();
//       final videos = await videoRepo.getVideos();
//       emit(FetchAllDataLoaded(
//         audios: audios,
//         tips: tips,
//       ));
//     } catch (e) {
//       emit(FetchAllDataFailed('Error Fetching'));
//     }
//   }
// }

// class FetchAllDataState extends Equatable {
//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
// }

// class FetchAllDataLoading extends FetchAllDataState {}

// class FetchAllDataLoaded extends FetchAllDataState {
//   List<WeeklyTips>? tips;
//   List<AudioModel>? audios;

//   FetchAllDataLoaded({this.tips, this.audios});
// }

// class FetchAllDataFailed extends FetchAllDataState {
//   String error;
//   FetchAllDataFailed(this.error);
// }
