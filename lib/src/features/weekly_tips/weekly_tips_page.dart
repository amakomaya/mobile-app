import 'package:aamako_maya/src/core/connection_checker/network_connection.dart';
import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/snackbar/error_snackbar.dart';
import 'package:aamako_maya/src/core/snackbar/success_snackbar.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/features/weekly_tips/cubit/weekly_tips_cubit.dart';
import 'package:aamako_maya/src/features/weekly_tips/model/weekly_tips_model.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import '../../../injection_container.dart';
import '../../core/cache/weekly_cache/cache_values.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/drawer/drawer_widget.dart';
import '../fetch user data/cubit/get_user_cubit.dart';

class WeeklyTipsPage extends StatefulWidget {
  const WeeklyTipsPage({Key? key}) : super(key: key);

  @override
  State<WeeklyTipsPage> createState() => _WeeklyTipsPageState();
}

class _WeeklyTipsPageState extends State<WeeklyTipsPage> {
  @override
  void initState() {
    context.read<WeeklyTipsCubit>().getWeeklyTips(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<WeeklyTipsCubit, WeeklyTipsState>(
        builder: (ctx, state) {
      if (state is WeeklyTipsSucces) {
        final list = state.data;
        final bool isEnglish =
            EasyLocalization.of(context)?.currentLocale?.languageCode == 'en';
        return RefreshIndicator(
          onRefresh: () async {
            if (await sl<NetworkInfo>().isConnected) {
              context.read<WeeklyTipsCubit>().getWeeklyTips(true);
            } else {
              BotToast.showText(text: 'No Internet Connection !');
            }
          },
          child: BlocBuilder<GetUserCubit, GetUserState>(
            builder: (userCt, userStat) {
              WeeklyTips? _weeks;
              List<WeeklyTips> listOfWeekly;

              if (userStat is GetUserSuccess) {
                final date = DateTime.parse(userStat.user.lmpDateNp ?? '');

                DateTime earlier =
                    DateTime.utc(date.year, date.month, date.day);
                final later = DateTime.utc(NepaliDateTime.now().year,
                    NepaliDateTime.now().month, NepaliDateTime.now().day);
                int day = differenceInCalendarDays(later, earlier);

                int weekId = day ~/ 7;

                _weeks =
                    state.data.firstWhere((element) => element.weekId == weekId,
                        orElse: () => WeeklyTips(
                              id: -1,
                              titleEn: '',
                              titleNp: '',
                              descriptionEn: '',
                              descriptionNp: '',
                              weekId: 0,
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                            ));
              }

              return SingleChildScrollView(
                primary: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    VerticalSpace(10.h),
                    Padding(
                      padding: defaultPadding,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'This week tips',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontSize: 20
                          ),
                        ),
                      ),
                    ),
                    VerticalSpace(10.h),
                    ShadowContainer(
                      width: 380.w,
                        radius: 30,
                      padding: defaultPadding.copyWith(top: 10.h, bottom: 20.h),
                      child: _weeks?.id != -1
                          ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    isEnglish
                                        ? (_weeks?.titleEn ?? '')
                                        : (_weeks?.titleNp ?? ''),
                                    style: theme.textTheme.labelMedium),
                                   Divider(
                                      height: 15.w,
                                      color: AppColors.accentGrey,
                                    ),
                                Html(data: _weeks?.descriptionEn)
                              ],
                            )
                          : Center(
                              child: Text(
                                'No Tips Found!',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                    ),
                    VerticalSpace(10.h),
                     Padding(
                      padding: defaultPadding,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Other week tips',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontSize: 20
                          ),
                        ),
                      ),
                    ),
                    ListView.separated(
                        padding: defaultPadding.copyWith(bottom: 25.h),
                        primary: false,
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              VerticalSpace(20.h),
                              ShadowContainer(
                                radius: 30,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        isEnglish
                                            ? (list[index].titleEn)
                                            : (list[index].titleNp),
                                        style: theme.textTheme.labelMedium),
                                    Divider(
                                      height: 15.w,
                                      color: AppColors.accentGrey,
                                    ),
                                    // Html(
                                    //   data: (list[index].descriptionNp),
                                    //   onImageError: (sd, f) {},
                                    //   customRenders: {

                                    //   },
                                    // )
                                    Html(
                                        // data: <span>Some normal HTML</span> then appears a <customtag>Some data in this one</customtag>,
                                        data: isEnglish
                                            ? list[index].descriptionEn
                                            : list[index].descriptionNp,
                                        tagsList: Html.tags..addAll(['img']),
                                        customRenders: {
                                          customTagMatcher():
                                              CustomRender.widget(widget:
                                                  (context, buildChildren) {
                                            final element =
                                                context.tree.element!;

                                            // Your conditions with the element.
                                            // finally return your own custom widget:
                                            return Builder(builder: (context) {
                                              // return Image.network(element.attributes['src']??'');
                                              return CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                    element.attributes['src'] ??
                                                        '',
                                                placeholder: (ctx, url) =>
                                                    Container(
                                                  height: 100.h,
                                                  width: 100.w,
                                                  color: AppColors.accentGrey,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              );
                                            });
                                          }),
                                        }),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (ctx, index) => VerticalSpace(20.h),
                        itemCount: list.length)
                  ],
                ),
              );
            },
          ),
        );
      } else {
        return ShimmerLoading(boxHeight: 500.h, itemCount: 2);
      }
    }, listener: (state, cs) {
      if (cs is WeeklyTipsSucces && cs.isRefreshed) {
        BotToast.showText(text: 'Weekly Tips Successfully Refreshed');
      }
    });
  }
}

CustomRenderMatcher customTagMatcher() =>
    (context) => context.tree.element?.localName == 'img';
