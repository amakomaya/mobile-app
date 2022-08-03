import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/textfield/primary_textfield.dart';
import 'package:aamako_maya/src/features/authentication/cubit/district_municipality_cubit.dart';
import 'package:aamako_maya/src/features/authentication/cubit/register_cubit.dart';
import 'package:aamako_maya/src/features/authentication/model/municipality_district_model.dart';
import 'package:aamako_maya/src/features/authentication/model/register_request_model.dart';
import 'package:aamako_maya/src/features/authentication/widgets/municipality_dropdown_widget.dart';
import 'package:aamako_maya/src/features/home/screens/homepage.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/buttons/primary_action_button.dart';
import '../../../core/widgets/helper_widgets/blank_space.dart';
import '../../bottom_nav/bottom_navigation.dart';
import '../authentication_cubit/auth_cubit.dart';
import 'district_dropdown_widget.dart';

class CompleteProfileSection extends StatefulWidget {
  const CompleteProfileSection({Key? key}) : super(key: key);
  @override
  State<CompleteProfileSection> createState() => _CompleteProfileSectionState();
}

class _CompleteProfileSectionState extends State<CompleteProfileSection> {
  final TextEditingController _name = TextEditingController(text: 'name');
  final TextEditingController _age = TextEditingController(text: '22');
  final TextEditingController _tole = TextEditingController();
  final TextEditingController _ward = TextEditingController();

  final TextEditingController _lmp =
      TextEditingController(text: DateTime.now().toString());

  @override
  void initState() {
    context.read<DistrictMunicipalityCubit>().startDistrictMunicipalityFetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: defaultPadding.copyWith(top: 20.h, bottom: 45.h),
      child: Column(
        children: [
          ShadowContainer(
            width: 380.w,
            radius: 35,
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Column(children: [
              Text(
                'Your Personal Details',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontSize: 16),
              ),
              PrimaryTextField(
                controller: _name,
                labelText: 'Name',
              ),
              VerticalSpace(10.h),
              PrimaryTextField(
                controller: _age,
                labelText: 'Age',
              ),
              VerticalSpace(10.h),
              PrimaryTextField(
                controller: _lmp,
                labelText: 'LMP Date',
              ),
            ]),
          ),
          VerticalSpace(30.h),
          ShadowContainer(
            width: 380.w,
            radius: 35,
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Column(children: [
              Text(
                'Your Address',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontSize: 16),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    'District',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontSize: 16),
                  ),
                ),
              ),
              VerticalSpace(20.h),
              const DistrictDropDownListWidget(),
              VerticalSpace(20.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    'Municipality/VDC',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontSize: 16),
                  ),
                ),
              ),
              VerticalSpace(20.h),
              const MunicipalityDropdownListWidget(),
              VerticalSpace(20.h),
              PrimaryTextField(
                labelText: 'Ward No.',
                controller: _ward,
              ),
              VerticalSpace(10.h),
              PrimaryTextField(
                controller: _tole,
                labelText: 'Tole',
              ),
              VerticalSpace(10.h),
              const PrimaryTextField(
                labelText: 'Mobile Number',
              ),
            ]),
          ),
          VerticalSpace(50.h),
          PrimaryActionButton(
              onpress: () {
              
              },
              title: 'Register'),
          VerticalSpace(50.h),
        ],
      ),
    );
  }
}
