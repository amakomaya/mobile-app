import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/textfield/primary_textfield.dart';
import 'package:aamako_maya/src/features/authentication/cubit/district_municipality_cubit.dart';

import 'package:aamako_maya/src/features/authentication/widgets/municipality_dropdown_widget.dart';
import 'package:aamako_maya/src/features/fetch%20user%20data/cubit/get_user_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;

import '../../../core/widgets/buttons/primary_action_button.dart';
import '../../../core/widgets/helper_widgets/blank_space.dart';
import 'district_dropdown_widget.dart';

class CompleteProfileSection extends StatefulWidget {
  const CompleteProfileSection({Key? key}) : super(key: key);
  @override
  State<CompleteProfileSection> createState() => _CompleteProfileSectionState();
}

class _CompleteProfileSectionState extends State<CompleteProfileSection> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _tole = TextEditingController();
  final TextEditingController _ward = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _district = TextEditingController();
  final TextEditingController _municipality = TextEditingController();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  picker.NepaliDateTime? picked;

  final TextEditingController _lmp = TextEditingController();

  @override
  void initState() {
    context.read<DistrictMunicipalityCubit>().startDistrictMunicipalityFetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUserCubit, GetUserState>(
      listener: (context, state) {
        if (state is GetUserSuccess) {
          _name.text = state.user.name ?? '';
          _age.text = (state.user.age ?? 0).toString();
          _lmp.text = state.user.lmpDateNp ?? '';
          _phone.text = state.user.phone.toString();
          _ward.text = state.user.ward ?? '';
          _tole.text = state.user.tole ?? '';
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          padding: defaultPadding.copyWith(top: 27.h, bottom: 27.h),
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
                    isPhone: true,
                    labelText: 'Age',
                  ),
                  VerticalSpace(10.h),
                  PrimaryTextField(
                    readOnly: true,
                    onTap: () async {
                      picked = await picker.showMaterialDatePicker(
                        context: context,
                        initialDate: picker.NepaliDateTime.now(),
                        firstDate: picker.NepaliDateTime(2000),
                        lastDate: picker.NepaliDateTime.now(),
                        initialDatePickerMode: DatePickerMode.day,
                      );

                      if (picked != null) {
                        _lmp.text = formatter.format(picked!);
                      }
                    },
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
                  VerticalSpace(20.h),
                  (state is GetUserSuccess)
                      ? DistrictDropDownListWidget(
                          municipalityController: _municipality,
                          controller: _district,
                          districtId: state.user.districtId ?? 0,
                        )
                      : Container(),
                  VerticalSpace(20.h),
                  (state is GetUserSuccess)
                      ? MunicipalityDropdownListWidget(
                          districtId: state.user.districtId ?? 0,
                          controller: _municipality,
                          municipalityId: (state.user.municipalityId ?? 0),
                        )
                      : Container(),
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
                  PrimaryTextField(
                    controller: _phone,
                    labelText: 'Mobile Number',
                  ),
                ]),
              ),
              VerticalSpace(50.h),
              PrimaryActionButton(
                  height: 50.h, onpress: () {}, title: 'Register'),
            ],
          ),
        );
      },
    );
  }
}
