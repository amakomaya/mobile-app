import 'package:aamako_maya/src/core/theme/custom_theme.dart';
import 'package:aamako_maya/src/core/widgets/drawer/drawer_widget.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/features/ancs/cubit/ancs_cubit.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/padding/padding.dart';
import '../../../core/theme/app_colors.dart';
import '../../authentication/authentication_cubit/auth_cubit.dart';
import '../cubit/page_change_cubit.dart';

class AncsPage extends StatefulWidget {
  const AncsPage({Key? key}) : super(key: key);

  @override
  State<AncsPage> createState() => _AncsPageState();
}

class _AncsPageState extends State<AncsPage> {
  PageController controller = PageController();

  @override
  void initState() {
    context.read<AncsCubit>().getAncs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final theme = Theme.of(context);
    return BlocBuilder<AuthenticationCubit, LoggedInState>(
      builder: (context, state) {
        if (state.isProfileComplete == true) {
          return BlocProvider(
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
                            // VerticalSpace(5.h),
                            Expanded(
                              child: BlocBuilder<AncsCubit, AncsState>(
                                builder: (context, state) {
                                  if (state.ancs == null) {
                                    return ShimmerLoading(
                                        boxHeight: 200.h, itemCount: 4);
                                  } else if (state.ancs?.isEmpty ?? false) {
                                    return const Text('NO ANC REPORTS FOUND');
                                  } else {
                                    return ListView.separated(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 40.h),
                                        itemBuilder: ((context, index) {
                                          return Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    "Visit ${index + 1}"
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                        fontFamily: "lato",
                                                        color: AppColors
                                                            .primaryRed,
                                                        fontSize: 17)),
                                              ),
                                              VerticalSpace(15.h),
                                              ShadowContainer(
                                                radius: 20,
                                                width: 380.w,
                                                color: Colors.white,
                                                padding:
                                                    defaultPadding.copyWith(
                                                        top: 10, bottom: 20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ListTile(
                                                      leading: Text(
                                                          "Visited Date",
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                      trailing: Text(
                                                          state.ancs?[index]
                                                                  .visitDate
                                                                  .toString() ??
                                                              '',
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    const Divider(),
                                                    ListTile(
                                                      leading: Text("Anemia",
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                      trailing: Text(
                                                          state.ancs?[index]
                                                                  .anemia
                                                                  .toString() ??
                                                              '',
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    ListTile(
                                                      leading: Text("Weight",
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                      trailing: Text(
                                                          state.ancs?[index]
                                                                  .weight
                                                                  .toString() ??
                                                              '',
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    ListTile(
                                                      leading: Text("Swelling",
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                      trailing: Text(
                                                          state.ancs?[index]
                                                                  .swelling
                                                                  .toString() ??
                                                              '',
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    const Divider(),
                                                    ListTile(
                                                      leading: Text(
                                                          "Blood Pressure",
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                      trailing: Text(
                                                          state.ancs?[index]
                                                                  .bloodPressure
                                                                  .toString() ??
                                                              '',
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    ListTile(
                                                      leading: Text(
                                                          "UtersHeight",
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                      trailing: Text(
                                                          state.ancs?[index]
                                                                  .uterusHeight
                                                                  .toString() ??
                                                              '',
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    ListTile(
                                                      leading: Text(
                                                          "Baby Presentation",
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                      trailing: Text(
                                                          state.ancs?[index]
                                                                  .babyPresentation
                                                                  .toString() ??
                                                              '',
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    ListTile(
                                                      leading: Text(
                                                          "Baby Heart Beat",
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                      trailing: Text(
                                                          state.ancs?[index]
                                                                  .babyHeartBeat
                                                                  .toString() ??
                                                              '',
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    ListTile(
                                                      leading: Text(
                                                          "Others Problems",
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                      trailing: Text(
                                                          state.ancs?[index]
                                                                  .other
                                                                  .toString() ??
                                                              '',
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    ListTile(
                                                      leading: Text("Situation",
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                      trailing: Text(
                                                          state.ancs?[index]
                                                                  .situation
                                                                  .toString() ??
                                                              '',
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    Divider(),
                                                    ListTile(
                                                      leading: Text(
                                                          "Checked By",
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                      trailing: Text(
                                                          state.ancs?[index]
                                                                  .checkedBy
                                                                  .toString() ??
                                                              '',
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                    ListTile(
                                                      leading: Text(
                                                          "Next Visit Date",
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                      trailing: Text(
                                                          state.ancs?[index]
                                                                  .nextVisitDate
                                                                  .toString() ??
                                                              '',
                                                          style: theme.textTheme
                                                              .labelSmall),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              VerticalSpace(15.h),
                                            ],
                                          );
                                        }),
                                        separatorBuilder: (ctx, index) {
                                          return const Divider(
                                            // height: 10.h,
                                            // indent: 10.w,
                                            //  endIndent: 10.w,
                                            color: AppColors.white,
                                          );
                                        },
                                        itemCount: state.ancs?.length ?? 0);
                                  }
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
        } else {
          return const Text('Complete Profile to get your Reports.');
        }
      },
    );
  }
}
