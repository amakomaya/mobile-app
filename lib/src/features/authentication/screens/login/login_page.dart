import 'dart:async';

import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/widgets/border_container.dart';
import 'package:aamako_maya/src/core/widgets/buttons/primary_action_button.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/textfield/primary_textfield.dart';
import 'package:aamako_maya/src/features/authentication/model/login_request_model.dart';
import 'package:aamako_maya/src/features/authentication/screens/login/qr_code_page.dart';
import 'package:aamako_maya/src/features/authentication/screens/register/register_page.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../l10n/locale_keys.g.dart';
import '../../../../core/app_assets/app_assets.dart';
import '../../../../core/snackbar/error_snackbar.dart';
import '../../../../core/snackbar/success_snackbar.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/buttons/localization_button.dart';
import '../../../bottom_nav/bottom_navigation.dart';
import '../../../home/screens/homepage.dart';
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
            BotToast.showText(text: 'Login Successful');
          });
        } else {
          BotToast.closeAllLoading();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          AppAssets.logo,
                          height: 197.h,
                          width: 197.h,
                          cacheHeight: 197,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 18.0),
                        child: LocalizationButton(
                          color: AppColors.primaryRed,
                        ),
                      ),
                    ],
                  ),
                  VerticalSpace(50.h),
                  PrimaryTextField(
                    controller: usernameController,
                    nextFocus: passwordFocus,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return LocaleKeys.usernamenotempty.tr();
                      }
                      if (value.length < 4) {
                        return LocaleKeys.leastcharsforusername.tr();
                      }
                      return null;
                    },
                    labelText: LocaleKeys.username.tr(),
                    hintText: LocaleKeys.usernameHint.tr(),
                  ),
                  VerticalSpace(15.h),
                  ValueListenableBuilder(
                      valueListenable: obscureBtn,
                      builder: (BuildContext context, bool i, _) {
                        return PrimaryTextField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocaleKeys.passwordnotempty.tr();
                            }
                            if (value.length < 5) {
                              return LocaleKeys.leastcharsforpassword.tr();
                            }
                            return null;
                          },
                          focus: passwordFocus,
                          labelText: LocaleKeys.password.tr(),
                          hintText: LocaleKeys.passwordHint.tr(),
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
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      onpress: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<AuthenticationCubit>(context).login(
                            user: LoginRequestModel(
                              password: passwordController.text.trim(),
                              username: usernameController.text.trim(),
                            ),
                          );
                        }
                      },
                      title: LocaleKeys.login.tr(),
                    ),
                  ),
                  VerticalSpace(20.h),
                  Text('OR', style: Theme.of(context).textTheme.headlineMedium),
                  VerticalSpace(20.h),
                  PrimaryActionButton(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    width: 380.w,
                    onpress: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: ((context) => const QRViewPage())));
                    },
                    title: '',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.qr_code),
                        const HorizSpace(10),
                        Flexible(
                          child: Text(LocaleKeys.loginwithqr.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      fontSize: 18,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w600)),
                        )
                      ],
                    ),
                  ),
                  VerticalSpace(20.h),
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
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        width: 380.w,
                        child: Center(
                          child: Text('',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      fontSize: 18,
                                      color: AppColors.primaryRed,
                                      fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                  ),
                  VerticalSpace(20.h),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: LocaleKeys.notregisteryet.tr(),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    TextSpan(
                      text: LocaleKeys.register.tr(),
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryRed,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (ctx) => const RegisterPage())),
                    ),
                  ])),
                  VerticalSpace(50.h),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: LocaleKeys.call.tr(),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    TextSpan(
                        text: LocaleKeys.number.tr(),
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryRed,
                                )),
                    TextSpan(
                        text: LocaleKeys.forenquiry.tr(),
                        style: Theme.of(context).textTheme.labelSmall),
                  ]))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class LanguageModel {
  String title;
  String value;
  LanguageModel({required this.title, required this.value});
}
