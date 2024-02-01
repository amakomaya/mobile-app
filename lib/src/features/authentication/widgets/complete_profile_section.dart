import 'package:Amakomaya/l10n/locale_keys.g.dart';
import 'package:Amakomaya/src/core/padding/padding.dart';
import 'package:Amakomaya/src/core/theme/app_colors.dart';
import 'package:Amakomaya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:Amakomaya/src/core/widgets/textfield/primary_textfield.dart';
import 'package:Amakomaya/src/features/authentication/cubit/district_municipality_cubit.dart';
import 'package:Amakomaya/src/features/authentication/widgets/custom_dropdown.dart';

import 'package:Amakomaya/src/features/authentication/widgets/municipality_dropdown_widget.dart';
import 'package:Amakomaya/src/features/authentication/widgets/province_dropdown_widget.dart';
import 'package:Amakomaya/src/features/fetch%20user%20data/cubit/get_user_cubit.dart';
import 'package:Amakomaya/src/features/symptoms/cubit/symptoms_cubit.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../injection_container.dart';
import '../../../core/connection_checker/network_connection.dart';
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
  final TextEditingController _dobChild = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _district = TextEditingController();
  final TextEditingController _municipality = TextEditingController();
  final TextEditingController _province = TextEditingController();
  final TextEditingController _districtID = TextEditingController();
  final TextEditingController _provinceID = TextEditingController();
  final TextEditingController _municipalityID = TextEditingController();
  final TextEditingController _disease = TextEditingController();
  final TextEditingController _numberOfPregnancy = TextEditingController();
  final TextEditingController _heightIncm = TextEditingController();
  final TextEditingController _bloodgroup = TextEditingController();
  final _husbandName = TextEditingController();
  final _currentHealthPostName = TextEditingController();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final _formKey = GlobalKey<FormState>();
  picker.NepaliDateTime? picked;
  final ScrollController scrollController = ScrollController();
  var isEdit = false;
  var isPreparingforPregnancy = true;
  final TextEditingController _lmp = TextEditingController();
  String userMode = "";

  @override
  void initState() {
    context.read<DistrictMunicipalityCubit>().startDistrictMunicipalityFetch();
    super.initState();
    callApi();
  }

  callApi() async {
    await context.read<GetUserCubit>()
      ..getUserData();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userMode = prefs.getString('user_mode') ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUserCubit, GetUserState>(
      listener: (context, state) {
        if (state is GetUserSuccess) {
          _name.text = state.user.name ?? '';
          _dobChild.text = state.user.dobChild ?? '';
          _age.text = (state.user.age ?? '').toString();
          _lmp.text = state.user.lmpDateNp ?? '';
          _phone.text = state.user.phone.toString();
          _ward.text = state.user.ward ?? '';
          _tole.text = state.user.tole ?? '';
          _bloodgroup.text = state.user.bloodGroup ?? '';
          _heightIncm.text = state.user.height ?? '';
          _husbandName.text = state.user.husbandName ?? '';
          _currentHealthPostName.text = state.user.currentHealthPost ?? '';
          _disease.text = state.user.haveDiseasePreviously ?? '';
          _numberOfPregnancy.text = (state.user.pregnantTimes ?? 0).toString();
          _provinceID.text = "0";
          _districtID.text = (0).toString();
          _municipalityID.text = (0).toString();
          _district.text = state.user.districtName ?? "";
          _municipality.text = state.user.municipalityName ?? "";
          _province.text = state.user.provinceName ?? "";
        }
      },
      builder: (context, state) {
        if (state is GetUserSuccess) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: defaultPadding.copyWith(top: 27.h, bottom: 27.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Column(children: [
                    Text(
                      isEdit
                          ? LocaleKeys.label_edit_personal_details.tr()
                          : LocaleKeys.label_personal_details.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(fontSize: 16, color: Colors.red),
                    ),
                    PrimaryTextField(
                      isEditable: isEdit,
                      controller: _name,
                      labelText: LocaleKeys.label_name.tr(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.warning_msg_name_no_empty.tr();
                        }
                        return null;
                      },
                    ),
                    VerticalSpace(20.h),
                    PrimaryTextField(
                      isEditable: isEdit,
                      controller: _age,
                      labelText: LocaleKeys.label_age.tr(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.warning_msg_age_no_empty.tr();
                        }
                        return null;
                      },
                    ),
                    userMode == "pregnancy"
                        ? Column(
                            children: [
                              VerticalSpace(20.h),
                              PrimaryTextField(
                                isEditable: isEdit,
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return LocaleKeys.warning_msg_lmp_no_empty
                                        .tr();
                                  }
                                  return null;
                                },
                                labelText: LocaleKeys.lable_lmp_date.tr(),
                              ),
                            ],
                          )
                        : SizedBox(),
                    userMode == "growth of child"
                        ? Column(
                            children: [
                              VerticalSpace(20.h),
                              PrimaryTextField(
                                isEditable: isEdit,
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
                                    _dobChild.text = formatter.format(picked!);
                                  }
                                },
                                controller: _dobChild,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Date of child birth cannot be empty";
                                  }
                                  return null;
                                },
                                labelText: "Date of Child Birth",
                              ),
                            ],
                          )
                        : SizedBox(),
                  ]),
                  VerticalSpace(20.h),
                  Container(
                    padding: defaultPadding,
                    alignment: Alignment.topLeft,
                    child: Text(
                      LocaleKeys.label_choose_blood_group.tr(),
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(fontSize: 16),
                    ),
                  ),
                  VerticalSpace(5.h),
                  Padding(
                    padding: defaultPadding,
                    child: CustomDropDown(
                        items: bloodGroups,
                        onChanged: (v) {
                          _bloodgroup.text = v.toString();
                          setState(() {});
                        },
                        isEditable: isEdit,
                        controller: _bloodgroup),
                  ),
                  VerticalSpace(40.h),
                  Column(children: [
                    Text(
                      LocaleKeys.lable_address.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(fontSize: 16, color: Colors.red),
                    ),
                    VerticalSpace(20.h),
                    ProvinceDropDownListWidget(
                      isEditable: isEdit,
                      retainId: _provinceID,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.warning_msg_province_no_empty.tr();
                        }
                        return null;
                      },
                      districtController: _district,
                      municipalityController: _municipality,
                      controller: _province,
                      provinceId: 0,
                    ),
                    VerticalSpace(20.h),
                    DistrictDropdownListWidget(
                      isEditable: isEdit,
                      retainId: _districtID,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.warning_msg_distrct_no_empty.tr();
                        }
                        return null;
                      },
                      provinceId: 0,
                      controller: _district,
                      districtId: state.user.districtId ?? 0,
                      municipalityController: _municipality,
                    ),
                    VerticalSpace(20.h),
                    MunicipalityDropdownListWidget(
                        isEditable: isEdit,
                        retainId: _municipalityID,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return LocaleKeys.warning_msg_municiplality_no_empty
                                .tr();
                          }
                          return null;
                        },
                        districtId: state.user.districtId ?? 0,
                        controller: _municipality,
                        municipalityId: state.user.municipalityId ?? 0),
                    VerticalSpace(20.h),
                    PrimaryTextField(
                      isEditable: isEdit,
                      labelText: LocaleKeys.ward_no.tr(),
                      controller: _ward,
                      isPhone: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.warning_msg_ward_no_empty.tr();
                        } else if (int.parse(value) > 33) {
                          return LocaleKeys.warning_msg_ward_no_exceed.tr();
                        }
                        return null;
                      },
                    ),
                    VerticalSpace(20.h),
                    PrimaryTextField(
                      isEditable: isEdit,
                      controller: _tole,
                      labelText: LocaleKeys.lable_tole.tr(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.warning_msg_tole_no_empty.tr();
                        }
                        return null;
                      },
                    ),
                    VerticalSpace(20.h),
                    PrimaryTextField(
                      isEditable: isEdit,
                      controller: _phone,
                      isPhone: true,
                      labelText: LocaleKeys.label_mobile_num.tr(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.warning_msg_number_no_empty.tr();
                        }
                        return null;
                      },
                    ),
                  ]),
                  userMode == "pregnancy"
                      ? Column(
                          children: [
                            VerticalSpace(40.h),
                            Text(
                              LocaleKeys.label_other_info.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(fontSize: 16, color: Colors.red),
                            ),
                            VerticalSpace(20.h),
                            PrimaryTextField(
                              isEditable: isEdit,
                              controller: _disease,
                              labelText:
                                  LocaleKeys.label_have_disease_prev.tr(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return LocaleKeys
                                      .warning_msg_disease_prev_no_empty
                                      .tr();
                                }
                                return null;
                              },
                            ),
                            VerticalSpace(20.h),
                            PrimaryTextField(
                              isEditable: isEdit,
                              controller: _numberOfPregnancy,
                              isPhone: true,
                              labelText:
                                  LocaleKeys.label_no_of_pregnant_before.tr(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return LocaleKeys
                                      .warning_msg_pregnant_before_no_empty
                                      .tr();
                                } else if (int.parse(value) > 5) {
                                  return LocaleKeys
                                      .warning_msg_pregnant_before_exceed
                                      .tr();
                                }
                                return null;
                              },
                            ),
                            VerticalSpace(20.h),
                            PrimaryTextField(
                              isEditable: isEdit,
                              controller: _heightIncm,
                              labelText: LocaleKeys.label_height.tr(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return LocaleKeys.warning_msg_height_no_empty
                                      .tr();
                                }
                                return null;
                              },
                            ),
                            VerticalSpace(20.h),
                            PrimaryTextField(
                              isEditable: isEdit,
                              controller: _husbandName,
                              labelText: LocaleKeys.label_husband_name.tr(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return LocaleKeys
                                      .warning_msg_husband_name_no_empty
                                      .tr();
                                }
                                return null;
                              },
                            ),
                            VerticalSpace(20.h),
                            PrimaryTextField(
                              isEditable: isEdit,
                              controller: _currentHealthPostName,
                              labelText: LocaleKeys.label_health_post.tr(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return LocaleKeys
                                      .warning_msg_health_post_no_empty
                                      .tr();
                                }
                                return null;
                              },
                            ),
                            VerticalSpace(30.h),
                            VerticalSpace(20.h),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      LocaleKeys.label_mode.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(fontSize: 16),
                                    ),
                                  ),
                                  VerticalSpace(10.h),
                                  SwitchWidget(
                                      onTap: () {
                                        if (isEdit) {
                                          isPreparingforPregnancy = true;
                                          setState(() {});
                                        }
                                      },
                                      isPreparingforPregnancy:
                                          isPreparingforPregnancy,
                                      label: LocaleKeys.label_prepare_pregnancy
                                          .tr()),
                                  VerticalSpace(
                                    10,
                                  ),
                                  SwitchWidget(
                                      onTap: () {
                                        if (isEdit) {
                                          isPreparingforPregnancy = false;
                                          setState(() {});
                                        }
                                      },
                                      isPreparingforPregnancy:
                                          !isPreparingforPregnancy,
                                      label: LocaleKeys.label_growth_of_child
                                          .tr()),
                                ],
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                  VerticalSpace(50.h),
                  if (!isEdit)
                    PrimaryActionButton(
                        onpress: () {
                          isEdit = true;
                          scrollController.jumpTo(
                              scrollController.position.minScrollExtent);
                          setState(() {});
                        },
                        title: LocaleKeys.label_change.tr())
                  else
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryActionButton(
                              height: 70.h,
                              onpress: () async {
                                if (await sl<NetworkInfo>().isConnected) {
                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      BotToast.showLoading();
                                      await context
                                          .read<GetUserCubit>()
                                          .postUserData(
                                            name: _name.text,
                                            wardno: _ward.text,
                                            dobChild: _dobChild.text,
                                            age: int.parse(_age.text),
                                            provinceName: _province.text,
                                            mobile_number: _phone.text,
                                            lmp_date: _lmp.text,
                                            bloodgroup: _bloodgroup.text,
                                            districtName: _district.text,
                                            municipalityName:
                                                _municipality.text,
                                            tole: _tole.text,
                                            disease: _disease.text,
                                            heightIncm: _heightIncm.text,
                                            numberOfPregnancy: int.parse(
                                                _numberOfPregnancy.text),
                                            husbandName: _husbandName.text,
                                            currentHealthPost:
                                                _currentHealthPostName.text,
                                            mode: isPreparingforPregnancy
                                                ? "Preparing for Pregnancy"
                                                : "Growth of Child",
                                          );
                                      // await Future.delayed(Duration(seconds: 2));
                                      BotToast.closeAllLoading();
                                      BotToast.showText(
                                          text: LocaleKeys
                                              .msg_updated_profile_success
                                              .tr());
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.remove("user_data");
                                      isEdit = false;
                                      scrollController.jumpTo(scrollController
                                          .position.minScrollExtent);
                                      await context.read<GetUserCubit>()
                                        ..getUserData();
                                      setState(() {});
                                    } on ApiException catch (e) {
                                      BotToast.closeAllLoading();
                                      BotToast.showText(
                                          text: e.message.toString());
                                    }
                                  } else {
                                    BotToast.showText(
                                        text: LocaleKeys
                                            .warning_msg_fill_all_field
                                            .tr());
                                  }
                                } else {
                                  BotToast.showText(
                                      text: LocaleKeys.no_internet_connection
                                          .tr());
                                }
                              },
                              title: LocaleKeys.label_submit.tr()),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                          child: PrimaryActionButton(
                              color: Colors.grey,
                              height: 70.h,
                              onpress: () {
                                isEdit = false;
                                setState(() {});
                              },
                              title: LocaleKeys.label_cancel.tr()),
                        ),
                      ],
                    )
                ],
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}

