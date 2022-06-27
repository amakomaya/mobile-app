import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/features/authentication/cubit/register_cubit.dart';
import 'package:aamako_maya/src/features/authentication/model/register_request_model.dart';
import 'package:aamako_maya/src/features/authentication/register_bloc/register_bloc.dart';
import 'package:aamako_maya/src/features/authentication/widgets/complete_profile_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/buttons/primary_action_button.dart';
import '../../../core/widgets/scaffold/primary_scaffold.dart';
import '../../../core/widgets/textfield/primary_textfield.dart';

class RegisterSection extends StatefulWidget {
final  String registerAs;
 const RegisterSection({Key? key,required this.registerAs}) : super(key: key);
  @override
  State<RegisterSection> createState() => _RegisterSectionState();
}

class _RegisterSectionState extends State<RegisterSection> {
  DateTime selectedDate = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  DateTime? picked;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  SafeArea(
        child: SafeArea(
          child: Scaffold(
            appBar: ContainerWidget(
              width: size.width,
              height: 70.h,
              decoration: const BoxDecoration(
                  color: AppColors.primaryRed,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
              child: Padding(
                  padding: defaultPadding.copyWith(
                    top: 15.h,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HorizSpace(20.w),
                      Text(
                        'Register',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Spacer(),
                      const Icon(Icons.more_vert)
                    ],
                  )),
            ),
            body: Form(
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
                                if (value.length == 10) {
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
                        
                                           }
                      },
                      title: 'Register'),
                  VerticalSpace(50.h),
                ],
              ),
            ),
          ),
        ));
      
  }
}
