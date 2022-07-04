import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/features/authentication/cubit/register_cubit.dart';
import 'package:aamako_maya/src/features/authentication/model/register_request_model.dart';
import 'package:aamako_maya/src/features/authentication/register_bloc/register_bloc.dart';
import 'package:aamako_maya/src/features/authentication/widgets/complete_profile_section.dart';
import 'package:aamako_maya/src/features/bottom_nav/bottom_navigation.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/buttons/primary_action_button.dart';
import '../../../core/widgets/scaffold/primary_scaffold.dart';
import '../../../core/widgets/textfield/primary_textfield.dart';

class RegisterSection extends StatefulWidget {
  final String registerAs;
  const RegisterSection({Key? key, required this.registerAs}) : super(key: key);
  @override
  State<RegisterSection> createState() => _RegisterSectionState();
}

class _RegisterSectionState extends State<RegisterSection> {
  DateTime selectedDate = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final _name = TextEditingController();
  final _username = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  DateTime? picked;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: SafeArea(
      child: Scaffold(
        body: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state.error != null&&state.isLoading==false) {
              BotToast.showText(text: state.error.toString());
            }  if (state.isLoading && state.error == null) {
              BotToast.showLoading();
            } if(state.isLoading==false) {
              BotToast.closeAllLoading();
            }
            state.when(
                initial: ((isLoading, error) => ''),
                success: (isLoading, error, user) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => CustomBottomNavigation()),
                      (route) => false);
                });
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        VerticalSpace(40.h),
                        ShadowContainer(
                            width: size.width,
                            padding: defaultPadding.copyWith(top: 6, bottom: 6),
                            margin: defaultPadding,
                            child: TextFormField(
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
                                label: Text('Name'),
                                isDense: true,
                                border: InputBorder.none,
                              ),
                            )),
                        VerticalSpace(20.h),
                        ShadowContainer(
                            width: size.width,
                            padding: defaultPadding.copyWith(top: 6, bottom: 6),
                            margin: defaultPadding,
                            child: TextFormField(
                              controller: _username,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Username number can\'t not be empty';
                                }
                                if (value.length < 5) {
                                  return 'Invalid username ';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                label: Text('Username'),
                                isDense: true,
                                border: InputBorder.none,
                              ),
                            )),
                        VerticalSpace(20.h),
                        GestureDetector(
                          onTap: () async {
                            picked = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null && picked != selectedDate) {
                              setState(() {
                                selectedDate = picked!;
                              });
                            }
                          },
                          child: ShadowContainer(
                            width: size.width,
                            margin: defaultPadding,
                            padding:
                                defaultPadding.copyWith(top: 15, bottom: 15),
                            child: Text(
                              picked != null
                                  ? formatter.format(selectedDate)
                                  : 'LMP date',
                            ),
                          ),
                        ),
                        VerticalSpace(20.h),
                        ShadowContainer(
                            width: size.width,
                            padding: defaultPadding.copyWith(top: 6, bottom: 6),
                            margin: defaultPadding,
                            child: TextFormField(
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
                                label: Text('Mobile Number'),
                                isDense: true,
                                border: InputBorder.none,
                              ),
                            )),
                        VerticalSpace(20.h),
                        ShadowContainer(
                            width: size.width,
                            padding: defaultPadding.copyWith(top: 6, bottom: 6),
                            margin: defaultPadding,
                            child: TextFormField(
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
                                label: Text('Password'),
                                isDense: true,
                                border: InputBorder.none,
                              ),
                            )),
                        VerticalSpace(20.h),
                      ],
                    ),
                  )),
                  PrimaryActionButton(
                      onpress: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<RegisterBloc>().add(
                              RegisterEvent.gegisterStarted(
                                  user: RegisterRequestModel(
                                      age: 0,
                                      createdAt: formatter.format(DateTime.now()),
                                      updatedAt: formatter.format(DateTime.now()),
                                      name: _name.text.trim(),
                                      password: _password.text.trim(),
                                      username: _username.text.trim(),
                                      phone: _phone.text.trim(),
                                      lmpDateEn: formatter.format(selectedDate),
                                      lmpDateNp: '',
                                      districtId: 0,
                                      email: "",
                                      isFirstTimeParent: 0,
                                      latitude: "",
                                      longitude: "",
                                      municipalityId: 0,
                                      registerAs: widget.registerAs,
                                      tole: "")));
                        }
                      },
                      title: 'Register'),
                  VerticalSpace(50.h),
                ],
              ),
            );
          },
        ),
      ),
    ));
  }
}
