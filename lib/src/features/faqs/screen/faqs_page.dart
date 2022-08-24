import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/features/faqs/cubit/faqs_cubit.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../injection_container.dart';
import '../../../core/connection_checker/network_connection.dart';

class FaqsPage extends StatefulWidget {
  const FaqsPage({Key? key}) : super(key: key);

  @override
  State<FaqsPage> createState() => _FaqsPageState();
}

class _FaqsPageState extends State<FaqsPage> {
  @override
  void initState() {
    context.read<FaqsCubit>().getfaqs(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<FaqsCubit, FaqsState>(
      builder: (context, state) {
        if (state is FaqLoadingState) {
          return ShimmerLoading(boxHeight: 200.h, itemCount: 4);
        } else if (state is FaqSuccessState) {
          return RefreshIndicator(
            onRefresh: () async {
              if (await sl<NetworkInfo>().isConnected) {
                context.read<FaqsCubit>().getfaqs(true);
              } else {
                BotToast.showText(text: 'No Internet Connection !');
              }
            },
            child: ListView.separated(
              padding: defaultPadding.copyWith(top: 27.h,bottom: 27.h),
                itemBuilder: ((context, index) {
                  return ShadowContainer(
                    radius: 20,
                    width: 380.w,
                    color: Colors.white,
                    padding: defaultPadding.copyWith(top: 10, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.faqs[index].question ?? '',
                          style: const TextStyle(
                              fontFamily: "lato",
                              color: AppColors.primaryRed,
                              fontSize: 17),
                        ),
                        Divider(),
                        Text(
                          state.faqs[index].answer ?? '',
                          style: theme.textTheme.labelSmall,
                        )
                      ],
                    ),
                  );
                  ;
                }),
                separatorBuilder: (ctx, index) {
                  return const Divider(
                    color: AppColors.white,
                  );
                },
                itemCount: state.faqs.length),
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Something Went Wrong!"),
              IconButton(
                  onPressed: () async {
                    if (await sl<NetworkInfo>().isConnected) {
                      context.read<FaqsCubit>().getfaqs(true);
                    } else {
                      BotToast.showText(text: 'No Internet Connection !');
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
      },
    );
  }
}
