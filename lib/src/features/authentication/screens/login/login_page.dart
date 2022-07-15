import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/widgets/border_container.dart';
import 'package:aamako_maya/src/core/widgets/buttons/primary_action_button.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/textfield/primary_textfield.dart';
import 'package:aamako_maya/src/features/authentication/model/login_request_model.dart';
import 'package:aamako_maya/src/features/authentication/screens/register/register_page.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_assets/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../bottom_nav/bottom_navigation.dart';
import '../../../home/screens/homepage.dart';
import '../../login_bloc/login_bloc.dart';

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
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isLoading) {
          BotToast.showLoading();
        }
        if (state.isLoading == false) {
          BotToast.closeAllLoading();
        }
        if (state.isLoading == false && state.error != null) {
          BotToast.showText(text: state.error ?? 'Unexpected Error Occured');
        }
        state.when(
            initial: (isLoading, error) => '',
            // orElse: () => '',

            success: (isLoading, error, user) {
              BotToast.closeAllLoading();

              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (ctx) => const CustomBottomNavigation(),
                  ),
                  (route) => false);
            });
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
                        padding: EdgeInsets.all(8.0),
                        child: ImageIcon(
                          AssetImage(
                            "assets/images/language.png",
                          ),
                          size: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  VerticalSpace(50.h),
                  PrimaryTextField(
                    cursorColor: Colors.red,
                    controller: usernameController,
                    nextFocus: passwordFocus,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username can\'t be empty';
                      }
                      if (value.length < 4) {
                        return 'Username must at least be 5 chars';
                      }
                      return null;
                    },
                    labelText: 'Username',
                    hintText: 'Enter Your Phone Number/ Username',
                  ),
                  VerticalSpace(15.h),
                  ValueListenableBuilder(
                      valueListenable: obscureBtn,
                      builder: (BuildContext context, bool i, _) {
                        return PrimaryTextField(
                          cursorColor: Colors.red,
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password can\'t not be empty';
                            }
                            if (value.length < 5) {
                              return 'Password must contain more than 5 characters ';
                            }
                            return null;
                          },
                          focus: passwordFocus,
                          labelText: 'Password',
                          hintText: 'Enter Your Password',
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
                          BlocProvider.of<LoginBloc>(context).add(
                            LoginEvent.loginStarted(
                              user: LoginRequestModel(
                                password: passwordController.text.trim(),
                                username: usernameController.text.trim(),
                              ),
                            ),
                          );
                        }
                      },
                      title: 'Login',
                    ),
                  ),
                  VerticalSpace(20.h),
                  Text('OR', style: Theme.of(context).textTheme.headlineMedium),
                  VerticalSpace(20.h),
                  Padding(
                    padding: defaultPadding,
                    child: PrimaryActionButton(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      onpress: () {},
                      title: '',
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.qr_code),
                            const HorizSpace(10),
                            Flexible(
                              child: Text('Login With QR-code',
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
                    ),
                  ),
                  VerticalSpace(20.h),
                  Visibility(
                    visible: false,
                    child: BorderContainer(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      width: 380.w,
                      child: Center(
                        child: Text('Guest Login',
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
                  VerticalSpace(20.h),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: 'Not registered yet?  ',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    TextSpan(
                      text: 'Create an Account',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryRed,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (ctx) => RegisterPage())),
                    ),
                  ])),
                  VerticalSpace(50.h),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: 'Call ',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    TextSpan(
                        text: '9860-3434-3434',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryRed,
                                )),
                    TextSpan(
                        text: '  for an enquiry',
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
