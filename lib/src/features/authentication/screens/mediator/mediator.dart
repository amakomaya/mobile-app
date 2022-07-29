// import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
// import 'package:aamako_maya/src/features/bottom_nav/bottom_navigation.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../audio/repository/audio_repository.dart';
// import '../../../weekly_tips/repository/weekly_tips_repository.dart';
// import '../../get_all_data/cubit/fetch_all_data_cubit.dart';

// class MediatorPage extends StatelessWidget {
//   const MediatorPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => FetchAllDataCubit(
//           repo: WeeklyTipsRepo(Dio()), audioRepo: AudioRepositories(Dio()))
//         ..fetchAllData(),
//       child: SafeArea(
//         child: Scaffold(
//           body: BlocConsumer<FetchAllDataCubit, FetchAllDataState>(
//             listener: (context, state) {
//               if (state is FetchAllDataLoaded) {
//                 Navigator.of(context).pushAndRemoveUntil(
//                     MaterialPageRoute(
//                         builder: (ctx) => const CustomBottomNavigation()),
//                     (route) => false);
//               }
//             },
//             builder: (context, state) {
//               return Center(
//                   child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   const Align(
//                       alignment: Alignment.center,
//                       child: CircularProgressIndicator()),
//                   VerticalSpace(30.h),
//                   Text(
//                     'Fetching all data...',
//                     style: Theme.of(context).textTheme.labelMedium,
//                   ),
//                   VerticalSpace(30.h),
//                   Text(
//                     'This might take a few minutes...',
//                     style: Theme.of(context).textTheme.labelMedium,
//                   )
//                 ],
//               ));
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
