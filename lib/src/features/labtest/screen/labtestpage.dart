import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/features/audio/screens/audio_player_section.dart';
import 'package:aamako_maya/src/features/fetch%20user%20data/cubit/get_user_cubit.dart';

import 'package:aamako_maya/src/features/labtest/cubit/labtest_cubit.dart';
import 'package:bot_toast/bot_toast.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../injection_container.dart';
import '../../../core/connection_checker/network_connection.dart';
import '../../authentication/authentication_cubit/auth_cubit.dart';
import '../../delivery/cubit/delivery_cubit.dart';
import '../cubit/lab_page_cubit.dart';

class Labtestpage extends StatefulWidget {
  const Labtestpage({Key? key}) : super(key: key);

  @override
  State<Labtestpage> createState() => _LabtestpageState();
}

class _LabtestpageState extends State<Labtestpage> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  final controller = PageController();
  @override
  void initState() {
    context.read<LabtestCubit>().getlabtest(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return BlocBuilder<GetUserCubit, GetUserState>(
      builder: (userCtx, userState) {
        return (userState is GetUserSuccess &&
                (userState.user.tole?.isEmpty ?? true))
            ? Text(
                'You can not view your reports. Please complete profile first.')
            : BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (authContext, authState) {
                  return BlocProvider(
                    create: (context) => LabPageCubit(),
                    child: Builder(builder: (context) {
                      return SizedBox(
                        height: size.height,
                        width: size.width,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            PageView(
                              onPageChanged: (value) {
                                context.read<LabPageCubit>().togglePage(value);
                              },
                              controller: controller,
                              children: [
                                const Center(
                                  child: Text('INFORMATION'),
                                ),
                                BlocBuilder<LabtestCubit, LabtestState>(
                                  builder: (context, state) {
                                    if (state is LabtestSuccess) {
                                      return RefreshIndicator(
                                          onRefresh: () async {
                                            if (await sl<NetworkInfo>()
                                                .isConnected) {
                                              context
                                                  .read<LabtestCubit>()
                                                  .getlabtest(true);
                                            } else {
                                              BotToast.showText(
                                                  text:
                                                      'No Internet Connection !');
                                            }
                                          },
                                          child: ListView.separated(
                                              padding: EdgeInsets.only(
                                                  top: 27.h, bottom: 20.h),
                                              itemBuilder: ((context, index) {
                                                return (state.data.isEmpty)
                                                    ? Center(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 30.h),
                                                          child: Text(
                                                              'No Records Found!',
                                                              style: theme
                                                                  .textTheme
                                                                  .bodySmall
                                                                  ?.copyWith(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          15.sm)),
                                                        ),
                                                      )
                                                    : Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                                " Report${index + 1}"
                                                                    .toUpperCase(),
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        "lato",
                                                                    color: AppColors
                                                                        .primaryRed,
                                                                    fontSize:
                                                                        17)),
                                                          ),
                                                          VerticalSpace(12.h),
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
                                                                      "Visit Date",
                                                                      style: theme
                                                                          .textTheme
                                                                          .labelSmall),
                                                                  trailing: Text(
                                                                      (state.data[index].testDate ==
                                                                              null)
                                                                          ? 'N/A'
                                                                          : formatter.format(state
                                                                              .data[
                                                                                  index]
                                                                              .testDate!),
                                                                      style: theme
                                                                          .textTheme
                                                                          .labelSmall),
                                                                ),
                                                                Divider(),
                                                                ListTile(
                                                                  leading: Text(
                                                                      "HB",
                                                                      style: theme
                                                                          .textTheme
                                                                          .labelSmall),
                                                                  trailing: Text(
                                                                      state.data[index].hb.isNullOrEmpty
                                                                          ? 'N/A'
                                                                          : state
                                                                              .data[
                                                                                  index]
                                                                              .hb!,
                                                                      style: theme
                                                                          .textTheme
                                                                          .labelSmall),
                                                                ),
                                                                ListTile(
                                                                  leading: Text(
                                                                      "Albumin",
                                                                      style: theme
                                                                          .textTheme
                                                                          .labelSmall),
                                                                  trailing: Text(
                                                                      state.data[index].albumin.isNullOrEmpty
                                                                          ? 'N/A'
                                                                          : state
                                                                              .data[
                                                                                  index]
                                                                              .albumin!,
                                                                      style: theme
                                                                          .textTheme
                                                                          .labelSmall),
                                                                ),
                                                                ListTile(
                                                                  leading: Text(
                                                                      "Urine Protein",
                                                                      style: theme
                                                                          .textTheme
                                                                          .labelSmall),
                                                                  trailing: Text(
                                                                      state.data[index].urineProtein.isNullOrEmpty
                                                                          ? 'N/A'
                                                                          : state
                                                                              .data[
                                                                                  index]
                                                                              .urineProtein!,
                                                                      style: theme
                                                                          .textTheme
                                                                          .labelSmall),
                                                                ),
                                                                ListTile(
                                                                  leading: Text(
                                                                      "Urine Sugar",
                                                                      style: theme
                                                                          .textTheme
                                                                          .labelSmall),
                                                                  trailing: Text(
                                                                      state.data[index].urineSugar.isNullOrEmpty
                                                                          ? 'N/A'
                                                                          : state
                                                                              .data[
                                                                                  index]
                                                                              .urineSugar!,
                                                                      style: theme
                                                                          .textTheme
                                                                          .labelSmall),
                                                                ),
                                                                ListTile(
                                                                  leading: Text(
                                                                      "Blood Sugar",
                                                                      style: theme
                                                                          .textTheme
                                                                          .labelSmall),
                                                                  trailing: Text(
                                                                      state.data[index].bloodSugar.isNullOrEmpty
                                                                          ? 'N/A'
                                                                          : state
                                                                              .data[
                                                                                  index]
                                                                              .bloodSugar!,
                                                                      style: theme
                                                                          .textTheme
                                                                          .labelSmall),
                                                                ),
                                                                ListTile(
                                                                  leading: Text(
                                                                      "HBsAg",
                                                                      style: theme
                                                                          .textTheme
                                                                          .labelSmall),
                                                                  trailing: Text(
                                                                      state.data[index].hbsag.isNullOrEmpty
                                                                          ? 'N/A'
                                                                          : state
                                                                              .data[
                                                                                  index]
                                                                              .hbsag!,
                                                                      style: theme
                                                                          .textTheme
                                                                          .labelSmall),
                                                                ),
                                                                ListTile(
                                                                  leading: Text(
                                                                      "VDRL",
                                                                      style: theme
                                                                          .textTheme
                                                                          .labelSmall),
                                                                  trailing: Text(
                                                                      (!(state
                                                                              .data[
                                                                                  index]
                                                                              .vdrl
                                                                              .isNullOrEmpty))
                                                                          ? state
                                                                              .data[
                                                                                  index]
                                                                              .vdrl!
                                                                          : 'N/A',
                                                                      style: theme
                                                                          .textTheme
                                                                          .labelSmall),
                                                                ),
                                                                ListTile(
                                                                  leading: Text(
                                                                      "Retro Virus",
                                                                      style: theme
                                                                          .textTheme
                                                                          .labelSmall),
                                                                  trailing: Text(
                                                                      state.data[index].retroVirus.isNullOrEmpty
                                                                          ? 'N/A'
                                                                          : state
                                                                              .data[
                                                                                  index]
                                                                              .retroVirus!,
                                                                      style: theme
                                                                          .textTheme
                                                                          .labelSmall),
                                                                ),
                                                                Divider(),
                                                                ListTile(
                                                                  leading: Text(
                                                                      "Others",
                                                                      style: theme
                                                                          .textTheme
                                                                          .labelSmall),
                                                                  trailing: Text(
                                                                      state.data[index].other.isNullOrEmpty
                                                                          ? 'N/A'
                                                                          : state
                                                                              .data[
                                                                                  index]
                                                                              .other!,
                                                                      style: theme
                                                                          .textTheme
                                                                          .labelSmall),
                                                                ),
                                                                VerticalSpace(
                                                                    12.h),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                              }),
                                              separatorBuilder: (ctx, index) {
                                                return const Divider(
                                                  color: Colors.white,
                                                );
                                              },
                                              itemCount: state.data.isEmpty
                                                  ? 1
                                                  : state.data.length));
                                    } else {
                                      return ShimmerLoading(
                                          boxHeight: 400.h, itemCount: 4);
                                    }
                                  },
                                )
                              ],
                            ),
                            Positioned(
                                left: 100.w,
                                right: 100.w,
                                top: -20,
                                child: BlocBuilder<LabPageCubit, int>(
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
                                                        .read<LabPageCubit>()
                                                        .togglePage(0);
                                                    if (state == 1) {
                                                      controller.previousPage(
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      600),
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
                                                        .read<LabPageCubit>()
                                                        .togglePage(1);
                                                    if (state == 0) {
                                                      controller.nextPage(
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      600),
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
      },
    );
  }
}

extension on String? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }
}
