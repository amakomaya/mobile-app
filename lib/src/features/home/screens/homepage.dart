import 'package:aamako_maya/src/core/app_assets/app_assets.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/border_container.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/features/authentication/drawer_cubit/drawer_cubit.dart';
import 'package:aamako_maya/src/features/home/cubit/newsfeed_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/padding/padding.dart';
import '../../../core/widgets/drawer/drawer_widget.dart';
import '../../authentication/authentication_cubit/auth_cubit.dart';
import '../../bottom_nav/cubit/cubit/navigation_index_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<NewsfeedCubit>().getNewsFeed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    return BlocBuilder<AuthenticationCubit, LoggedInState>(
      builder: (authC, authS) {
        return Stack(clipBehavior: Clip.none, children: [
          // Container(
          //   width: size.width,
          //   height: 200.h,
          //   decoration: const BoxDecoration(
          //       color: AppColors.primaryRed,
          //       borderRadius: BorderRadius.only(
          //           bottomLeft: Radius.circular(50),
          //           bottomRight: Radius.circular(50))),
          //   child: Padding(
          //       padding: defaultPadding.copyWith(
          //         top: 20.h,
          //       ),
          //       child: Row(
          //         mainAxisSize: MainAxisSize.min,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           ClipRRect(
          //             borderRadius: BorderRadius.circular(40),
          //             child: Material(
          //               color: Colors.red,
          //               child: InkWell(
          //                 splashColor: Colors.white.withOpacity(0.5),
          //                 onTap: () {
          //                   Scaffold.of(context).openDrawer();
          //                 },
          //                 child: Container(
          //                   padding: EdgeInsets.symmetric(horizontal: 8),
          //                   color: Colors.transparent,
          //                   child: Icon(
          //                     Icons.menu,
          //                     color: Colors.white,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //           HorizSpace(20.w),
          //           Text(
          //             'Home',
          //             style: theme.textTheme.displaySmall,
          //           ),
          //           const Spacer(),
          //           ImageIcon(
          //             const AssetImage(
          //               "assets/images/notification.png",
          //             ),
          //             size: 20.sm,
          //           ),
          //           HorizSpace(10.w),
          //           ImageIcon(
          //             const AssetImage(
          //               "assets/images/siren.png",
          //             ),
          //             size: 20.sm,
          //           ),
          //           HorizSpace(10.w),
          //           ImageIcon(
          //             const AssetImage(
          //               "assets/images/language.png",
          //             ),
          //             size: 20.sm,
          //           ),
          //         ],
          //       )),
          // ),

          SizedBox(
            height: size.height - 60.h,
            child: Column(
              children: [
                authS.isProfileComplete == false
                    ? ShadowContainer(
                        margin: EdgeInsets.only(top: 10.h),
                        color: AppColors.primaryRed,
                        padding: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: 10.w),
                        width: 390.w,

                        // child: RichText(
                        //   text: TextSpan(
                        //       text: 'It looks like you have not completed profile ? ',
                        //       children: [
                        //         TextSpan(
                        //             recognizer: TapGestureRecognizer()
                        //               ..onTap = () {
                        //                 context
                        //                     .read<NavigationIndexCubit>()
                        //                     .changeIndex(
                        //                         index: 10, title: "Profile");
                        //               },
                        //             text:
                        //                 ' Complete Now !!',
                        //             style: TextStyle(
                        //                 decoration: TextDecoration.underline))
                        //       ]),
                        // ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                'You have not completed your profile!! Please Complete Your Profile First !!',
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            // HorizSpace(5.w),
                            TextButton(
                                onPressed: () {
                                  context
                                      .read<DrawerCubit>()
                                      .checkDrawerSelection(1);
                                  context
                                      .read<NavigationIndexCubit>()
                                      .changeIndex(index: 10, title: "Profile");
                                },
                                child: Text('Go to profile',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                        fontSize: 20.sm, color: Colors.white)))
                          ],
                        ))
                    : Container(),
                // VerticalSpace(50.h),
                // Stack(
                //   clipBehavior: Clip.none,
                //   children: [
                //     Container(
                //       width: 380.w,
                //       padding: const EdgeInsets.all(20),
                //       decoration: BoxDecoration(
                //         boxShadow: [
                //           BoxShadow(
                //             blurRadius: 2,
                //             offset: const Offset(1, 1),
                //             color: AppColors.accentGrey.withOpacity(0.6),
                //           )
                //         ],
                //         color: AppColors.white,
                //         borderRadius: BorderRadius.circular(30),
                //       ),
                //       child: Column(
                //         mainAxisSize: MainAxisSize.min,
                //         children: [
                //           Text(
                //             "Rita Lama",
                //             style: theme.textTheme.labelLarge,
                //           ),
                //           Text(
                //             ' 50 years 20 weeks',
                //             style: theme.textTheme.bodySmall?.copyWith(
                //                 fontSize: 11, fontWeight: FontWeight.w600),
                //           ),
                //           const Divider(
                //             height: 20,
                //             color: Colors.red,
                //           ),
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               RichText(
                //                   text: TextSpan(children: [
                //                 TextSpan(
                //                     text: '183\n',
                //                     style: theme.textTheme.bodySmall),
                //                 TextSpan(
                //                     text: 'Days',
                //                     style: theme.textTheme.bodySmall),
                //               ])),
                //               RichText(
                //                   text: TextSpan(children: [
                //                 TextSpan(
                //                     text: '7/77/2022\n',
                //                     style: theme.textTheme.bodySmall),
                //                 TextSpan(
                //                     text: 'Delivery Date',
                //                     style: theme.textTheme.bodySmall),
                //               ]))
                //             ],
                //           )
                //         ],
                //       ),
                //     ),
                //     Positioned(
                //         top: -45.h,
                //         right: 0,
                //         left: 0,
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Column(
                //               children: [
                //                 CircleAvatar(
                //                   radius: 30.h,
                //                   backgroundImage:
                //                       const AssetImage(AppAssets.girl),
                //                 )
                //               ],
                //             )
                //           ],
                //         )),
                //   ],
                // ),

                // const VerticalSpace(1),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //       padding: const EdgeInsets.symmetric(
                //           horizontal: 15, vertical: 10),
                //       decoration: BoxDecoration(
                //           boxShadow: [
                //             BoxShadow(
                //               blurRadius: 2,
                //               offset: const Offset(1, 1),
                //               color: AppColors.accentGrey.withOpacity(0.6),
                //             )
                //           ],
                //           color: Colors.white,
                //           borderRadius: const BorderRadius.only(
                //               bottomLeft: Radius.circular(20))),
                //       child: Row(
                //         children: [
                //           const Icon(
                //             Icons.call,
                //             color: AppColors.primaryRed,
                //           ),
                //           HorizSpace(5.w),
                //           Text(
                //             'Call us'.toUpperCase(),
                //             style: theme.textTheme.bodyMedium?.copyWith(
                //                 color: AppColors.primaryRed,
                //                 fontWeight: FontWeight.w700),
                //           )
                //         ],
                //       ),
                //     ),
                //     const HorizSpace(0.1),
                //     Container(
                //       padding: const EdgeInsets.symmetric(
                //           horizontal: 15, vertical: 10),
                //       decoration: BoxDecoration(
                //           boxShadow: [
                //             BoxShadow(
                //               blurRadius: 2,
                //               offset: const Offset(1, 1),
                //               color: AppColors.accentGrey.withOpacity(0.6),
                //             )
                //           ],
                //           color: Colors.white,
                //           borderRadius: const BorderRadius.only(
                //               bottomRight: Radius.circular(20))),
                //       child: Row(
                //         children: [
                //           const Icon(
                //             Icons.touch_app_rounded,
                //             color: AppColors.primaryRed,
                //           ),
                //           HorizSpace(5.w),
                //           Text(
                //             'MSG  Us'.toUpperCase(),
                //             style: theme.textTheme.bodyMedium?.copyWith(
                //                 color: AppColors.primaryRed,
                //                 fontWeight: FontWeight.w700),
                //           )
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                // VerticalSpace(20.h),
                Expanded(child: BlocBuilder<NewsfeedCubit, NewsfeedState>(
                  builder: (context, state) {
                    return state.isLoading == true
                        ? ShimmerLoading(boxHeight: 150.h, itemCount: 2)
                        : ListView.separated(
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            itemBuilder: ((context, index) {
                              return Column(
                                children: [
                                  //video container
                                  ShadowContainer(
                                    height: 148.h,
                                    radius: 20,
                                    width: 380.w,
                                    color: Colors.black,
                                    child: const Center(
                                      child: Icon(
                                        Icons.play_circle_sharp,
                                        size: 50,
                                      ),
                                    ),
                                  ),
                                  VerticalSpace(20.h),

                                  //news container
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
                                        Html(
                                            data: state.newsfeed?[index].title),
                                      ],
                                    ),
                                  ),
                                  VerticalSpace(20.h),
                                  //audio container
                                  ShadowContainer(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    radius: 25,
                                    color: Colors.white,
                                    width: 380.w,
                                    child: Row(children: [
                                      Image.asset(AppAssets.musicIcon),
                                      Expanded(
                                          child: Text(
                                        state.newsfeed?[index].url ??
                                            'Unknown.mp3',
                                        style: theme.textTheme.labelSmall,
                                      ))
                                    ]),
                                  ),
                                ],
                              );
                            }),
                            separatorBuilder: (context, index) =>
                                VerticalSpace(40.h),
                            itemCount: state.newsfeed?.length ?? 0);
                  },
                ))
              ],
            ),
          )
        ]);
      },
    );
    // return SafeArea(
    //   bottom: false,
    //   child: Scaffold(
    //     // backgroundColor: Colors.tra,
    //     // drawer: DrawerWidget(),
    //     body: Builder(builder: (ctx) {
    //       return
    //     }),
    //   ),
    // );
  }
}

//
