import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:bot_toast/bot_toast.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../injection_container.dart';
import '../../../core/connection_checker/network_connection.dart';
import '../../../core/padding/padding.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/helper_widgets/shadow_container.dart';
import '../../authentication/authentication_cubit/auth_cubit.dart';
import '../cubit/pcnchangecubit.dart';
import '../cubit/pnc_cubit.dart';

class PncsPage extends StatefulWidget {
  const PncsPage({Key? key}) : super(key: key);

  @override
  State<PncsPage> createState() => _PncsPageState();
}

class _PncsPageState extends State<PncsPage> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  PageController controller = PageController();
  @override
  void initState() {
    context.read<PncsCubit>().getPncs(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (authContext, authState) {
        return BlocProvider(
          create: (context) => PcnChangecubit(),
          child: Builder(builder: (context) {
            return SizedBox(
              height: size.height,
              width: size.width,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  PageView(
                    onPageChanged: (value) {
                      context.read<PcnChangecubit>().togglePage(value);
                    },
                    controller: controller,
                    children: [
                      Center(
                        child: Text('INFORMATION',
                            style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.black, fontSize: 15.sm)),
                      ),
                      BlocBuilder<PncsCubit, PncState>(
                        builder: (context, state) {
                          if (state is PncSuccessState) {
                            return RefreshIndicator(
                                onRefresh: () async {
                                  if (await sl<NetworkInfo>().isConnected) {
                                    context.read<PncsCubit>().getPncs(true);
                                  } else {
                                    BotToast.showText(
                                        text: 'No Internet Connection !');
                                  }
                                },
                                child: ListView.separated(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 28.h),
                                    itemBuilder: ((context, index) {
                                      return (state.data.isEmpty)
                                          ? Center(
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(top: 30.h),
                                                child: Text('No Records Found!',
                                                    style: theme
                                                        .textTheme.bodySmall
                                                        ?.copyWith(
                                                            color: Colors.black,
                                                            fontSize: 15.sm)),
                                              ),
                                            )
                                          : Container(
                                              margin: const EdgeInsets.only(
                                                  left: 18, right: 18),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "PNC Report${index + 1}"
                                                        .toUpperCase(),
                                                    style:theme.textTheme.labelMedium?.copyWith(
                                                      color: AppColors.primaryRed
                                                    )
                                                  ),
                                                  VerticalSpace(12.h),
                                                  ShadowContainer(
                                                    radius: 20,
                                                    width: 380.w,
                                                    color: Colors.white,
                                                    padding:
                                                        defaultPadding.copyWith(
                                                            top: 10,
                                                            bottom: 20),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ListTile(
                                                          leading: Text(
                                                              "Visit Date",
                                                              style: theme
                                                                  .textTheme
                                                                  .labelSmall),
                                                          trailing: Text(
                                                              (state.data[index]
                                                                          .dateOfVisit !=
                                                                      null)
                                                                  ? formatter.format(state
                                                                      .data[
                                                                          index]
                                                                      .dateOfVisit!)
                                                                  : 'N/A',
                                                              style: theme
                                                                  .textTheme
                                                                  .labelSmall),
                                                        ),
                                                        Divider(),
                                                        ListTile(
                                                          leading: Text(
                                                              "Mother Status",
                                                              style: theme
                                                                  .textTheme
                                                                  .labelSmall),
                                                          trailing: Text(
                                                              state.data[index]
                                                                      .motherStatus
                                                                       ??
                                                                  'N/A',
                                                              style: theme
                                                                  .textTheme
                                                                  .labelSmall),
                                                        ),
                                                        ListTile(
                                                          leading: Text(
                                                              "Baby Status",
                                                              style: theme
                                                                  .textTheme
                                                                  .labelSmall),
                                                          trailing: Text(
                                                              state.data[index]
                                                                      .babyStatus
                                                                       ??
                                                                  'N/A',
                                                              style: theme
                                                                  .textTheme
                                                                  .labelSmall),
                                                        ),
                                                        ListTile(
                                                          leading: Text(
                                                              "Family Planning",
                                                              style: theme
                                                                  .textTheme
                                                                  .labelSmall),
                                                          trailing: Text(
                                                              state.data[index]
                                                                      .familyPlan
                                                                    ??
                                                                  'N/A',
                                                              style: theme
                                                                  .textTheme
                                                                  .labelSmall),
                                                        ),
                                                        ListTile(
                                                          leading: Text(
                                                              "Advice",
                                                              style: theme
                                                                  .textTheme
                                                                  .labelSmall),
                                                          trailing: Text(
                                                              state.data[index]
                                                                      .advice
                                                                    ??
                                                                  'N/A',
                                                              style: theme
                                                                  .textTheme
                                                                  .labelSmall),
                                                        ),
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
                                    itemCount: state.data.isEmpty
                                        ? 1
                                        : state.data.length));
                          } else {
                            return ShimmerLoading(
                                boxHeight: 400.h, itemCount: 3);
                          }
                        },
                      ),
                    ],
                  ),
                  Positioned(
                      left: 100.w,
                      right: 100.w,
                      top: -20,
                      child: BlocBuilder<PcnChangecubit, int>(
                        builder: (context, state) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: ShadowContainer(
                              shadowColor: Colors.black,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: TextButton(
                                        onPressed: () {
                                          context
                                              .read<PcnChangecubit>()
                                              .togglePage(0);
                                          if (state == 1) {
                                            controller.previousPage(
                                                duration: const Duration(
                                                    milliseconds: 600),
                                                curve: Curves.easeIn);
                                          }
                                        },
                                        child: Text(
                                          'INFO'.toUpperCase(),
                                          style: theme.textTheme.labelSmall
                                              ?.copyWith(
                                                  color: state == 0
                                                      ? AppColors.primaryRed
                                                      : Colors.black),
                                        )),
                                  ),
                                  Expanded(
                                    child: TextButton(
                                        onPressed: () {
                                          context
                                              .read<PcnChangecubit>()
                                              .togglePage(1);
                                          if (state == 0) {
                                            controller.nextPage(
                                                duration: const Duration(
                                                    milliseconds: 600),
                                                curve: Curves.easeIn);
                                          }
                                        },
                                        child: Text(
                                          'REPORT'.toUpperCase(),
                                          style: theme.textTheme.labelSmall
                                              ?.copyWith(
                                                  color: state == 1
                                                      ? AppColors.primaryRed
                                                      : Colors.black),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )),
               
                ],
              ),
            );
        
        
          }),
        );
      },
    );
 
 
  }
}
