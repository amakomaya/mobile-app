// ignore_for_file: prefer_const_constructors

import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/features/delivery/cubit/delivery_cubit.dart';
import 'package:aamako_maya/src/features/fetch%20user%20data/cubit/get_user_cubit.dart';
import 'package:aamako_maya/src/features/medication/cubit/medication_cubit.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../injection_container.dart';
import '../../../core/connection_checker/network_connection.dart';
import '../cubit/delivery_page_cubit.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({Key? key}) : super(key: key);

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  final controller = PageController();
  @override
  void initState() {
    context.read<DeliverCubit>().getDelivery(false);
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
            : BlocProvider(
                create: (context) => DeliverPageCubit(),
                child: Builder(builder: (context) {
                  return SizedBox(
                    height: size.height,
                    width: size.width,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        PageView(
                          onPageChanged: (value) {
                            context.read<DeliverPageCubit>().togglePage(value);
                          },
                          controller: controller,
                          children: [
                            const Center(
                              child: Text('INFORMATION'),
                            ),
                            BlocBuilder<DeliverCubit, DeliveryState>(
                              builder: (context, state) {
                                return (state is DeliverySuccessState)
                                    ? RefreshIndicator(
                                        onRefresh: () async {
                                          if (await sl<NetworkInfo>()
                                              .isConnected) {
                                            context
                                                .read<DeliverCubit>()
                                                .getDelivery(true);
                                          } else {
                                            BotToast.showText(
                                                text:
                                                    'No Internet Connection !');
                                          }
                                        },
                                        child: ListView.separated(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 25.h),
                                            itemBuilder: ((context, index) {
                                              final list = state.data;
                                              return Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        "Delivery Report${index + 1}"
                                                            .toUpperCase(),
                                                        style: const TextStyle(
                                                            fontFamily: "lato",
                                                            color: AppColors
                                                                .primaryRed,
                                                            fontSize: 17)),
                                                  ),
                                                  VerticalSpace(10.h),
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
                                                              "Delivery Date",
                                                              style: theme
                                                                  .textTheme
                                                                  .labelSmall),
                                                          trailing: Text((list[
                                                                          index]
                                                                      .deliveryDate !=
                                                                  null)
                                                              ? formatter
                                                                  .format(list[
                                                                          index]
                                                                      .deliveryDate!)
                                                              : ''),
                                                        ),
                                                        ListTile(
                                                          leading: Text(
                                                              "Delivery Time",
                                                              style: theme
                                                                  .textTheme
                                                                  .labelSmall),
                                                          trailing: Text(
                                                              list[index]
                                                                  .deliveryTime
                                                                  .toString()),
                                                        ),
                                                        ListTile(
                                                          leading: Text(
                                                              "Delivery Place",
                                                              style: theme
                                                                  .textTheme
                                                                  .labelSmall),
                                                          trailing: Text(
                                                              list[index]
                                                                  .deliveryPlace
                                                                  .toString()),
                                                        ),
                                                        Divider(),
                                                        ListTile(
                                                          leading: Text(
                                                              "Delivery Date",
                                                              style: theme
                                                                  .textTheme
                                                                  .labelSmall),
                                                          trailing: Text(
                                                              list[index]
                                                                  .deliveryType
                                                                  .toString()),
                                                        ),
                                                        ListTile(
                                                          leading: Text(
                                                              "Presentation",
                                                              style: theme
                                                                  .textTheme
                                                                  .labelSmall),
                                                          trailing: Text(
                                                              list[index]
                                                                  .presentation
                                                                  .toString()),
                                                        ),
                                                        ListTile(
                                                          leading: Text(
                                                              "Complexity",
                                                              style: theme
                                                                  .textTheme
                                                                  .labelSmall),
                                                          trailing: Text(
                                                              list[index]
                                                                  .complexity
                                                                  .toString()),
                                                        ),
                                                        Divider(),
                                                        ListTile(
                                                          leading: Text(
                                                              "Other Problems",
                                                              style: theme
                                                                  .textTheme
                                                                  .labelSmall),
                                                          trailing: Text(list[
                                                                      index]
                                                                  .otherProblem ??
                                                              ''),
                                                        ),
                                                        ListTile(
                                                          leading: Text(
                                                              "Advice",
                                                              style: theme
                                                                  .textTheme
                                                                  .labelSmall),
                                                          trailing: Text(
                                                              list[index]
                                                                      .advice ??
                                                                  ''),
                                                        ),
                                                        ListTile(
                                                          leading: Text(
                                                              "Delivery By",
                                                              style: theme
                                                                  .textTheme
                                                                  .labelSmall),
                                                          trailing: Text(list[
                                                                      index]
                                                                  .deliveryBy ??
                                                              ''),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  VerticalSpace(15.h),
                                                ],
                                              );
                                            }),
                                            separatorBuilder: (ctx, index) {
                                              return Divider(
                                                height: 10.h,
                                                indent: 10.w,
                                                endIndent: 10.w,
                                                color: Color.fromARGB(
                                                    255, 31, 6, 6),
                                              );
                                            },
                                            itemCount: state.data.length),
                                      )
                                    : ShimmerLoading(
                                        boxHeight: 500.h, itemCount: 2);
                              },
                            )
                          ],
                        ),
                        Positioned(
                            left: 100.w,
                            right: 100.w,
                            top: -20,
                            child: BlocBuilder<DeliverPageCubit, int>(
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
                                                    .read<DeliverPageCubit>()
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
                                                    .read<DeliverPageCubit>()
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
