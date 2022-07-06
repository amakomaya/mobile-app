import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/scaffold/primary_scaffold.dart';
import 'package:aamako_maya/src/features/weekly_tips/cubit/weekly_tips_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../core/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class WeeklyTipsPage extends StatefulWidget {
  const WeeklyTipsPage({Key? key}) : super(key: key);

  @override
  State<WeeklyTipsPage> createState() => _WeeklyTipsPageState();
}

class _WeeklyTipsPageState extends State<WeeklyTipsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PrimaryScaffold(
        appBartitle: 'Weekly Tips',
        body: BlocConsumer<WeeklyTipsCubit, WeeklyTipsState>(
          listener: (context, state) {
            // TODO: implement listener
          },

//           Html(
//   data: """<div>
//         <h1>Demo Page</h1>
//         <p>This is a fantastic product that you should buy!</p>
//         <h3>Features</h3>
//         <ul>
//           <li>It actually works</li>
//           <li>It exists</li>
//           <li>It doesn't cost much!</li>
//         </ul>
//         <!--You can pretty much put any html in here!-->
//       </div>""",
// );
          builder: (context, state) {
            return state.maybeWhen(
                orElse: () => const Center(
                      child: Text('Could not load!'),
                    ),
                initial: (isLoading, error) => Shimmer.fromColors(
                      baseColor: Colors.grey[200]!,
                      highlightColor: Colors.white,
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: defaultPadding.copyWith(top: 20, bottom: 20),
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: SizedBox(
                              height: 400.h,
                            ),
                          );
                        },
                      ),
                    ),
                success: (loading, error, data) {
                  return SingleChildScrollView(
                      primary: true,
                      physics: const BouncingScrollPhysics(),
                      padding: defaultPadding.copyWith(top: 20.h, bottom: 20.h),
                      child: ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(data[index].titleEn,
                                //     style: theme.textTheme.headlineMedium),
                                VerticalSpace(20.h),
                                ShadowContainer(
                                  radius: 30,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data[index].titleEn,
                                          style: theme.textTheme.labelMedium),
                                      Divider(
                                        height: 15.w,
                                        color: AppColors.accentGrey,
                                      ),
                                      Html(
                                        data: data[index].descriptionEn,
                                      )
                                    ],
                                  ),
                                ),

                                // Text(
                                //   'Other Week Information',
                                //   style: theme.textTheme.headlineMedium,
                                // ),
                                // VerticalSpace(20.h),
                                // ShadowContainer(
                                //   radius: 30,
                                //   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20),
                                //   child: Column(
                                //     crossAxisAlignment: CrossAxisAlignment.start,
                                //     children: [
                                //       Text('Special consideration:',
                                //           style: theme.textTheme.labelMedium),
                                //       Divider(
                                //         height: 15.w,
                                //         color: AppColors.accentGrey,
                                //       ),
                                //       Text(
                                //         "It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.",
                                //         style: theme.textTheme.labelSmall,
                                //         textAlign: TextAlign.left,
                                //       )
                                //     ],
                                //   ),
                                // ),
                                // VerticalSpace(30.h),
                                // ShadowContainer(
                                //   radius: 30,
                                //   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20),
                                //   child: Column(
                                //     crossAxisAlignment: CrossAxisAlignment.start,
                                //     children: [
                                //       Text('Special consideration:',
                                //           style: theme.textTheme.labelMedium),
                                //       Divider(
                                //         height: 15.w,
                                //         color: AppColors.accentGrey,
                                //       ),
                                //       Text(
                                //         "It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.",
                                //         style: theme.textTheme.labelSmall,
                                //         textAlign: TextAlign.left,
                                //       )
                                //     ],
                                //   ),
                                // ),
                              ],
                            );
                          },
                          separatorBuilder: (ctx, index) => VerticalSpace(20.h),
                          itemCount: data.length));
                });
          },
        ));
  }
}
