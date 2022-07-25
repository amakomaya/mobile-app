import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  PageController controller = PageController();
  @override
  void initState() {
    context.read<PncsCubit>().getPncs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return BlocBuilder<AuthenticationCubit, LoggedInState>(
      builder: (authContext, authState) {
       if(authState.isProfileComplete!=true){
        return const Text('Complete your profile to see your reports');

       }else{
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
                      const Center(
                        child: Text('INFORMATION'),
                      ),
                      BlocBuilder<PncsCubit, PncState>(
                        builder: (context, state) {
                          if (state.pncs == null) {
                            return ShimmerLoading(
                                boxHeight: 200.h, itemCount: 4);
                          } else if (state.pncs?.isEmpty ?? false) {
                            return const Text('NO PNC REPORTS FOUND');
                          } else {
                            return ListView.separated(
                                itemBuilder: ((context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(
                                        left: 18, right: 18),
                                    child: Column(
                                      children: [
                                        Text(
                                          "PNC Report${index + 1}"
                                              .toUpperCase(),
                                          style: const TextStyle(
                                              fontFamily: "lato",
                                              color: AppColors.primaryRed,
                                              fontSize: 17),
                                        ),
                                        VerticalSpace(12.h),
                                        ShadowContainer(
                                          radius: 20,
                                          width: 380.w,
                                          color: Colors.white,
                                          padding: defaultPadding.copyWith(
                                              top: 10, bottom: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ListTile(
                                                leading: Text("Visit Date",
                                                    style: theme
                                                        .textTheme.labelSmall),
                                                trailing: Text(
                                                    state.pncs?[index]
                                                            .dateOfVisit
                                                            .toString() ??
                                                        '',
                                                    style: theme
                                                        .textTheme.labelSmall),
                                              ),
                                              Divider(),
                                              ListTile(
                                                leading: Text("Mother Status",
                                                    style: theme
                                                        .textTheme.labelSmall),
                                                trailing: Text(
                                                    state.pncs?[index]
                                                            .motherStatus
                                                            .toString() ??
                                                        '',
                                                    style: theme
                                                        .textTheme.labelSmall),
                                              ),
                                              ListTile(
                                                leading: Text("Baby Status",
                                                    style: theme
                                                        .textTheme.labelSmall),
                                                trailing: Text(
                                                    state.pncs?[index]
                                                            .babyStatus
                                                            .toString() ??
                                                        '',
                                                    style: theme
                                                        .textTheme.labelSmall),
                                              ),
                                              ListTile(
                                                leading: Text("Family Planning",
                                                    style: theme
                                                        .textTheme.labelSmall),
                                                trailing: Text(
                                                    state.pncs?[index]
                                                            .familyPlan
                                                            .toString() ??
                                                        '',
                                                    style: theme
                                                        .textTheme.labelSmall),
                                              ),
                                              ListTile(
                                                leading: Text("Advice",
                                                    style: theme
                                                        .textTheme.labelSmall),
                                                trailing: Text(
                                                    state.pncs?[index].advice
                                                            .toString() ??
                                                        '',
                                                    style: theme
                                                        .textTheme.labelSmall),
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
                                itemCount: state.pncs?.length ?? 0);
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
      
       }
      
      },
    );

    // return BlocBuilder<PncsCubit, PncState>(
    //   builder: (context, state) {
    //     if (state.pncs == null) {
    //       return ShimmerLoading(boxHeight: 200.h, itemCount: 4);
    //     } else if (state.pncs?.isEmpty ?? false) {
    //       return const Text('NO PNC REPORTS FOUND');
    //     } else {
    //       return ListView.separated(
    //           itemBuilder: ((context, index) {
    //             return Container(
    //               margin: const EdgeInsets.only(left: 18, right: 18),
    //               child: Column(
    //                 children: [
    //                   Text(
    //                     "PNC Report${index + 1}".toUpperCase(),
    //                     style: const TextStyle(
    //                         fontFamily: "lato",
    //                         color: AppColors.primaryRed,
    //                         fontSize: 17),
    //                   ),
    //                   VerticalSpace(12.h),
    //                   ShadowContainer(
    //                     radius: 20,
    //                     width: 380.w,
    //                     color: Colors.white,
    //                     padding: defaultPadding.copyWith(top: 10, bottom: 20),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         ListTile(
    //                           leading: Text("Visit Date",
    //                               style: theme.textTheme.labelSmall),
    //                           trailing: Text(
    //                               state.pncs?[index].dateOfVisit.toString() ??
    //                                   '',
    //                               style: theme.textTheme.labelSmall),
    //                         ),
    //                         Divider(),
    //                         ListTile(
    //                           leading: Text("Mother Status",
    //                               style: theme.textTheme.labelSmall),
    //                           trailing: Text(
    //                               state.pncs?[index].motherStatus.toString() ??
    //                                   '',
    //                               style: theme.textTheme.labelSmall),
    //                         ),
    //                         ListTile(
    //                           leading: Text("Baby Status",
    //                               style: theme.textTheme.labelSmall),
    //                           trailing: Text(
    //                               state.pncs?[index].babyStatus.toString() ??
    //                                   '',
    //                               style: theme.textTheme.labelSmall),
    //                         ),
    //                         ListTile(
    //                           leading: Text("Family Planning",
    //                               style: theme.textTheme.labelSmall),
    //                           trailing: Text(
    //                               state.pncs?[index].familyPlan.toString() ??
    //                                   '',
    //                               style: theme.textTheme.labelSmall),
    //                         ),
    //                         ListTile(
    //                           leading: Text("Advice",
    //                               style: theme.textTheme.labelSmall),
    //                           trailing: Text(
    //                               state.pncs?[index].advice.toString() ?? '',
    //                               style: theme.textTheme.labelSmall),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   VerticalSpace(15.h),
    //                 ],
    //               ),
    //             );
    //           }),
    //           separatorBuilder: (ctx, index) {
    //             return const Divider(
    //               color: AppColors.white,
    //             );
    //           },
    //           itemCount: state.pncs?.length ?? 0);
    //     }
    //   },
    // );
  }
}


//edit

//bloc.add
