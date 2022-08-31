import 'dart:convert';

import 'package:aamako_maya/injection_container.dart';
import 'package:aamako_maya/src/core/theme/custom_theme.dart';
import 'package:aamako_maya/src/core/widgets/drawer/drawer_widget.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/features/ancs/cubit/ancs_cubit.dart';
import 'package:aamako_maya/src/features/ancs/model/ancs_model.dart';
import 'package:aamako_maya/src/features/fetch%20user%20data/cubit/get_user_cubit.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/connection_checker/network_connection.dart';
import '../../../core/padding/padding.dart';
import '../../../core/snackbar/error_snackbar.dart';
import '../../../core/theme/app_colors.dart';
import '../../authentication/authentication_cubit/auth_cubit.dart';
import '../cubit/page_change_cubit.dart';

class AncsPage extends StatefulWidget {
  const AncsPage({Key? key}) : super(key: key);

  @override
  State<AncsPage> createState() => _AncsPageState();
}

class _AncsPageState extends State<AncsPage> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  PageController controller = PageController();

  @override
  void initState() {
    context.read<AncsCubit>().getAncs(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final theme = Theme.of(context);
    return BlocBuilder<GetUserCubit, GetUserState>(
      builder: (userCtx, userState) {
        return (userState is GetUserSuccess &&
                (userState.user.tole?.isEmpty ?? true))
            ? Text(
                'You can not view your reports. Please complete profile first.')
            : BlocProvider(
                create: (context) => PageChangeCubit(),
                child: Builder(builder: (context) {
                  return SizedBox(
                    height: size.height,
                    width: size.width,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        PageView(
                          onPageChanged: (value) {
                            context.read<PageChangeCubit>().togglePage(value);
                          },
                          controller: controller,
                          children: [
                            const Center(
                              child: Text('INFORMATION'),
                            ),
                            Column(
                              children: [
                                Expanded(
                                  child: BlocBuilder<AncsCubit, AncsState>(
                                    builder: (context, state) {
                                      return (state is AncSuccessState)
                                          ? RefreshIndicator(
                                              onRefresh: () async {
                                                if (await sl<NetworkInfo>()
                                                    .isConnected) {
                                                  context
                                                      .read<AncsCubit>()
                                                      .getAncs(true);
                                                } else {
                                                  BotToast.showText(
                                                      text:
                                                          'No Internet Connection !');
                                                }
                                              },
                                              child: ListView.separated(
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 25.h),
                                                  itemBuilder:
                                                      ((context, index) {
                                                    final ancs = state.data;
                                                    return Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              "Visit ${index + 1}"
                                                                  .toUpperCase(),
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      "lato",
                                                                  color: AppColors
                                                                      .primaryRed,
                                                                  fontSize:
                                                                      17)),
                                                        ),
                                                        VerticalSpace(15.h),
                                                        ShadowContainer(
                                                          radius: 20,
                                                          width: 380.w,
                                                          color: Colors.white,
                                                          padding:
                                                              defaultPadding
                                                                  .copyWith(
                                                                      top: 10,
                                                                      bottom:
                                                                          20),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              ListTile(
                                                                leading: Text(
                                                                    "Visited Date",
                                                                    style: theme
                                                                        .textTheme
                                                                        .labelSmall),
                                                                trailing: Text(
                                                                    ((ancs[index].visitDate) !=
                                                                            null)
                                                                        ? formatter.format(ancs[index]
                                                                            .visitDate!)
                                                                        : 'N/A',
                                                                    style: theme
                                                                        .textTheme
                                                                        .labelSmall),
                                                              ),
                                                              const Divider(),
                                                              ListTile(
                                                                leading: Text(
                                                                    "Anemia",
                                                                    style: theme
                                                                        .textTheme
                                                                        .labelSmall),
                                                                trailing: Text(
                                                                    ancs[index]
                                                                            .anemia ??
                                                                        'N/A',
                                                                    style: theme
                                                                        .textTheme
                                                                        .labelSmall),
                                                              ),
                                                              ListTile(
                                                                leading: Text(
                                                                    "Weight",
                                                                    style: theme
                                                                        .textTheme
                                                                        .labelSmall),
                                                                trailing: Text(
                                                                    ancs[index]
                                                                            .weight ??
                                                                        'N/A',
                                                                    style: theme
                                                                        .textTheme
                                                                        .labelSmall),
                                                              ),
                                                              ListTile(
                                                                leading: Text(
                                                                    "Swelling",
                                                                    style: theme
                                                                        .textTheme
                                                                        .labelSmall),
                                                                trailing: Text(
                                                                    ancs[index]
                                                                            .swelling ??
                                                                        'N/A',
                                                                    style: theme
                                                                        .textTheme
                                                                        .labelSmall),
                                                              ),
                                                              const Divider(),
                                                              ListTile(
                                                                leading: Text(
                                                                    "Blood Pressure",
                                                                    style: theme
                                                                        .textTheme
                                                                        .labelSmall),
                                                                trailing: Text(
                                                                    ancs[index]
                                                                            .bloodPressure ??
                                                                        'N/A',
                                                                    style: theme
                                                                        .textTheme
                                                                        .labelSmall),
                                                              ),
                                                              ListTile(
                                                                leading: Text(
                                                                    "Uterus Height",
                                                                    style: theme
                                                                        .textTheme
                                                                        .labelSmall),
                                                                trailing: Text(
                                                                    ancs[index]
                                                                            .uterusHeight ??
                                                                        'N/A',
                                                                    style: theme
                                                                        .textTheme
                                                                        .labelSmall),
                                                              ),
                                                              ListTile(
                                                                leading: Text(
                                                                    "Baby Presentation",
                                                                    style: theme
                                                                        .textTheme
                                                                        .labelSmall),
                                                                trailing: Text(
                                                                    ancs[index]
                                                                            .babyPresentation ??
                                                                        'N/A',
                                                                    style: theme
                                                                        .textTheme
                                                                        .labelSmall),
                                                              ),
                                                              ListTile(
                                                                leading: Text(
                                                                    "Baby Heart Beat",
                                                                    style: theme
                                                                        .textTheme
                                                                        .labelSmall),
                                                                trailing: Text(
                                                                    ancs[index]
                                                                            .babyHeartBeat ??
                                                                        'N/A',
                                                                    style: theme
                                                                        .textTheme
                                                                        .labelSmall),
                                                              ),
                                                              ListTile(
                                                                leading: Text(
                                                                    "Other Problems",
                                                                    style: theme
                                                                        .textTheme
                                                                        .labelSmall),
                                                                trailing: Text(
                                                                    ancs[index]
                                                                            .other ??
                                                                        'N/A',
                                                                    style: theme
                                                                        .textTheme
                                                                        .labelSmall),
                                                              ),
                                                              ListTile(
                                                                leading: Text(
                                                                    "Situation",
                                                                    style: theme
                                                                        .textTheme
                                                                        .labelSmall),
                                                                trailing: Text(
                                                                    ancs[index]
                                                                            .situation ??
                                                                        'N/A',
                                                                    style: theme
                                                                        .textTheme
                                                                        .labelSmall),
                                                              ),
                                                              const Divider(),
                                                              ListTile(
                                                                leading: Text(
                                                                    "Checked By",
                                                                    style: theme
                                                                        .textTheme
                                                                        .labelSmall),
                                                                trailing: Text(
                                                                    ancs[index]
                                                                            .checkedBy ??
                                                                        'N/A',
                                                                    style: theme
                                                                        .textTheme
                                                                        .labelSmall),
                                                              ),
                                                              ListTile(
                                                                leading: Text(
                                                                    "Next Visit Date",
                                                                    style: theme
                                                                        .textTheme
                                                                        .labelSmall),
                                                                trailing: Text(
                                                                    ancs[index]
                                                                            .nextVisitDate ??
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
                                                    );
                                                  }),
                                                  separatorBuilder:
                                                      (ctx, index) {
                                                    return const Divider(
                                                      color: AppColors.white,
                                                    );
                                                  },
                                                  itemCount: state.data.length),
                                            )
                                          : ShimmerLoading(
                                              boxHeight: 330.h, itemCount: 4);
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Positioned(
                            left: 100.w,
                            right: 100.w,
                            top: -20,
                            child: BlocBuilder<PageChangeCubit, int>(
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
                                                    .read<PageChangeCubit>()
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
                                                style: theme
                                                    .textTheme.labelSmall
                                                    ?.copyWith(
                                                        color: state == 0
                                                            ? AppColors
                                                                .primaryRed
                                                            : Colors.black),
                                              )),
                                        ),
                                        Expanded(
                                          child: TextButton(
                                              onPressed: () {
                                                context
                                                    .read<PageChangeCubit>()
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
                                                style: theme
                                                    .textTheme.labelSmall
                                                    ?.copyWith(
                                                        color: state == 1
                                                            ? AppColors
                                                                .primaryRed
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
