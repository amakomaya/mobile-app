import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../injection_container.dart';
import '../../../../l10n/locale_keys.g.dart';
import '../../../core/connection_checker/network_connection.dart';
import '../../../core/padding/padding.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/helper_widgets/blank_space.dart';
import '../../../core/widgets/helper_widgets/shadow_container.dart';
import '../../../core/widgets/loading_shimmer/shimmer_loading.dart';
import '../cubit/appointment_booking_history_cubit.dart';

class AppointmentBookingHistoryPage extends StatefulWidget {
  const AppointmentBookingHistoryPage({Key? key}) : super(key: key);

  @override
  State<AppointmentBookingHistoryPage> createState() =>
      _AppointmentBookingHistoryPageState();
}

class _AppointmentBookingHistoryPageState
    extends State<AppointmentBookingHistoryPage> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  PageController controller = PageController();

  @override
  void initState() {
    context
        .read<AppointmentBookingHistoryCubit>()
        .getAppointmentBookingHistory(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<AppointmentBookingHistoryCubit,
        AppointmentBookingHistoryState>(
      builder: (context, state) {
        return (state is AppointmentBookingHistorySuccess)
            ? RefreshIndicator(
                onRefresh: () async {
                  if (await sl<NetworkInfo>().isConnected) {
                    context
                        .read<AppointmentBookingHistoryCubit>()
                        .getAppointmentBookingHistory(true);
                  } else {
                    BotToast.showText(
                        text: LocaleKeys.no_internet_connection.tr());
                  }
                },
                child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 50.h),
                    itemBuilder: ((context, index) {
                      final data = state.data.data[index].reportData;
                      return (state.data.data.isEmpty)
                          ? Center(
                              child: Padding(
                                padding: REdgeInsets.only(top: 30.h),
                                child: Text('No Records Found!',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                        color: Colors.black, fontSize: 15.sm)),
                              ),
                            )
                          : Column(
                              children: [
                                Text(state.data.data[index].reportLabel.toUpperCase(),
                                    style: TextStyle(
                                        fontFamily: "lato",
                                        color: AppColors.primaryRed,
                                        fontSize: 17.sm)),
                                VerticalSpace(10.h),
                                ShadowContainer(
                                  radius: 20.r,
                                  width: 380.w,
                                  color: Colors.white,
                                  padding: defaultPadding.copyWith(
                                      top: 10.h, bottom: 20.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (var item in data)
                                        ListTile(
                                          title: Text(item.label,
                                              style:
                                                  theme.textTheme.labelSmall),
                                          trailing: Text(item.value,
                                              style:
                                                  theme.textTheme.labelSmall),
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
                        color: AppColors.white,
                      );
                    },
                    itemCount: state.data.data.length),
              )
            : ShimmerLoading(boxHeight: 330.h, itemCount: 4);
      },
    );
  }
}
