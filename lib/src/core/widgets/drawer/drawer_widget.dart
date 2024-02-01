import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../l10n/locale_keys.g.dart';
import '../../../features/authentication/authentication_cubit/logout_cubit.dart';
import '../../../features/authentication/drawer_cubit/drawer_cubit.dart';
import '../../../features/authentication/screens/login/login_page.dart';
import '../../../features/bottom_nav/cubit/cubit/navigation_index_cubit.dart';
import '../../../features/fetch user data/cubit/get_user_cubit.dart';
import '../../../features/home/cubit/newsfeed_cubit.dart';
import '../../app_assets/app_assets.dart';
import '../../theme/app_colors.dart';
import '../helper_widgets/blank_space.dart';
import '../helper_widgets/shadow_container.dart';

class DrawerWidget extends StatefulWidget {
  final int currentIndex;

  const DrawerWidget({super.key, required this.currentIndex});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  var currentIndexs = -1;

  @override
  void initState() {
    currentIndexs = widget.currentIndex;
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
          Timer(const Duration(seconds: 2), () {
            BotToast.showText(text: 'Logout Successful');
          });
        },
        child: BlocBuilder<DrawerCubit, DrawerState>(
          builder: (context, state) {
            return Container(
              color: Colors.white,
              width: size.width * 0.8.sm,
              height: size.height,
              child: Stack(
                children: [
                  Container(
                    height: 225.h,
                    decoration: BoxDecoration(
                        color: AppColors.primaryRed,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25.r),
                          bottomRight: Radius.circular(25.r),
                        )),
                  ),
                  Padding(
                      padding: REdgeInsets.only(
                        top: 30,
                        left: 10,
                        right: 10,
                        bottom: 39,
                      ),
                      child: BlocBuilder<NewsfeedCubit, NewsfeedState>(
                        builder: (newsFeedCtx, newsFeedState) {
                          return Column(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Image.network(
                                  newsFeedState is NewsfeedSuccess
                                      ? newsFeedState
                                          .newsfeed.userDetail.profileImage
                                      : "",
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                  height: 40.sm,
                                  width: 40.sm,
                                  errorBuilder: (context, url, error) {
                                    return Image.asset(
                                      'assets/images/logo/profile.png',
                                      height: 40.sm,
                                      width: 40.sm,
                                    );
                                  },
                                ),
                              ),
                              VerticalSpace(5.h),
                              BlocBuilder<GetUserCubit, GetUserState>(
                                builder: (context, state) {
                                  return Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                          (state is GetUserSuccess)
                                              ? (state.user.name ?? 'Unknown')
                                              : '',
                                          style: theme.textTheme.labelMedium
                                              ?.copyWith(
                                                  color: AppColors.white)));
                                },
                              ),
                              VerticalSpace(5.h),
                              newsFeedState is NewsfeedSuccess
                                  ? newsFeedState
                                              .newsfeed.userDetail.userMode !=
                                          "pregnancy"
                                      ? SizedBox()
                                      : BlocBuilder<GetUserCubit, GetUserState>(
                                          builder: (userCtx, userState) {
                                          String weeks = '';
                                          String day = '';
                                          String days = '';
                                          if (userState is GetUserSuccess) {
                                            final date = DateTime.parse(
                                                userState.user.lmpDateNp ?? '');

                                            DateTime earlier = DateTime.utc(
                                                date.year,
                                                date.month,
                                                date.day);
                                            final later = DateTime.utc(
                                                NepaliDateTime.now().year,
                                                NepaliDateTime.now().month,
                                                NepaliDateTime.now().day);
                                            day = differenceInCalendarDays(
                                                    later, earlier)
                                                .toString();

                                            weeks = ((int.parse(day) % 365) / 7)
                                                .toStringAsFixed(0);
                                            days = ((int.parse(day) % 365) % 7)
                                                .toString();
                                          }

                                          return Align(
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                  weeks +
                                                      ' weeks ' +
                                                      days +
                                                      ' days',
                                                  style: theme
                                                      .textTheme.titleSmall
                                                      ?.copyWith(
                                                          fontSize: 12.sm,
                                                          color: AppColors
                                                              .white)));
                                        })
                                  : SizedBox(),
                              VerticalSpace(15.h),
                              Expanded(
                                child: ShadowContainer(
                                  color: Colors.white,
                                  child: ListView(
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            currentIndexs = 0;
                                          });
                                          DefaultTabController.of(context)
                                              .animateTo(0);
                                          context
                                              .read<DrawerCubit>()
                                              .checkDrawerSelection(0);

                                          context
                                              .read<NavigationIndexCubit>()
                                              .changeIndex(
                                                  index: 0,
                                                  titleEn: 'Home',
                                                  titleNp: "होम");
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
                                          setState(() {
                                            currentIndexs = 5;
                                          });
                                          DefaultTabController.of(context)
                                              .animateTo(5);
                                          context
                                              .read<DrawerCubit>()
                                              .checkDrawerSelection(1);
                                          context
                                              .read<NavigationIndexCubit>()
                                              .changeIndex(
                                                  index: 5,
                                                  titleNp: "व्यक्तिगत विवरण",
                                                  titleEn: 'Profile');
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

                                      ListTile(
                                        onTap: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            currentIndexs = 6;
                                          });
                                          DefaultTabController.of(context)
                                              .animateTo(6);
                                          context
                                              .read<DrawerCubit>()
                                              .checkDrawerSelection(2);

                                          context
                                              .read<NavigationIndexCubit>()
                                              .changeIndex(
                                                  index: 6,
                                                  titleNp: "लक्षण मूल्याङ्कन",
                                                  titleEn:
                                                      "Symptom Assessment");
                                        },
                                        leading: Image.asset(
                                          AppAssets.symptomIcon,
                                          height: 30.sm,
                                        ),
                                        title: Text(
                                            LocaleKeys.symptom_assessment.tr(),
                                            style: theme.textTheme.titleSmall
                                                ?.copyWith(
                                                    color: state.index == 2
                                                        ? AppColors.primaryRed
                                                        : Colors.black)),
                                      ),

                                      //QR Code
                                      ListTile(
                                        onTap: (() {
                                          Navigator.pop(context);
                                          setState(() {
                                            currentIndexs = 7;
                                          });
                                          DefaultTabController.of(context)
                                              .animateTo(7);
                                          context
                                              .read<DrawerCubit>()
                                              .checkDrawerSelection(3);

                                          context
                                              .read<NavigationIndexCubit>()
                                              .changeIndex(
                                                  index: 7,
                                                  titleNp: "QR कोड",
                                                  titleEn: "QR Code");
                                        }),
                                        leading: Image.asset(
                                          AppAssets.cardIcon,
                                          height: 30.sm,
                                        ),
                                        title: Text(LocaleKeys.qr_code.tr(),
                                            style: theme.textTheme.titleSmall
                                                ?.copyWith(
                                                    color: state.index == 3
                                                        ? AppColors.primaryRed
                                                        : Colors.black)),
                                      ),
                                      Visibility(
                                        visible: newsFeedState is NewsfeedSuccess
                                      ? newsFeedState
                                          .newsfeed.userDetail.userMode !=
                                        "women_health" ? true : false : true,
                                        child: ExpansionTile(
                                          initiallyExpanded:
                                              (state.index! > 4 &&
                                                      state.index! < 10)
                                                  ? true
                                                  : false,
                                          leading: Image.asset(
                                            AppAssets.healthreportIcon,
                                            height: 30.sm,
                                          ),
                                          title: Text(
                                              LocaleKeys.health_reports.tr(),
                                              style:
                                                  theme.textTheme.titleSmall),
                                          children: [
                                            ListTile(
                                              onTap: () {
                                                // Navigator.of(context).push(
                                                //     MaterialPageRoute(
                                                //         builder: (context) => AncsPage()));
                                                Navigator.pop(context);
                                                setState(() {
                                                  currentIndexs = 8;
                                                });
                                                DefaultTabController.of(context)
                                                    .animateTo(8);
                                                context
                                                    .read<DrawerCubit>()
                                                    .checkDrawerSelection(4);

                                                context
                                                    .read<
                                                        NavigationIndexCubit>()
                                                    .changeIndex(
                                                        index: 8,
                                                        titleNp:
                                                            'गर्भवस्था जाँच',
                                                        titleEn: 'ANC');
                                                context
                                                    .read<GetUserCubit>()
                                                    .getUserData();
                                              },
                                              title: Padding(
                                                padding: REdgeInsets.only(
                                                    left: 80, right: 20),
                                                child: Text(LocaleKeys.anc.tr(),
                                                    style: theme
                                                        .textTheme.titleSmall
                                                        ?.copyWith(
                                                            color: state.index ==
                                                                    4
                                                                ? AppColors
                                                                    .primaryRed
                                                                : Colors
                                                                    .black)),
                                              ),
                                            ),
                                            ListTile(
                                              onTap: () {
                                                context
                                                    .read<DrawerCubit>()
                                                    .checkDrawerSelection(5);
                                                Navigator.pop(context);
                                                setState(() {
                                                  currentIndexs = 9;
                                                });
                                                DefaultTabController.of(context)
                                                    .animateTo(9);
                                                context
                                                    .read<
                                                        NavigationIndexCubit>()
                                                    .changeIndex(
                                                        titleNp: 'सुत्केरी',
                                                        index: 9,
                                                        titleEn: 'Delivery');
                                                context
                                                    .read<GetUserCubit>()
                                                    .getUserData();
                                              },
                                              title: Padding(
                                                padding: REdgeInsets.only(
                                                    left: 80, right: 20),
                                                child: Text(
                                                    LocaleKeys.delivery.tr(),
                                                    style: theme
                                                        .textTheme.titleSmall
                                                        ?.copyWith(
                                                            color: state.index ==
                                                                    5
                                                                ? AppColors
                                                                    .primaryRed
                                                                : Colors
                                                                    .black)),
                                              ),
                                            ),
                                            ListTile(
                                              onTap: () {
                                                context
                                                    .read<DrawerCubit>()
                                                    .checkDrawerSelection(6);
                                                Navigator.pop(context);
                                                setState(() {
                                                  currentIndexs = 10;
                                                });
                                                DefaultTabController.of(context)
                                                    .animateTo(10);
                                                context
                                                    .read<
                                                        NavigationIndexCubit>()
                                                    .changeIndex(
                                                        titleNp: 'औषधि सेवा',
                                                        index: 10,
                                                        titleEn: 'Medication');
                                                context
                                                    .read<GetUserCubit>()
                                                    .getUserData();
                                              },
                                              title: Padding(
                                                padding: REdgeInsets.only(
                                                    left: 80, right: 20),
                                                child: Text(
                                                    LocaleKeys.medication.tr(),
                                                    style: theme
                                                        .textTheme.titleSmall
                                                        ?.copyWith(
                                                            color: state.index ==
                                                                    6
                                                                ? AppColors
                                                                    .primaryRed
                                                                : Colors
                                                                    .black)),
                                              ),
                                            ),
                                            ListTile(
                                              onTap: () {
                                                context
                                                    .read<DrawerCubit>()
                                                    .checkDrawerSelection(7);
                                                Navigator.pop(context);
                                                setState(() {
                                                  currentIndexs = 11;
                                                });
                                                DefaultTabController.of(context)
                                                    .animateTo(11);
                                                context
                                                    .read<
                                                        NavigationIndexCubit>()
                                                    .changeIndex(
                                                        titleNp:
                                                            'सुत्केरी जाँच',
                                                        index: 11,
                                                        titleEn:
                                                            'Postnatal Care');
                                                context
                                                    .read<GetUserCubit>()
                                                    .getUserData();
                                              },
                                              title: Padding(
                                                padding: REdgeInsets.only(
                                                    left: 80, right: 20),
                                                child: Text(LocaleKeys.pnc.tr(),
                                                    style: theme
                                                        .textTheme.titleSmall
                                                        ?.copyWith(
                                                            color: state.index ==
                                                                    7
                                                                ? AppColors
                                                                    .primaryRed
                                                                : Colors
                                                                    .black)),
                                              ),
                                            ),
                                            ListTile(
                                              onTap: () {
                                                context
                                                    .read<DrawerCubit>()
                                                    .checkDrawerSelection(8);
                                                Navigator.pop(context);
                                                setState(() {
                                                  currentIndexs = 12;
                                                });
                                                DefaultTabController.of(context)
                                                    .animateTo(12);
                                                context
                                                    .read<
                                                        NavigationIndexCubit>()
                                                    .changeIndex(
                                                        titleNp:
                                                            'प्रयोगशाला परिक्षण ',
                                                        index: 12,
                                                        titleEn: 'Lab Test');
                                                context
                                                    .read<GetUserCubit>()
                                                    .getUserData();
                                              },
                                              title: Padding(
                                                padding: REdgeInsets.only(
                                                    left: 80, right: 20),
                                                child: Text(
                                                    LocaleKeys.lab_test.tr(),
                                                    style: theme
                                                        .textTheme.titleSmall
                                                        ?.copyWith(
                                                            color: state.index ==
                                                                    8
                                                                ? AppColors
                                                                    .primaryRed
                                                                : Colors
                                                                    .black)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //health Report

                                      ListTile(
                                        onTap: (() {
                                          Navigator.pop(context);
                                          setState(() {
                                            currentIndexs = 4;
                                          });
                                          DefaultTabController.of(context)
                                              .animateTo(4);
                                          context
                                              .read<DrawerCubit>()
                                              .checkDrawerSelection(9);

                                          context
                                              .read<NavigationIndexCubit>()
                                              .changeIndex(
                                                  index: 4,
                                                  titleNp:
                                                      "अपोइन्टमेन्ट बुकिङ",
                                                  titleEn:
                                                      "Appointment Booking");
                                        }),
                                        leading: Image.asset(
                                          AppAssets.appoitnmentIcon,
                                          height: 30.sm,
                                        ),
                                        title: Text(LocaleKeys.label_appointment_booking.tr(),
                                            style: theme.textTheme.titleSmall
                                                ?.copyWith(
                                                    color: state.index == 9
                                                        ? AppColors.primaryRed
                                                        : Colors.black)),
                                      ),
                                      ListTile(
                                        onTap: () {
                                          context
                                              .read<DrawerCubit>()
                                              .checkDrawerSelection(10);
                                          Navigator.pop(context);
                                          setState(() {
                                            currentIndexs = 13;
                                          });
                                          DefaultTabController.of(context)
                                              .animateTo(13);
                                          context
                                              .read<NavigationIndexCubit>()
                                              .changeIndex(
                                                  titleNp:
                                                      'अपोइन्टमेन्ट हिस्ट्रि',
                                                  index: 13,
                                                  titleEn:
                                                      'Appointment History');
                                        },
                                        leading: Image.asset(
                                          AppAssets.faqsIcon,
                                          height: 30.sm,
                                        ),
                                        title: Text(LocaleKeys.label_appointment_history.tr(),
                                            style: theme.textTheme.titleSmall
                                                ?.copyWith(
                                                    color: state.index == 10
                                                        ? AppColors.primaryRed
                                                        : Colors.black)),
                                      ),

                                      //faq button
                                      ListTile(
                                        onTap: () {
                                          context
                                              .read<DrawerCubit>()
                                              .checkDrawerSelection(11);
                                          Navigator.pop(context);
                                          setState(() {
                                            currentIndexs = 14;
                                          });
                                          DefaultTabController.of(context)
                                              .animateTo(14);
                                          context
                                              .read<NavigationIndexCubit>()
                                              .changeIndex(
                                                  titleNp:
                                                      'बारम्बार सोधिने प्रश्नहरू',
                                                  index: 14,
                                                  titleEn: 'FAQs');
                                        },
                                        leading: Image.asset(
                                          AppAssets.faqsIcon,
                                          height: 30.sm,
                                        ),
                                        title: Text(LocaleKeys.faqs.tr(),
                                            style: theme.textTheme.titleSmall
                                                ?.copyWith(
                                                    color: state.index == 11
                                                        ? AppColors.primaryRed
                                                        : Colors.black)),
                                      ),
                                      //log out button
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                          padding: REdgeInsets.only(left: 12.0),
                                          child: TextButton.icon(
                                              label: Text(
                                                LocaleKeys.label_logout.tr(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                              onPressed: () {
                                                context
                                                    .read<
                                                        NavigationIndexCubit>()
                                                    .changeIndex(
                                                        titleNp: "होम",
                                                        index: 0,
                                                        titleEn: 'Home');
                                                context
                                                    .read<DrawerCubit>()
                                                    .checkDrawerSelection(0);
                                                Navigator.pop(context);

                                                context
                                                    .read<LoggedOutCubit>()
                                                    .logout();
                                              },
                                              icon: const Icon(Icons.logout,
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

int differenceInCalendarDays(DateTime later, DateTime earlier) {
  // Normalize [DateTime] objects to UTC and to discard time information.

  return later.difference(earlier).inDays;
}
