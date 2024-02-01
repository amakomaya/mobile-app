import 'dart:async';

import 'package:Amakomaya/l10n/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Amakomaya/src/core/padding/padding.dart';
import 'package:Amakomaya/src/core/snackbar/error_snackbar.dart';
import 'package:Amakomaya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:Amakomaya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:Amakomaya/src/features/authentication/model/register_request_model.dart';
import 'package:Amakomaya/src/features/authentication/screens/login/login_page.dart';
import 'package:Amakomaya/src/features/authentication/widgets/complete_profile_section.dart';
import 'package:Amakomaya/src/features/bottom_nav/bottom_navigation.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/buttons/localization_button.dart';
import '../../../core/widgets/buttons/primary_action_button.dart';
import '../../../core/widgets/scaffold/primary_appBar.dart';
import '../../../core/widgets/textfield/primary_textfield.dart';
import '../authentication_cubit/auth_cubit.dart';

class RegisterSection extends StatefulWidget {
  final String registerAs;
  final int selectedIndex;
  const RegisterSection({Key? key, required this.registerAs ,required this.selectedIndex}) : super(key: key);
  @override
  State<RegisterSection> createState() => _RegisterSectionState();
}

class _RegisterSectionState extends State<RegisterSection> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _lmp = TextEditingController();
  final _dobChild = TextEditingController();
  picker.NepaliDateTime? picked;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: SafeArea(
      child: Scaffold(
        body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationLoadingState) {
              BotToast.showLoading();
            } else if (state is LoginFailureState) {
              BotToast.closeAllLoading();
              BotToast.showText(text: state.error);
            } else if (state is LoginSuccessfulState) {
              BotToast.closeAllLoading();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (ctx) => const CustomBottomNavigation(),
                  ),
                  (route) => false);

              Timer(const Duration(seconds: 3), () {
                BotToast.showText(text: LocaleKeys.msg_register_success.tr());
              });
            } else {
              BotToast.closeAllLoading();
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryAppBar(
                    isUnauth: true,
                    unAuthChild: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:REdgeInsets.only(left: 18, bottom: 12),
                          child: Text("${LocaleKeys.label_register.tr()}",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                        const LocalizationButton(
                          icon: Icon(Icons.more_vert_outlined),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          VerticalSpace(40.h),
                          ShadowContainer(
                              width: size.width,
                              padding:
                                  defaultPadding.copyWith(top: 6.h, bottom: 6.h),
                              margin: defaultPadding,
                              child: TextFormField(
                                autofocus: true,
                                cursorColor: AppColors.primaryRed,
                                controller: _name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return LocaleKeys.warning_msg_name_no_empty.tr();
                                  }
                                  if (value.length < 3) {
                                    return LocaleKeys.msg_name_min_length.tr();
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelStyle:
                                      const TextStyle(color: AppColors.black),
                                  label: Text( LocaleKeys.label_name.tr()),
                                  isDense: true,
                                  border: InputBorder.none,
                                ),
                              )),
                          widget.selectedIndex==0 ?VerticalSpace(0.h): VerticalSpace(20.h),
                          widget.selectedIndex==0 ? SizedBox():ShadowContainer(
                              width: size.width,
                              padding:
                                  defaultPadding.copyWith(top: 6.h, bottom: 6.h),
                              margin: defaultPadding,
                              child: TextFormField(
                                onTap: () async {
                                  picked = await picker.showMaterialDatePicker(
                                    context: context,
                                    initialDate: picker.NepaliDateTime.now(),
                                    firstDate: picker.NepaliDateTime(2000),
                                    lastDate: picker.NepaliDateTime.now(),
                                    initialDatePickerMode: DatePickerMode.day,
                                  );

                                  if (picked != null) {
                                    widget.selectedIndex == 1?
                                    _lmp.text = formatter.format(picked!) : _dobChild.text = formatter.format(picked!) ;
                                  }
                                },
                                readOnly: true,
                                cursorColor: AppColors.primaryRed,
                                keyboardType: TextInputType.phone,
                                controller:  widget.selectedIndex == 1?  _lmp : _dobChild,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return  widget.selectedIndex == 1 ? LocaleKeys.warning_msg_lmp_no_empty.tr() : "Date of Child Birth can not be Empty";
                                  }

                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: AppColors.black),
                                  label: Text(  widget.selectedIndex == 1 ? LocaleKeys.label_lmp.tr() : "Date of Child Birth"),

                                  // enabled: false,
                                  border: InputBorder.none,
                                ),
                              )),
                          VerticalSpace(20.h),
                          ShadowContainer(
                              width: size.width,
                              padding:
                                  defaultPadding.copyWith(top: 6, bottom: 6),
                              margin: defaultPadding,
                              child: TextFormField(
                                cursorColor: AppColors.primaryRed,
                                keyboardType: TextInputType.phone,
                                controller: _phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return  LocaleKeys.warning_msg_mobile_num_no_empty.tr();
                                  }
                                  if (value.length < 10 || value.length > 10) {
                                    return  LocaleKeys.error_msg_invalid_mobile_num.tr();
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: AppColors.black),
                                  label: Text( LocaleKeys.label_mobile_num.tr()),
                                  isDense: true,
                                  border: InputBorder.none,
                                ),
                              )),
                          VerticalSpace(20.h),
                          ShadowContainer(
                              width: size.width,
                              padding:
                                  defaultPadding.copyWith(top: 6, bottom: 6),
                              margin: defaultPadding,
                              child: TextFormField(
                                cursorColor: AppColors.primaryRed,
                                controller: _password,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return  LocaleKeys.warning_msg_password_no_empty.tr();
                                  }
                                  if (value.length < 5) {
                                    return  LocaleKeys.msg_password_min_length.tr();
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: AppColors.black),
                                  label: Text( LocaleKeys.label_password.tr()),
                                  isDense: true,
                                  border: InputBorder.none,
                                ),
                              )),
                          VerticalSpace(15.h),
                          Text(
                            LocaleKeys.label_agree_terms_condition.tr(),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          VerticalSpace(20.h),
                          PrimaryActionButton(
                            onpress: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthenticationCubit>().register(
                                    user: RegisterRequestModel(
                                        age: 0,
                                        createdAt: "",
                                        updatedAt: "",
                                        name: _name.text.trim(),
                                        password: _password.text.trim(),
                                        username: _phone.text.trim(),
                                        phone: _phone.text.trim(),
                                        lmpDateEn: _lmp.text.trim(),
                                        lmpDateNp: _lmp.text.trim(),
                                        districtId: 0,
                                        email: "",
                                        isFirstTimeParent: 0,
                                        latitude: "",
                                        longitude: "",
                                        municipalityId: 0,
                                        dobChild: _dobChild.text.trim(),
                                        registerAs: widget.registerAs,
                                        tole: ""));
                              }
                            },
                            width: 170.w,
                            title:  LocaleKeys.label_register.tr(),
                          ),
                          VerticalSpace(15.h),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: LocaleKeys.label_already_have_account.tr() ,
                                style: Theme.of(context).textTheme.bodySmall),
                                TextSpan(
                                    text: " " ,
                                    style: Theme.of(context).textTheme.bodySmall),
                            TextSpan(
                              text: LocaleKeys.label_go_to_login.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontSize: 14.sm,
                                      color: AppColors.primaryRed),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()),
                                    (route) => false),
                            ),
                          ]))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ));
  }
}
