import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/features/faqs/cubit/faqs_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FaqsPage extends StatefulWidget {
  const FaqsPage({Key? key}) : super(key: key);

  @override
  State<FaqsPage> createState() => _FaqsPageState();
}

class _FaqsPageState extends State<FaqsPage> {
  @override
  void initState() {
    context.read<FaqsCubit>().getfaqs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return BlocBuilder<FaqsCubit, FaqsState>(
      builder: (context, state) {
        if (state.faqs == null) {
          return ShimmerLoading(boxHeight: 200.h, itemCount: 4);
        } else if (state.faqs?.isEmpty ?? false) {
          return const Text('NO PNC REPORTS FOUND');
        } else {
          return ListView.separated(
              itemBuilder: ((context, index) {
                return Container(
                  margin: const EdgeInsets.only(left: 18, right: 18),
                  child: Column(
                    children: [
                      // Text("Faqs Report${index + 1}".toUpperCase(),
                      //     style: const TextStyle(
                      //         fontFamily: "lato",
                      //         color: AppColors.primaryRed,
                      //         fontSize: 17)),
                      VerticalSpace(12.h),
                      ShadowContainer(
                        radius: 20,
                        width: 380.w,
                        color: Colors.white,
                        padding: defaultPadding.copyWith(top: 10, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.faqs?[index].question.toString() ?? '',
                              style: const TextStyle(
                                  fontFamily: "lato",
                                  color: AppColors.primaryRed,
                                  fontSize: 17),
                            ),
                            Divider(),

                            Text(
                              state.faqs?[index].answer ?? '',
                              style: theme.textTheme.labelSmall,
                            )

                            // ListTile(
                            //   leading: Text(
                            //       state.faqs?[index].question
                            //               .toString() ??
                            //           '',
                            //       style: theme.textTheme.labelSmall),
                            // ),
                          ],
                        ),
                      ),
                      VerticalSpace(15.h),
                    ],
                  ),
                );
              }),
              separatorBuilder: (ctx, index) {
                return const Divider(
                  color: AppColors.white,
                );
              },
              itemCount: state.faqs?.length ?? 0);
        }
      },
    );
  }
}
