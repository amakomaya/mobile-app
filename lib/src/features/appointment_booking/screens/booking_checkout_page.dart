import 'package:Amakomaya/src/core/padding/padding.dart';
import 'package:Amakomaya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:Amakomaya/src/features/appointment_booking/fonepay_payment/fonepay_payment_cubit.dart';
import 'package:Amakomaya/src/features/appointment_booking/model/booking_model.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/buttons/primary_action_button.dart';
import '../fonepay_payment/fonepay_webview.dart';

class BookingCheckoutPage extends StatefulWidget {
  final BookingModel data;

  const BookingCheckoutPage(this.data, {Key? key}) : super(key: key);

  @override
  State<BookingCheckoutPage> createState() => _BookingCheckoutPageState();
}

class _BookingCheckoutPageState extends State<BookingCheckoutPage> {
  var isFonePay = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryRed,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20.r,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              LocaleKeys.label_checkout.tr(),
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          body: BlocConsumer<FonePayPaymentCubit, FonePayPaymentState>(
            listener: (context, state) {
              if (state is FonePayPaymentLoading) {
                BotToast.showText(text:   LocaleKeys.label_connect_fonepay.tr());
                BotToast.showLoading();

              } else if (state is FonePayPaymentFailure) {
                BotToast.closeAllLoading();
                BotToast.showText(text: "Server Error");
              } else if (state is FonePayPaymentSuccess) {
                BotToast.closeAllLoading();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>
                        FonePayWebViewPage(state.responseBody)));
              } else {
                BotToast.closeAllLoading();
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                padding: defaultPadding.copyWith(top: 27.h, bottom: 27.h),
                child: Column(
                  children: [
                    Text(LocaleKeys.label_personal_information.tr(),
                        style: TextStyle(
                            fontFamily: "lato",
                            color: AppColors.primaryRed,
                            fontSize: 17.sm)),
                    SizedBox(height: 10.h),
                    ShadowContainer(
                      radius: 20.r,
                      width: 380.w,
                      color: Colors.white,
                      padding: defaultPadding.copyWith(top: 10.h, bottom: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(LocaleKeys.label_first_name.tr(),
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: theme.textTheme.labelSmall),
                            ),
                            trailing: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Text(
                                  widget.data.firstName.isEmpty
                                      ? "N/A"
                                      : widget.data.firstName,
                                  maxLines: 2,
                                  textAlign: TextAlign.end,
                                  style: theme.textTheme.labelSmall),
                            ),
                          ),
                          ListTile(
                            leading: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(LocaleKeys.label_middle_name.tr(),
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: theme.textTheme.labelSmall),
                            ),
                            trailing: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Text(
                                  widget.data.middleName.isEmpty
                                      ? "N/A"
                                      : widget.data.middleName,
                                  maxLines: 2,
                                  textAlign: TextAlign.end,
                                  style: theme.textTheme.labelSmall),
                            ),
                          ),
                          ListTile(
                            leading: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(LocaleKeys.label_last_name.tr(),
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: theme.textTheme.labelSmall),
                            ),
                            trailing: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Text(
                                  widget.data.lastName.isEmpty
                                      ? "N/A"
                                      : widget.data.lastName,
                                  maxLines: 2,
                                  textAlign: TextAlign.end,
                                  style: theme.textTheme.labelSmall),
                            ),
                          ),
                          ListTile(
                            leading: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(LocaleKeys.label_dob.tr(),
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: theme.textTheme.labelSmall),
                            ),
                            trailing: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Text(
                                  widget.data.dob.isEmpty
                                      ? "N/A"
                                      : widget.data.dob,
                                  maxLines: 2,
                                  textAlign: TextAlign.end,
                                  style: theme.textTheme.labelSmall),
                            ),
                          ),
                          ListTile(
                            leading: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(LocaleKeys.label_gender.tr(),
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: theme.textTheme.labelSmall),
                            ),
                            trailing: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Text(
                                  widget.data.gender.isEmpty
                                      ? "N/A"
                                      : widget.data.gender,
                                  maxLines: 2,
                                  textAlign: TextAlign.end,
                                  style: theme.textTheme.labelSmall),
                            ),
                          ),
                          ListTile(
                            leading: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(LocaleKeys.label_email.tr(),
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: theme.textTheme.labelSmall),
                            ),
                            trailing: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Text(
                                  widget.data.email.isEmpty
                                      ? "N/A"
                                      : widget.data.email,
                                  maxLines: 2,
                                  textAlign: TextAlign.end,
                                  style: theme.textTheme.labelSmall),
                            ),
                          ),
                          ListTile(
                            leading: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(LocaleKeys.label_mobile_num.tr(),
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: theme.textTheme.labelSmall),
                            ),
                            trailing: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Text(
                                  widget.data.mobile.isEmpty
                                      ? "N/A"
                                      : widget.data.mobile,
                                  maxLines: 2,
                                  textAlign: TextAlign.end,
                                  style: theme.textTheme.labelSmall),
                            ),
                          ),
                          ListTile(
                            leading: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(LocaleKeys.label_province.tr(),
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: theme.textTheme.labelSmall),
                            ),
                            trailing: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Text(
                                  widget.data.provienceName.isEmpty
                                      ? "N/A"
                                      : widget.data.provienceName,
                                  maxLines: 2,
                                  textAlign: TextAlign.end,
                                  style: theme.textTheme.labelSmall),
                            ),
                          ),
                          ListTile(
                            leading: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(LocaleKeys.label_distrct.tr(),
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: theme.textTheme.labelSmall),
                            ),
                            trailing: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Text(
                                  widget.data.districtName.isEmpty
                                      ? "N/A"
                                      : widget.data.districtName,
                                  maxLines: 2,
                                  textAlign: TextAlign.end,
                                  style: theme.textTheme.labelSmall),
                            ),
                          ),
                          ListTile(
                            leading: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(LocaleKeys.lable_municipality_vdc.tr(),
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: theme.textTheme.labelSmall),
                            ),
                            trailing: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Text(
                                  widget.data.municipalityName.isEmpty
                                      ? "N/A"
                                      : widget.data.municipalityName,
                                  maxLines: 2,
                                  textAlign: TextAlign.end,
                                  style: theme.textTheme.labelSmall),
                            ),
                          ),
                          ListTile(
                            leading: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(LocaleKeys.ward_no.tr(),
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: theme.textTheme.labelSmall),
                            ),
                            trailing: Text(
                                widget.data.wardNo.isEmpty
                                    ? "N/A"
                                    : widget.data.wardNo,
                                maxLines: 2,
                                textAlign: TextAlign.end,
                                style: theme.textTheme.labelSmall),
                          ),
                          ListTile(
                            leading: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(LocaleKeys.lable_tole.tr(),
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: theme.textTheme.labelSmall),
                            ),
                            trailing: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Text(
                                  widget.data.tole.isEmpty
                                      ? "N/A"
                                      : widget.data.tole,
                                  maxLines: 2,
                                  textAlign: TextAlign.end,
                                  style: theme.textTheme.labelSmall),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(LocaleKeys.label_amount.tr(),
                        style: TextStyle(
                            fontFamily: "lato",
                            color: AppColors.primaryRed,
                            fontSize: 17.sm)),
                    SizedBox(height: 10.h),
                    ShadowContainer(
                      radius: 20.r,
                      width: 380.w,
                      color: Colors.white,
                      padding: defaultPadding.copyWith(top: 10.h, bottom: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(LocaleKeys.label_total_amount.tr(),
                                style: theme.textTheme.labelSmall),
                            trailing: Text(
                                widget.data.totalPayableAmount.toString(),
                                style: theme.textTheme.labelSmall),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(LocaleKeys.label_paying_method.tr(),
                        style: TextStyle(
                            fontFamily: "lato",
                            color: AppColors.primaryRed,
                            fontSize: 17.sm)),
                    SizedBox(height: 10.h),
                    SwitchWidget(
                        onTap: () {
                          isFonePay = true;
                          setState(() {});
                        },
                        type: isFonePay,
                        label: LocaleKeys.label_fone_pay.tr()),
                    SizedBox(height: 10.h),
                    Text(LocaleKeys.label_terms_conditions.tr(),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(height: 10.h),
                    PrimaryActionButton(
                        height: 70.h,
                        onpress: () async {
                          context
                              .read<FonePayPaymentCubit>()
                              .requestFonePayPayment(
                                  requestModel: BookingModel(
                                firstName: widget.data.firstName,
                                middleName: widget.data.middleName,
                                lastName: widget.data.lastName,
                                dob: widget.data.dob,
                                gender: widget.data.gender,
                                email: widget.data.email,
                                mobile: widget.data.mobile,
                                provienceName: widget.data.provienceName,
                                districtName: widget.data.districtName,
                                municipalityName: widget.data.municipalityName,
                                wardNo: widget.data.wardNo,
                                tole: widget.data.tole,
                                bookingType: widget.data.bookingType,
                                clinetId: widget.data.clinetId,
                                appointmentDate: widget.data.appointmentDate,
                                schemeType: widget.data.schemeType  ,
                                id: widget.data.id,
                                totalPayableAmount:
                                    widget.data.totalPayableAmount,
                              ));
                        },
                        title: LocaleKeys.label_confirm_pay.tr()),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class SwitchWidget extends StatelessWidget {
  const SwitchWidget(
      {Key? key, required this.type, required this.label, required this.onTap})
      : super(key: key);

  final bool type;
  final String label;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          type
              ? Icon(
                  Icons.radio_button_checked,
                  color: AppColors.primaryRed.withOpacity(0.7),
                )
              : const Icon(
                  Icons.radio_button_off,
                  color: Colors.grey,
                ),
          SizedBox(
            width: 10.w,
          ),
          Text(label), //Growth of Child
        ],
      ),
    );
  }
}
