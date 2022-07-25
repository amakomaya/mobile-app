import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/snackbar/error_snackbar.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/features/authentication/cubit/register_cubit.dart';
import 'package:aamako_maya/src/features/authentication/model/register_request_model.dart';
import 'package:aamako_maya/src/features/authentication/screens/login/login_page.dart';
import 'package:aamako_maya/src/features/authentication/widgets/complete_profile_section.dart';
import 'package:aamako_maya/src/features/bottom_nav/bottom_navigation.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/buttons/primary_action_button.dart';
import '../../../core/widgets/scaffold/primary_appBar.dart';
import '../../../core/widgets/textfield/primary_textfield.dart';
import '../authentication_cubit/auth_cubit.dart';

class RegisterSection extends StatefulWidget {
  final String registerAs;
  const RegisterSection({Key? key, required this.registerAs}) : super(key: key);
  @override
  State<RegisterSection> createState() => _RegisterSectionState();
}

class _RegisterSectionState extends State<RegisterSection> {
  DateTime selectedDate = picker.NepaliDateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  picker.NepaliDateTime? picked;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: SafeArea(
      child: Scaffold(
        body: BlocConsumer<AuthenticationCubit, LoggedInState>(
          listener: (context, state) {
            if (state.isLoading == true) {
              BotToast.showLoading();
            }
            if (state.isLoading == false || state.isLoading == null) {
              BotToast.closeAllLoading();
            }
            if (state.error != null && state.isLoading == false) {
              BotToast.showCustomText(toastBuilder: (d) {
                return ErrorSnackBar(
                    message: state.error ?? 'Unexpected Error');
              });
            }

            if (state.isAuthenticated == true&& state.error==null && state.isLoading==false) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (ctx) => CustomBottomNavigation()),
                  (route) => false);
            }
            // if (state.isLoading && state.error == null) {
            //   BotToast.showLoading();
            // }
            // if (state.isLoading == false) {
            //   BotToast.closeAllLoading();
            // }
            // state.when(
            //     initial: ((isLoading, error) => ''),
            //     success: (isLoading, error, user) {
            //   Navigator.pushAndRemoveUntil(
            //       context,
            //       MaterialPageRoute(
            //           builder: (ctx) => CustomBottomNavigation()),
            //       (route) => false);
            // });
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
                          padding: const EdgeInsets.only(left: 18, bottom: 12),
                          child: Text(
                            'Register',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 18, bottom: 12),
                          child: Icon(Icons.more_vert_outlined),
                        ),
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
                                  defaultPadding.copyWith(top: 6, bottom: 6),
                              margin: defaultPadding,
                              child: TextFormField(
                                cursorColor: AppColors.primaryRed,
                                controller: _name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Name can\'t not be empty';
                                  }
                                  if (value.length < 3) {
                                    return 'Name must contain more than 3 characters ';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(color: AppColors.black),
                                  label: Text('Name'),
                                  isDense: true,
                                  border: InputBorder.none,
                                ),
                              )),
                          VerticalSpace(20.h),
                          GestureDetector(
                            onTap: () async {
                              picked = await picker.showMaterialDatePicker(
                                context: context,
                                initialDate: picker.NepaliDateTime.now(),
                                firstDate: picker.NepaliDateTime(2000),
                                lastDate: picker.NepaliDateTime(2090),
                                initialDatePickerMode: DatePickerMode.day,
                              );

                              print(picked.toString());

                              if (picked != null && picked != selectedDate) {
                                setState(() {
                                  selectedDate =
                                      picked ?? picker.NepaliDateTime.now();
                                });
                              }
                            },
                            // onTap: () async {
                            //   picked = await showDatePicker(
                            //     context: context,
                            //     initialDate: selectedDate,
                            //     firstDate: DateTime(2000),
                            //     lastDate: DateTime.now(),
                            //   );
                            //   if (picked != null && picked != selectedDate) {
                            //     setState(() {
                            //       selectedDate = picked!;
                            //     });
                            //   }
                            // },
                            child: ShadowContainer(
                              width: size.width,
                              margin: defaultPadding,
                              padding:
                                  defaultPadding.copyWith(top: 23, bottom: 24),
                              child: Text(
                                picked != null
                                    ? formatter.format(selectedDate)
                                    : 'LMP ate',
                                style: TextStyle(color: AppColors.black),
                              ),
                            ),
                          ),
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
                                    return 'Mobile number can\'t not be empty';
                                  }
                                  if (value.length < 10 || value.length > 10) {
                                    return 'Invalid mobile number ';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(color: AppColors.black),
                                  label: Text('Mobile Number'),
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
                                    return 'Password can\'t not be empty';
                                  }
                                  if (value.length < 5) {
                                    return 'Password must contain more than 5 characters ';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(color: AppColors.black),
                                  label: Text('Password'),
                                  isDense: true,
                                  border: InputBorder.none,
                                ),
                              )),
                          VerticalSpace(2.h),
                          const Text(
                            "By clicking in register you are in agreement of Terms and Conditions",
                            style: TextStyle(fontSize: 12, fontFamily: 'lato'),
                          ),
                          VerticalSpace(40.h),
                          PrimaryActionButton(
                              onpress: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthenticationCubit>().register(
                                      user: RegisterRequestModel(
                                          age: 0,
                                          createdAt:
                                              formatter.format(DateTime.now()),
                                          updatedAt:
                                              formatter.format(DateTime.now()),
                                          name: _name.text.trim(),
                                          password: _password.text.trim(),
                                          username: _phone.text.trim(),
                                          phone: _phone.text.trim(),
                                          lmpDateEn:
                                              formatter.format(selectedDate),
                                          lmpDateNp: '',
                                          districtId: 0,
                                          email: "",
                                          isFirstTimeParent: 0,
                                          latitude: "",
                                          longitude: "",
                                          municipalityId: 0,
                                          registerAs: widget.registerAs,
                                          tole: ""));
                                }
                              },
                              width: 170.w,
                              title: 'Register'),
                          VerticalSpace(30.h),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: const Center(
                              child: Text(
                                "Already have an Account",
                                style:
                                    TextStyle(fontSize: 12, fontFamily: 'lato'),
                              ),
                            ),
                          )
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
