import 'dart:async';

import 'package:Amakomaya/src/core/padding/padding.dart';
import 'package:Amakomaya/src/core/widgets/border_container.dart';
import 'package:Amakomaya/src/core/widgets/buttons/primary_action_button.dart';
import 'package:Amakomaya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:Amakomaya/src/core/widgets/textfield/primary_textfield.dart';
import 'package:Amakomaya/src/features/authentication/model/login_request_model.dart';
import 'package:Amakomaya/src/features/authentication/screens/login/qr_code_page.dart';
import 'package:Amakomaya/src/features/authentication/screens/register/register_page.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../l10n/locale_keys.g.dart';
import '../../../../core/app_assets/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/buttons/localization_button.dart';
import '../../../bottom_nav/bottom_navigation.dart';
import '../../authentication_cubit/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final passwordFocus = FocusNode();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  ValueNotifier<bool> obscureBtn = ValueNotifier(true);

  @override
  void dispose() {
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  var link = "";

  getForgetPasswordData() async {
    var a = await context.read<AuthenticationCubit>().forgetPassword();
    link = a?.link ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
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
            BotToast.showText(text: LocaleKeys.msg_login_success.tr());
          });
        } else {
          BotToast.closeAllLoading();
        }
      },
      builder: (context, state) {
        getForgetPasswordData();
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Row(
                  //   //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     Align(
                  //       alignment: Alignment.center,
                  // child: Image.asset(
                  //   AppAssets.logo,
                  //   height: 197.h,
                  //   width: 197.h,
                  //   cacheHeight: 197,
                  // ),
                  //     ),
                  //     const Padding(
                  //       padding: EdgeInsets.all(25),
                  // child: LocalizationButton(
                  //   color: AppColors.primaryRed,
                  // ),
                  //     ),
                  //   ],
                  // ),

                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: REdgeInsets.only(left: 110),
                          child: Image.asset(
                            AppAssets.logo,
                            height: 190.h,
                            width: 190.h,
                            cacheHeight: 197,
                          ),
                        ),
                      ),
                      Padding(
                        padding: REdgeInsets.all(65),
                        child: LocalizationButton(
                          color: AppColors.primaryRed,
                        ),
                      )
                    ],
                  ),
                  VerticalSpace(50.h),
                  PrimaryTextField(
                    controller: usernameController,
                    // nextFocus: passwordFocus,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return LocaleKeys.warning_msg_username_no_empty.tr();
                      }
                      if (value.length < 4) {
                        return LocaleKeys.msg_username_min_length.tr();
                      }
                      return null;
                    },
                    labelText: LocaleKeys.label_username.tr(),
                    hintText: LocaleKeys.field_phone_number.tr(),
                  ),
                  VerticalSpace(15.h),
                  ValueListenableBuilder(
                      valueListenable: obscureBtn,
                      builder: (BuildContext context, bool i, _) {
                        return PrimaryTextField(
                          obscureText: i,
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocaleKeys.warning_msg_password_no_empty
                                  .tr();
                            }
                            if (value.length < 5) {
                              return LocaleKeys.msg_password_min_length.tr();
                            }
                            return null;
                          },
                          focus: passwordFocus,
                          labelText: LocaleKeys.label_password.tr(),
                          hintText: LocaleKeys.field_password.tr(),
                          sufixTap: () {
                            obscureBtn.value = !obscureBtn.value;
                          },
                          suffix: i ? Icons.visibility : Icons.visibility_off,
                        );
                      }),
                  VerticalSpace(20.h),
                  Padding(
                    padding: defaultPadding,
                    child: PrimaryActionButton(
                      padding: REdgeInsets.symmetric(vertical: 20),
                      onpress: () {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<AuthenticationCubit>(context).login(
                            user: LoginRequestModel(
                              password: passwordController.text.trim(),
                              username: usernameController.text.trim(),
                            ),
                          );
                        }
                      },
                      title: LocaleKeys.label_login.tr(),
                    ),
                  ),
                  VerticalSpace(20.h),
                  Text(LocaleKeys.label_or.tr(),
                      style: Theme.of(context).textTheme.headlineMedium),
                  VerticalSpace(20.h),
                  PrimaryActionButton(
                    padding: REdgeInsets.symmetric(vertical: 20),
                    width: 380.w,
                    onpress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const QRViewPage())));
                    },
                    title: '',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.qr_code),
                        HorizSpace(10.w),
                        Flexible(
                          child: Text(LocaleKeys.label_login_with_qr.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      fontSize: 18.sm,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    child: Text(LocaleKeys.label_forget_password.tr()),
                    onPressed: () {
                      _launchURL(link);
                    },
                  ),
                  VerticalSpace(5.h),
                  Visibility(
                    visible: false,
                    child: InkWell(
                      onTap: () {
                        // Navigator.of(context).pushAndRemoveUntil(
                        //     MaterialPageRoute(
                        //         builder: (ctx) => CustomBottomNavigation()),
                        //     (route) => false);
                      },
                      child: BorderContainer(
                        hasBorder: true,
                        padding: REdgeInsets.symmetric(vertical: 20),
                        width: 380.w,
                        child: Center(
                          child: Text('',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      fontSize: 18.sm,
                                      color: AppColors.primaryRed,
                                      fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                  ),
                  VerticalSpace(5.h),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: LocaleKeys.label_not_regester_yet.tr(),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    TextSpan(
                      text: " ",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    TextSpan(
                      text: LocaleKeys.label_register.tr(),
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryRed,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (ctx) =>  RegisterPage())),
                    ),
                  ])),
                  VerticalSpace(5.h),
                  Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: REdgeInsets.all(12.0),
                          child: Container(
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: LocaleKeys.label_call.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    TextSpan(
                                      text: " ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    TextSpan(
                                        text: LocaleKeys.label_contact_num.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.primaryRed,
                                            )),
                                    TextSpan(
                                      text: " ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    TextSpan(
                                        text: LocaleKeys.label_enquiry.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// class LanguageModel {
//   String title;
//   String value;
//   LanguageModel({required this.title, required this.value});
// }

// IconButton(
//                   icon: Icon(
//                     Icons.phone,
//                     color: Colors.black,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _makePhoneCall(LocaleKeys.number.tr(),);
//                     });
//                   },
//                 ),

_launchURL(String link) async {
  if (await launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication)) {
    await canLaunchUrl(Uri.parse(link));
  } else {
    throw 'Could not launch $link';
  }
}
