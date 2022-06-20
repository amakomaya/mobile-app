import 'package:aamako_maya/src/core/app_assets/app_assets.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/border_container.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/padding/padding.dart';
import '../../core/widgets/drawer/drawer_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        drawer: DrawerWidget(),
        body: Builder(builder: (context) {
          return Stack(clipBehavior: Clip.none, children: [
            Container(
              width: size.width,
              height: 200.h,
              decoration: const BoxDecoration(
                  color: AppColors.primaryRed,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
              child: Padding(
                  padding: defaultPadding.copyWith(
                    top: 20.h,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Material(
                          color: Colors.red,
                          child: InkWell(
                            splashColor: Colors.white.withOpacity(0.5),
                            onTap: () => Scaffold.of(context).openDrawer(),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              color: Colors.transparent,
                              child: Icon(
                                Icons.menu,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      HorizSpace(20.w),
                      Text(
                        'Home',
                        style: theme.textTheme.displaySmall,
                      ),
                      const Spacer(),
                      const Icon(Icons.notifications_active),
                      HorizSpace(10.w),
                      const Icon(Icons.call),
                      HorizSpace(10.w),
                      const Icon(Icons.more_vert)
                    ],
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 60.h),
              child: SizedBox(
                height: size.height - 60.h,
                child: Column(
                  children: [
                    VerticalSpace(50.h),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 380.w,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                offset: const Offset(1, 1),
                                color: AppColors.accentGrey.withOpacity(0.6),
                              )
                            ],
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Rita Lama",
                                style: theme.textTheme.labelLarge,
                              ),
                              Text(
                                ' 50 years 20 weeks',
                                style: theme.textTheme.bodySmall?.copyWith(
                                    fontSize: 11, fontWeight: FontWeight.w600),
                              ),
                              const Divider(
                                height: 20,
                                color: Colors.red,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: '183\n',
                                        style: theme.textTheme.bodySmall),
                                    TextSpan(
                                        text: 'Days',
                                        style: theme.textTheme.bodySmall),
                                  ])),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: '7/77/2022\n',
                                        style: theme.textTheme.bodySmall),
                                    TextSpan(
                                        text: 'Delivery Date',
                                        style: theme.textTheme.bodySmall),
                                  ]))
                                ],
                              )
                            ],
                          ),
                        ),
                        Positioned(
                            top: -45.h,
                            right: 0,
                            left: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 30.h,
                                      backgroundImage:
                                          const AssetImage(AppAssets.girl),
                                    )
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                    const VerticalSpace(1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2,
                                  offset: const Offset(1, 1),
                                  color: AppColors.accentGrey.withOpacity(0.6),
                                )
                              ],
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20))),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.call,
                                color: AppColors.primaryRed,
                              ),
                              HorizSpace(5.w),
                              Text(
                                'Call us'.toUpperCase(),
                                style: theme.textTheme.bodyMedium?.copyWith(
                                    color: AppColors.primaryRed,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                        const HorizSpace(0.1),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2,
                                  offset: const Offset(1, 1),
                                  color: AppColors.accentGrey.withOpacity(0.6),
                                )
                              ],
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(20))),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.touch_app_rounded,
                                color: AppColors.primaryRed,
                              ),
                              HorizSpace(5.w),
                              Text(
                                'MSG  Us'.toUpperCase(),
                                style: theme.textTheme.bodyMedium?.copyWith(
                                    color: AppColors.primaryRed,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(vertical: 40.h),
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              ShadowContainer(
                                width: 380.w,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    BorderContainer(
                                      child: Center(
                                          child: Text(
                                        'Status Report',
                                        style: theme.textTheme.labelMedium,
                                      )),
                                    ),
                                    Divider(
                                      color: AppColors.accentGrey,
                                      height: 20.h,
                                      endIndent: 10,
                                      indent: 10,
                                    ),
                                    VerticalSpace(15.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text: '3/4\n',
                                              style: theme
                                                  .textTheme.displaySmall
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors
                                                          .primaryRed)),
                                          TextSpan(
                                              text: 'ANCs',
                                              style: theme.textTheme.labelSmall
                                                  ?.copyWith(
                                                      color: AppColors
                                                          .accentGrey)),
                                        ])),
                                        RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text: '0\n',
                                              style: theme
                                                  .textTheme.displaySmall
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors
                                                          .primaryRed)),
                                          TextSpan(
                                              text: 'Deliveries',
                                              style: theme.textTheme.labelSmall
                                                  ?.copyWith(
                                                      color: AppColors
                                                          .accentGrey)),
                                        ])),
                                        RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text: '3/3\n',
                                              style: theme
                                                  .textTheme.displaySmall
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors
                                                          .primaryRed)),
                                          TextSpan(
                                              text: 'PNCs',
                                              style: theme.textTheme.labelSmall
                                                  ?.copyWith(
                                                      color: AppColors
                                                          .accentGrey)),
                                        ]))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              VerticalSpace(20.h),
                              ShadowContainer(
                                height: 148.h,
                                radius: 20,
                                width: 383.w,
                                color: Colors.black,
                                child: const Center(
                                  child: Icon(
                                    Icons.play_circle_sharp,
                                    size: 50,
                                  ),
                                ),
                              ),
                              VerticalSpace(20.h),
                              ShadowContainer(
                                radius: 20,
                                width: 383.w,
                                color: Colors.white,
                                padding: defaultPadding.copyWith(
                                    top: 10, bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Things that are to be taken into consideration',
                                        style: theme.textTheme.labelMedium),
                                    Divider(
                                      endIndent: 10,
                                      indent: 10,
                                      height: 10,
                                      color: AppColors.accentGrey,
                                    ),
                                    Text(
                                        'Lorem isum lorem ipsum.Lorem isum lorem ipsum Lorem isum lorem ipsum.Lorem isum lorem ipsum.Lorem isum lorem ipsumLorem isum lorem ipsum',
                                        style: theme.textTheme.labelSmall)
                                  ],
                                ),
                              ),
                              VerticalSpace(20.h),
                              ShadowContainer(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                radius: 25,
                                color: Colors.white,
                                width: 383.w,
                                child: Row(children: [
                                  Image.asset(AppAssets.musicIcon),
                                  Expanded(
                                      child: Text(
                                    'Fetus growth from 5-10 weeks.mp3',
                                    style: theme.textTheme.labelSmall,
                                  ))
                                ]),
                              ),
                            ],
                          )
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            )
          ]);
        }),
      ),
    );
  }
}




//
