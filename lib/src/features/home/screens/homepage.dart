import 'package:aamako_maya/src/features/home/screens/home_video_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:aamako_maya/src/core/app_assets/app_assets.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';

import 'package:aamako_maya/src/features/authentication/drawer_cubit/drawer_cubit.dart';
import 'package:aamako_maya/src/features/home/cubit/newsfeed_cubit.dart';
import 'package:aamako_maya/src/features/home/screens/home_audio_player.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../injection_container.dart';
import '../../../../l10n/locale_keys.g.dart';
import '../../../core/connection_checker/network_connection.dart';
import '../../../core/padding/padding.dart';
import '../../../core/widgets/drawer/drawer_widget.dart';
import '../../../core/widgets/popup_confirmation_page.dart';
import '../../bottom_nav/cubit/cubit/navigation_index_cubit.dart';
import '../../fetch user data/cubit/get_user_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CustomRenderMatcher customTagMatcher(String sff) => (context) {
        String text = sff;
        String link = '';
        final urlRegExp = RegExp(
            r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");
        final urlMatches = urlRegExp.allMatches(text);
        List<String> urls = urlMatches
            .map((urlMatch) => text.substring(urlMatch.start, urlMatch.end))
            .toList();
        for (var x in urls) {
          link = x;
        }

        return link.isNotEmpty;
      };

  checkInternet() async {
    if (await sl<NetworkInfo>().isConnected) {
      context.read<NewsfeedCubit>().getNewsFeed(true);
    } else {
      context.read<NewsfeedCubit>().getNewsFeed(false);
      BotToast.showText(text: LocaleKeys.no_internet_connection.tr());
    }
  }

  @override
  void initState() {
    checkInternet();
    context.read<GetUserCubit>().getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: '1',
        child: const Icon(
          Icons.phone_in_talk,
          color: Colors.white,
        ),
        onPressed: () {
          // phoneCall();
          launchDialer('9761663394');
        },
      ),
      body: BlocConsumer<NewsfeedCubit, NewsfeedState>(
        listener: (context, state) {
          print("statet $state");
          if (state is NewsfeedSuccess && state.isRefreshed) {
            BotToast.showText(text: LocaleKeys.msg_refresh_success.tr());
          }
        },
        builder: (ct, st) {
          if (st is NewsfeedSuccess) {
            return RefreshIndicator(
              onRefresh: () async {
                checkInternet();
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    BlocConsumer<GetUserCubit, GetUserState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        var name = "";
                        var day = "";
                        var weeks = "";
                        var days = "";
                        var remainingDays = "";
                        var expectedDeliveryDate = "";
                        if (state is GetUserSuccess) {
                          name = state.user.name ?? "";
                          final date =
                              DateTime.parse(state.user.lmpDateNp ?? '');
                          DateTime earlier =
                              DateTime.utc(date.year, date.month, date.day);
                          DateTime expectedDate =
                              earlier.add(Duration(days: 280));
                          expectedDeliveryDate =
                              DateFormat('yyyy-MM-dd').format(expectedDate);
                          final later = DateTime.utc(
                              NepaliDateTime.now().year,
                              NepaliDateTime.now().month,
                              NepaliDateTime.now().day);
                          day = differenceInCalendarDays(later, earlier)
                              .toString();
                          remainingDays =
                              differenceInCalendarDays(expectedDate, later)
                                  .toString();
                          weeks = ((int.parse(day) % 365) / 7).toStringAsFixed(0);
                          days =( (int.parse(day) % 365) % 7 ).toString();
                          return Stack(
                            children: [
                              Container(
                                alignment: Alignment.topCenter,
                                margin: EdgeInsets.only(top: 50),
                                child: ShadowContainer(
                                    radius: 25.r,
                                    color: Colors.white,
                                    width: 380.w,
                                    child: Column(children: [
                                      Container(
                                        padding: REdgeInsets.fromLTRB(
                                            10, 20, 10, 20),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25.r),
                                              topRight: Radius.circular(25.r)),
                                          color: Colors.grey[100],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              name,
                                              style: TextStyle(
                                                fontSize: 26.sm,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              "$weeks ${LocaleKeys.label_week.tr()} $days ${LocaleKeys.label_day.tr()}",
                                              style: TextStyle(
                                                fontSize: 16.sm,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        padding: REdgeInsets.fromLTRB(
                                            40, 10, 30, 20),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(25.r),
                                              bottomRight:
                                                  Radius.circular(25.r)),
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(children: [
                                              Text(
                                                remainingDays,
                                                style: TextStyle(
                                                    fontSize: 16.sm,
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 4.h),
                                              Text(
                                                LocaleKeys.label_remaining_date.tr(),
                                                style: TextStyle(
                                                    fontSize: 16.sm,
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ]),
                                            Column(children: [
                                              Text(
                                                expectedDeliveryDate,
                                                style: TextStyle(
                                                    fontSize: 16.sm,
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 4.h),
                                              Text(
                                                LocaleKeys.label_expected_date.tr(),
                                                style: TextStyle(
                                                    fontSize: 16.sm,
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ])
                                          ],
                                        ),
                                      )
                                    ])),
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                child: Image.asset(
                                  'assets/images/logo/profile.png',
                                  height: 80.sm,
                                  width: 80.sm,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                    SizedBox(height: 10.h),
                    InkWell(
                      onTap: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext userCtx) {
                              return PopUpConfirmation(
                                message: LocaleKeys.label_ask_call.tr(),
                                onConfirmed: () {
                                  Navigator.pop(context);
                                  phoneCall();
                                },
                              );
                            });
                      },
                      child: Container(
                        margin:
                            REdgeInsets.only(top: 20.h, left: 12, right: 12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColors.lightShadePink,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.darkShadePink,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      topLeft: Radius.circular(20))),
                              child: Padding(
                                padding: REdgeInsets.all(20.0),
                                child: SvgPicture.asset(
                                  'assets/images/tollfreecall.svg',
                                  height: 40.h,
                                  width: 40.w,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    LocaleKeys.label_for_pregnancy_counsleing.tr(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.darkShadePink,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding:
                                          REdgeInsets.fromLTRB(16, 8, 16, 8),
                                      child: Text(
                                        LocaleKeys.label_click_call.tr(),
                                        style: TextStyle(
                                          letterSpacing: 1,
                                          fontSize: 18.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // width: 350.w,
                      // height: 350.h,
                    ),
                    SizedBox(height: 10.h),
                    InkWell(
                      onTap: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext userCtx) {
                              return PopUpConfirmation(
                                message:  LocaleKeys.label_ask_message.tr(),
                                onConfirmed: () {
                                  Navigator.pop(context);
                                  context
                                      .read<DrawerCubit>()
                                      .checkDrawerSelection(3);

                                  context
                                      .read<NavigationIndexCubit>()
                                      .changeIndex(
                                          index: 13,
                                          titleNp: "लक्षण मूल्याङ्कन",
                                          titleEn: "Symptom Assessment");
                                },
                              );
                            });
                      },
                      child: Container(
                        margin:
                            REdgeInsets.only(top: 10.h, left: 12, right: 12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColors.lightShadeOrange,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.darkShadeOrange,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      topLeft: Radius.circular(20))),
                              child: Padding(
                                padding: REdgeInsets.all(20.0),
                                child: SvgPicture.asset(
                                  'assets/images/message.svg',
                                  height: 40.h,
                                  width: 40.w,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text("${LocaleKeys.label_for_pregnancy_probelm.tr()} \n ${LocaleKeys.label_click_message.tr()}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // width: 350.w,
                    ),
                    BlocConsumer<GetUserCubit, GetUserState>(
                      listener: (userCtx, userState) {
                        if (userState is GetUserSuccess) {
                          print(userState.user.tole);
                          print(userState.user.name);
                          print(userState.user.lmpDateNp);
                          print(userState.user.bloodGroup);
                          print(userState.user.provinceName);
                          print(userState.user.districtName);
                          print(userState.user.municipalityName);
                          print(userState.user.ward);
                          print(userState.user.phone);
                          print(userState.user.haveDiseasePreviously);
                          print(userState.user.pregnantTimes);
                          print(userState.user.height);
                          print(userState.user.currentHealthPost);
                          print(userState.user.modeType);
                          print(userState.user.husbandName);
                          print(userState.user.age);
                          if ((userState.user.tole?.isEmpty ?? true) ||
                              userState.user.tole == null ||
                              (userState.user.name?.isEmpty ?? true) ||
                              userState.user.name == null ||
                              (userState.user.lmpDateNp?.isEmpty ?? true) ||
                              userState.user.lmpDateNp == null ||
                              (userState.user.bloodGroup?.isEmpty ?? true) ||
                              userState.user.bloodGroup == null ||
                              (userState.user.provinceName?.isEmpty ?? true) ||
                              userState.user.provinceName == null ||
                              (userState.user.districtName?.isEmpty ?? true) ||
                              userState.user.districtName == null ||
                              (userState.user.municipalityName?.isEmpty ?? true) ||
                              userState.user.municipalityName == null ||
                              (userState.user.ward?.isEmpty ?? true) ||
                              userState.user.ward == null ||
                              (userState.user.phone?.isEmpty ?? true) ||
                              userState.user.phone == null ||
                              (userState.user.haveDiseasePreviously?.isEmpty ?? true) ||
                              userState.user.haveDiseasePreviously == null ||
                              (userState.user.pregnantTimes==0) ||
                              userState.user.pregnantTimes == null ||
                              (userState.user.height?.isEmpty ?? true) ||
                              userState.user.height == null ||
                              (userState.user.husbandName?.isEmpty ?? true) ||
                              userState.user.husbandName == null ||
                              (userState.user.currentHealthPost?.isEmpty ?? true) ||
                              userState.user.currentHealthPost == null ||
                              (userState.user.modeType?.isEmpty ?? true) ||
                              userState.user.modeType == null ||
                              (userState.user.age== 0 ) ||
                              userState.user.age == null) {
                            WidgetsBinding.instance
                                ?.addPostFrameCallback((_) async {
                              await showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext userCtx) {
                                    return PopUpConfirmation(
                                      forProfileFill: true,
                                      message: LocaleKeys
                                          .error_msg_not_complete_profile
                                          .tr(),
                                      onConfirmed: () {
                                        Navigator.pop(context);
                                        context
                                            .read<DrawerCubit>()
                                            .checkDrawerSelection(1);
                                        context
                                            .read<NavigationIndexCubit>()
                                            .changeIndex(
                                                index: 10,
                                                titleEn: "Profile",
                                                titleNp: "व्यक्तिगत विवरण");
                                      },
                                    );
                                  });
                            });
                          }
                        }
                      },
                      builder: (userCtx, userState) {
                        return Visibility(
                          visible: false,
                          child: ShadowContainer(
                              color: const Color.fromARGB(255, 221, 77, 77),
                              margin: EdgeInsets.only(top: 10.h),
                              padding: defaultPadding.copyWith(
                                  top: 10.h, bottom: 10.h),
                              width: 380.w,
                              child: RichText(
                                  text: TextSpan(
                                      text: LocaleKeys
                                          .error_msg_not_complete_profile
                                          .tr(),
                                      style: theme.textTheme.titleSmall
                                          ?.copyWith(color: AppColors.white),
                                      children: [
                                    TextSpan(
                                        text: LocaleKeys
                                            .msg_complete_profile_now
                                            .tr(),
                                        style: theme.textTheme.titleSmall
                                            ?.copyWith(color: AppColors.white))
                                  ]))),
                        );
                      },
                    ),
                    Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            itemBuilder: ((context, index) {
                              return Column(
                                children: [
                                  //video container
                                  Visibility(
                                    visible: (st.newsfeed[index].type == "video"),
                                    child: Column(
                                      children: [

                                        HomeVideoPlayer(
                                            st.newsfeed[index].urlToVideo ??
                                                "",st.newsfeed[index].urlToImage ??
                                            ""),
                                        SizedBox(height: 4.h,),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: REdgeInsets.only(left: 20),
                                            child: Text(
                                              st.newsfeed[index].title ?? "" ,
                                              style: TextStyle(
                                                fontSize: 20.sm,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),

                                        VerticalSpace(20.h),
                                      ],
                                    ),
                                  ),
                                  //audio container

                                  Visibility(
                                    visible: (st.newsfeed[index].type == "audio"),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeAudioPlayerPage(
                                                      image: st.newsfeed[index].urlToImage ?? "",
                                                      title:  st.newsfeed[index].title ?? "",
                                                      author: st.newsfeed[index].author ?? "" ,
                                                      audioUrl: st
                                                              .newsfeed[index]
                                                              .url ??
                                                          "",
                                                    )));
                                      },
                                      child: Column(
                                        children: [
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
                                                st.newsfeed[index].author ?? "",
                                                style:
                                                    theme.textTheme.labelSmall,
                                              ))
                                            ]),
                                          ),
                                          VerticalSpace(20.h),
                                        ],
                                      ),
                                    ),
                                  ),
                                  //news container
                                  Visibility(
                                    visible: (st.newsfeed[index].type =="text"),
                                    child: Column(
                                      children: [
                                        ShadowContainer(
                                          radius: 20.r,
                                          width: 380.w,
                                          color: Colors.white,
                                          padding: defaultPadding.copyWith(
                                              top: 10.h, bottom: 10.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/logo/profile.png',
                                                    height: 80.sm,
                                                    width: 80.sm,
                                                  ),
                                                  Flexible(
                                                      child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        st.newsfeed[index]
                                                                .author ??
                                                            '',
                                                        style: theme.textTheme
                                                            .headlineMedium
                                                            ?.copyWith(
                                                                fontSize: 16.sm,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      Text(
                                                        st.newsfeed[index]
                                                                .publishedAt ??
                                                            '',
                                                        style: theme.textTheme
                                                            .labelMedium
                                                            ?.copyWith(
                                                                fontSize: 16.sm,
                                                                color: AppColors
                                                                    .accentGrey),
                                                      ),
                                                    ],
                                                  ))
                                                ],
                                              ),
                                              // VerticalSpace(20.h),

                                              //After Image is added in api
                                              // CachedNetworkImage(
                                              //   fit: BoxFit.cover,
                                              //   imageUrl:
                                              //       state.newsfeed[index].urlToImage ??
                                              //           '',
                                              //   placeholder: (ctx, url) => Container(
                                              //     height: 380.h,
                                              //     width: 380.w,
                                              //     color: AppColors.grey,
                                              //   ),
                                              //   errorWidget: (context, url, error) =>
                                              //       const Icon(
                                              //     Icons.error,
                                              //     color: Colors.black,
                                              //   ),
                                              // ),
                                              VerticalSpace(4.h),
                                              Text(
                                                st.newsfeed[index].title ?? "" ,
                                                style: TextStyle(
                                                  fontSize: 20.sm,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              VerticalSpace(4.h),
                                              Html(
                                                  data:
                                                      st.newsfeed[index].desc,
                                                  style: {
                                                    "h2": Style(
                                                        fontSize:
                                                            FontSize(16.0.sm),
                                                        fontWeight:
                                                            FontWeight.normal)
                                                  },
                                                  customRenders: {
                                                    customTagMatcher(st
                                                                .newsfeed[index]
                                                                .desc ??
                                                            ''):
                                                        CustomRender.widget(
                                                            widget: (ctx,
                                                                buildChildren) {
                                                      final element = ctx
                                                          .tree.element!.text;
                                                      String text = element;
                                                      String link =
                                                          'amakomaya.com/en';
                                                      final urlRegExp = RegExp(
                                                          r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");

                                                      final urlMatches =
                                                          urlRegExp
                                                              .allMatches(text);
                                                      List<String> urls =
                                                          urlMatches
                                                              .map((urlMatch) =>
                                                                  text.substring(
                                                                      urlMatch
                                                                          .start,
                                                                      urlMatch
                                                                          .end))
                                                              .toList();
                                                      for (var x in urls) {
                                                        link = x;
                                                      }

                                                      final htmlText = st
                                                          .newsfeed[index].desc
                                                          ?.replaceAll(
                                                              urlRegExp, ' ');

                                                      return Column(
                                                        children: [
                                                          Html(
                                                              data: htmlText,
                                                              style: {
                                                                "body": Style(
                                                                  fontSize:
                                                                      FontSize(
                                                                          16.0.sm),
                                                                )
                                                              }),
                                                          GestureDetector(
                                                            onLongPress: () {
                                                              Clipboard.setData(
                                                                      ClipboardData(
                                                                          text:
                                                                              link))
                                                                  .then(
                                                                      (value) {
                                                                BotToast.showText(
                                                                    text: LocaleKeys
                                                                        .msg_copied_to_clipboard
                                                                        .tr());
                                                              });
                                                            },
                                                            onTap: () async {
                                                              if (await canLaunchUrl(
                                                                  Uri.parse(
                                                                      link))) {
                                                                await launchUrl(
                                                                    Uri.parse(
                                                                        link));
                                                              } else {
                                                                BotToast.showText(
                                                                    text: LocaleKeys
                                                                        .error_msg_cannot_launch_url
                                                                        .tr());
                                                              }
                                                            },
                                                            child: Text(
                                                              link,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .labelMedium
                                                                  ?.copyWith(
                                                                      color: AppColors
                                                                          .primaryRed,
                                                                      fontSize:
                                                                          14.sm),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                                  })
                                            ],
                                          ),
                                        ),
                                        VerticalSpace(20.h),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                            itemCount: st.newsfeed.length),
                      ],
                    ),
                    VerticalSpace(24.h),
                  ],
                ),
              ),
            );
          } else if (st is NewsfeedFailure) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(LocaleKeys.error_msg_someting_went_wrong.tr()),
                IconButton(
                    onPressed: () async {
                      if (await sl<NetworkInfo>().isConnected) {
                        context.read<NewsfeedCubit>().getNewsFeed(true);
                      } else {
                        BotToast.showText(
                            text: LocaleKeys.no_internet_connection.tr());
                      }
                    },
                    icon: Icon(
                      Icons.refresh,
                      size: 20.sm,
                      color: Colors.black,
                    ))
              ],
            );
          } else {
            return ShimmerLoading(boxHeight: 200.h, itemCount: 4);
          }
        },
      ),
    );
  }
}

//
extension on String? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }
}

// //call method
// //for direct call
phoneCall() async {
  var url = Uri.parse("tel:+9741663662");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

//

launchDialer(String number) async {
  String url = 'tel:' + number;
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Application unable to open dialer.';
  }
}