class SwitchWidget extends StatelessWidget {
  const SwitchWidget(
      {Key? key,
      required this.isPreparingforPregnancy,
      required this.label,
      required this.onTap})
      : super(key: key);

  final bool isPreparingforPregnancy;
  final String label;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          isPreparingforPregnancy
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

class DetailItems extends StatelessWidget {
  const DetailItems(
      {required this.label,
      required this.items,
      required this.isIndividual,
      this.isAdditionalInfo = false,
      this.onTap});

  final String label;
  final List<Widget> items;
  final bool isAdditionalInfo;
  final bool isIndividual;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: REdgeInsets.symmetric(horizontal: 16),
      padding: REdgeInsets.symmetric(horizontal: 15.r, vertical: 20.r),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.grey, offset: Offset(0, 0), blurRadius: 2)
      ], color: Colors.white, borderRadius: BorderRadius.circular(30.r)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp),
              ),
              InkWell(
                onTap: onTap,
                child: Container(
                  height: 30.r,
                  width: 30.r,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 0),
                            blurRadius: 2)
                      ],
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Icon(
                    Icons.edit,
                    size: 16.r,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          ...items
        ],
      ),
    );
  }
}

class PersonalDetailItem extends StatelessWidget {
  const PersonalDetailItem({
    this.label = "",
    this.value = "",
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return RPadding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 18.sm),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? 'na' : value,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.black),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
