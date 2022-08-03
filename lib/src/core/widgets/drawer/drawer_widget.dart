import 'dart:async';
import 'dart:ui';

import 'package:aamako_maya/src/core/app_assets/app_assets.dart';
import 'package:aamako_maya/src/core/snackbar/success_snackbar.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/features/ancs/cubit/ancs_cubit.dart';

import 'package:aamako_maya/src/features/ancs/screens/ancs_page.dart';
import 'package:aamako_maya/src/features/authentication/screens/login/login_page.dart';
import 'package:aamako_maya/src/features/baby/screen/babypage.dart';
import 'package:aamako_maya/src/features/bottom_nav/cubit/cubit/navigation_index_cubit.dart';

import 'package:aamako_maya/src/features/delivery/screen/delivery_page.dart';
import 'package:aamako_maya/src/features/faqs/model/faqs_model.dart';
import 'package:aamako_maya/src/features/faqs/screen/faqs_page.dart';
import 'package:aamako_maya/src/features/labtest/screen/labtestpage.dart';
import 'package:aamako_maya/src/features/medication/screen/medicationpage.dart';
import 'package:aamako_maya/src/features/pnc/screens/pnc_page.dart';
import 'package:aamako_maya/src/features/symptoms/screen/symptomspage.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/locale_keys.g.dart';
import '../../../features/authentication/authentication_cubit/auth_cubit.dart';
import '../../../features/authentication/authentication_cubit/logout_cubit.dart';
import '../../../features/authentication/drawer_cubit/drawer_cubit.dart';
import '../../../features/authentication/local_storage/authentication_local_storage.dart';
import '../../../features/bottom_nav/bottom_navigation.dart';
import '../../strings/app_strings.dart';
import '../../theme/app_colors.dart';
import '../helper_widgets/blank_space.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Builder(builder: (context) {
      return BlocListener<LoggedOutCubit, LoggedOutState>(
        listener: (context, state) {
          if (state.isLoading == true) {
            BotToast.showLoading();
          }
          if (state.isLoading == false) {
            BotToast.closeAllLoading();
          }
          if (state.isLoggedOut == true) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (ctx) => const LoginPage()),
                (route) => false);
          }
          Timer(Duration(seconds: 2), () {
            BotToast.showCustomText(toastBuilder: (f) {
              return SuccessSnackBar(message: "Loggedout Successfully !!");
            });
          });
        },
        child: BlocBuilder<DrawerCubit, DrawerState>(
          builder: (context, state) {
            return Container(
              color: Colors.white,
              width: size.width * 0.8,
              height: size.height,
              child: Stack(
                children: [
                  Container(
                    height: 225.h,
                    decoration: const BoxDecoration(
                        color: AppColors.primaryRed,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        )),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                        top: 30.h,
                        left: 10,
                        right: 10,
                        bottom: 39.h,
                      ),
                      child: BlocBuilder<AuthenticationCubit, LoggedInState>(
                        builder: (authCo, authSo) {
                          return Column(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(AppAssets.girl),
                                  radius: 40.h,
                                ),
                              ),
                              VerticalSpace(5.h),
                              Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(authSo.user?.name ?? '',
                                      style: theme.textTheme.titleSmall
                                          ?.copyWith(
                                              fontSize: 34,
                                              color: AppColors.white))),
                              VerticalSpace(5.h),
                              Align(
                                  alignment: Alignment.topCenter,
                                  child: Text('40 weeks 5 days',
                                      style: theme.textTheme.titleSmall
                                          ?.copyWith(
                                              fontSize: 12,
                                              color: AppColors.white))),
                              VerticalSpace(15.h),
                              Expanded(
                                child: ShadowContainer(
                                  color: Colors.white,
                                  child: ListView(
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          Navigator.pop(context);

                                          context
                                              .read<DrawerCubit>()
                                              .checkDrawerSelection(0);

                                          context
                                              .read<NavigationIndexCubit>()
                                              .changeIndex(
                                                  index: 0, titleEn :'Home',titleNp: AppStrings.home);
                                        },
                                        leading: Image.asset(
                                          AppAssets.homeIcon,
                                          height: 30.sm,
                                        ),
                                        title: Text(
                                        LocaleKeys.home.tr(),
                                          style: theme.textTheme.titleSmall
                                              ?.copyWith(
                                                  color: state.index == 0
                                                      ? Colors.red
                                                      : Colors.black),
                                        ),
                                      ),
                                      //profile
                                      ListTile(
                                        onTap: () {
                                          Navigator.pop(context);
                                          context
                                              .read<DrawerCubit>()
                                              .checkDrawerSelection(1);
                                          context
                                              .read<NavigationIndexCubit>()
                                              .changeIndex(
                                                  index: 10,titleNp:  AppStrings.profile, titleEn:'Profile');
                                        },
                                        leading: Image.asset(
                                          AppAssets.profileIcon,
                                          height: 30.sm,
                                        ),
                                        title: Text(LocaleKeys.profile.tr(),
                                            style: theme.textTheme.titleSmall
                                                ?.copyWith(
                                                    color: state.index == 1
                                                        ? AppColors.primaryRed
                                                        : Colors.black)),
                                      ),

                                      //card
                                      ListTile(
                                        onTap: () {
                                          Navigator.pop(context);
                                          context
                                              .read<DrawerCubit>()
                                              .checkDrawerSelection(2);

                                          context
                                              .read<NavigationIndexCubit>()
                                              .changeIndex(
                                                  index: 11, titleEn:"card",titleNp:  AppStrings.card);
                                        },
                                        leading: Image.asset(
                                          AppAssets.cardIcon,
                                          height: 30.sm,
                                        ),
                                        title: Text(LocaleKeys.card.tr(),
                                            style: theme.textTheme.titleSmall
                                                ?.copyWith(
                                                    color: state.index == 2
                                                        ? AppColors.primaryRed
                                                        : Colors.black)),
                                      ),
                                      //
                                      ListTile(
                                        onTap: () {
                                          Navigator.pop(context);
                                          context
                                              .read<DrawerCubit>()
                                              .checkDrawerSelection(3);
                                          context
                                              .read<NavigationIndexCubit>()
                                              .changeIndex(
                                                  index: 13,
                                                  titleNp:  AppStrings.symptoms,
                                                  titleEn: "Symptom Assessment");
                                        },
                                        leading: Image.asset(
                                          AppAssets.symptomIcon,
                                          height: 30.sm,
                                        ),
                                        title: Text(LocaleKeys.symptoms.tr(),
                                            style: theme.textTheme.titleSmall
                                                ?.copyWith(
                                                    color: state.index == 3
                                                        ? AppColors.primaryRed
                                                        : Colors.black)),
                                      ),
                                      //Appointment
                                      ListTile(
                                        onTap: (() {
                                          context
                                              .read<DrawerCubit>()
                                              .checkDrawerSelection(4);
                                        }),
                                        leading: Image.asset(
                                          AppAssets.appoitnmentIcon,
                                          height: 30.sm,
                                        ),
                                        title: Text(LocaleKeys.appointment.tr(),
                                            style: theme.textTheme.titleSmall
                                                ?.copyWith(
                                                    color: state.index == 4
                                                        ? AppColors.primaryRed
                                                        : Colors.black)),
                                      ),
                                      //health Report
                                      ExpansionTile(
                                        initiallyExpanded: (state.index! > 4 &&
                                                state.index! < 10)
                                            ? true
                                            : false,
                                        leading: Image.asset(
                                          AppAssets.healthreportIcon,
                                          height: 30.sm,
                                        ),
                                        title: Text(LocaleKeys.healthreport.tr(),
                                            style: theme.textTheme.titleSmall),
                                        children: [
                                          ListTile(
                                            onTap: () {
                                              // Navigator.of(context).push(
                                              //     MaterialPageRoute(
                                              //         builder: (context) => AncsPage()));
                                              Navigator.pop(context);
                                              context
                                                  .read<DrawerCubit>()
                                                  .checkDrawerSelection(5);

                                              context
                                                  .read<NavigationIndexCubit>()
                                                  .changeIndex(
                                                      index: 5,titleNp: 'ANC', titleEn: 'ANC');
                                            },
                                            title: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 80, right: 50),
                                              child: Text("ANC",
                                                  style: theme
                                                      .textTheme.titleSmall
                                                      ?.copyWith(
                                                          color: state.index ==
                                                                  5
                                                              ? AppColors
                                                                  .primaryRed
                                                              : Colors.black)),
                                            ),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              context
                                                  .read<DrawerCubit>()
                                                  .checkDrawerSelection(6);
                                              Navigator.pop(context);

                                              context
                                                  .read<NavigationIndexCubit>()
                                                  .changeIndex(
                                                    titleNp: 'Del',
                                                      index: 6,
                                                      titleEn: 'Delivery Page');
                                            },
                                            title: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 80, right: 50),
                                              child: Text("Delivery",
                                                  style: theme
                                                      .textTheme.titleSmall
                                                      ?.copyWith(
                                                          color: state.index ==
                                                                  6
                                                              ? AppColors
                                                                  .primaryRed
                                                              : Colors.black)),
                                            ),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              context
                                                  .read<DrawerCubit>()
                                                  .checkDrawerSelection(7);
                                              Navigator.pop(context);

                                              context
                                                  .read<NavigationIndexCubit>()
                                                  .changeIndex(
                                                    titleNp: 'Med',
                                                      index: 7,
                                                      titleEn: 'Medication');
                                            },
                                            title: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 80, right: 50),
                                              child: Text("Medication",
                                                  style: theme
                                                      .textTheme.titleSmall
                                                      ?.copyWith(
                                                          color: state.index ==
                                                                  7
                                                              ? AppColors
                                                                  .primaryRed
                                                              : Colors.black)),
                                            ),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              context
                                                  .read<DrawerCubit>()
                                                  .checkDrawerSelection(8);
                                              Navigator.pop(context);

                                              context
                                                  .read<NavigationIndexCubit>()
                                                  .changeIndex(
                                                    titleNp: 'Post',
                                                      index: 8,
                                                      titleEn: 'Postnatal Care');
                                            },
                                            title: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 80, right: 50),
                                              child: Text("PNC",
                                                  style: theme
                                                      .textTheme.titleSmall
                                                      ?.copyWith(
                                                          color: state.index ==
                                                                  8
                                                              ? AppColors
                                                                  .primaryRed
                                                              : Colors.black)),
                                            ),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              context
                                                  .read<DrawerCubit>()
                                                  .checkDrawerSelection(9);
                                              Navigator.pop(context);

                                              context
                                                  .read<NavigationIndexCubit>()
                                                  .changeIndex(
                                                    titleNp: 'Lab',
                                                      index: 9,
                                                      titleEn: 'Lab Test');
                                            },
                                            title: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 80, right: 50),
                                              child: Text("Lab Test",
                                                  style: theme
                                                      .textTheme.titleSmall
                                                      ?.copyWith(
                                                          color: state.index ==
                                                                  9
                                                              ? AppColors
                                                                  .primaryRed
                                                              : Colors.black)),
                                            ),
                                          ),
                                        ],
                                      ),

                                      // ListTile(
                                      //   onTap: () {
                                      //     Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder: (context) =>
                                      //                 const BabyPage()));
                                      //   },
                                      //   leading: Image.asset(
                                      //     AppAssets.babyIcon,
                                      //     height: 30.sm,
                                      //     color: Colors.red,
                                      //   ),
                                      //   title: Text('Baby',
                                      //       style: theme.textTheme.titleSmall),
                                      // ),

                                      //faq button
                                      ListTile(
                                        onTap: () {
                                          context
                                              .read<DrawerCubit>()
                                              .checkDrawerSelection(10);
                                          Navigator.pop(context);

                                          context
                                              .read<NavigationIndexCubit>()
                                              .changeIndex(
                                                titleNp: 'Fa',
                                                  index: 12, titleEn: 'FAQs');
                                        },
                                        leading: Image.asset(
                                          AppAssets.faqsIcon,
                                          height: 30.sm,
                                        ),
                                        title: Text('FAQs',
                                            style: theme.textTheme.titleSmall
                                                ?.copyWith(
                                                    color: state.index == 10
                                                        ? AppColors.primaryRed
                                                        : Colors.black)),
                                      ),
                                      //log out button
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: TextButton.icon(
                                              label: Text(
                                                'Logout',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                context
                                                    .read<LoggedOutCubit>()
                                                    .logout();
                                              },
                                              icon: Icon(Icons.logout,
                                                  color: Colors.red)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      )),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
