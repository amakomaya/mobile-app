import 'package:Amakomaya/l10n/locale_keys.g.dart';
import 'package:Amakomaya/src/core/padding/padding.dart';
import 'package:Amakomaya/src/core/theme/app_colors.dart';
import 'package:Amakomaya/src/core/widgets/textfield/primary_textfield.dart';
import 'package:Amakomaya/src/features/appointment_booking/cubit/booking_cubit.dart';
import 'package:Amakomaya/src/features/appointment_booking/model/booking_model.dart';
import 'package:Amakomaya/src/features/appointment_booking/screens/scheme_general_dropdown_widget.dart';
import 'package:Amakomaya/src/features/appointment_booking/screens/scheme_paying_dropdown_widget.dart';
import 'package:Amakomaya/src/features/authentication/cubit/district_municipality_cubit.dart';
import 'package:Amakomaya/src/features/authentication/widgets/custom_dropdown.dart';
import 'package:Amakomaya/src/features/authentication/widgets/municipality_dropdown_widget.dart';
import 'package:Amakomaya/src/features/authentication/widgets/province_dropdown_widget.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import '../../../core/widgets/buttons/primary_action_button.dart';
import '../../../core/widgets/helper_widgets/blank_space.dart';
import '../../authentication/widgets/district_dropdown_widget.dart';
import '../../fetch user data/cubit/get_user_cubit.dart';
import '../cubit/scheme_cubit.dart';
import 'booking_checkout_page.dart';

class BookingPage extends StatefulWidget {
  final int currentIndex;

  const BookingPage({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  var currentIndexs = -1;

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _middleName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _province = TextEditingController();
  final TextEditingController _provinceID = TextEditingController();
  final TextEditingController _municipality = TextEditingController();
  final TextEditingController _municipalityID = TextEditingController();
  final TextEditingController _district = TextEditingController();
  final TextEditingController _districtID = TextEditingController();
  final TextEditingController _ward = TextEditingController();
  final TextEditingController _tole = TextEditingController();
  final TextEditingController _clientId = TextEditingController();
  final TextEditingController _appointmentDate = TextEditingController();
  final TextEditingController _generalSchemeSelectedId =
      TextEditingController();
  final TextEditingController _generalScheme = TextEditingController();
  final TextEditingController _payingSchemeSelectedId = TextEditingController();
  final TextEditingController _payingScheme = TextEditingController();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final _formKey = GlobalKey<FormState>();
  picker.NepaliDateTime? picked;
  final ScrollController scrollController = ScrollController();
  var isEdit = true;
  var isBookingTypeNew = true;
  var isForMe = true;
  var isSchemeTypePaying = true;

  @override
  void initState() {
    currentIndexs = widget.currentIndex;
    context.read<DistrictMunicipalityCubit>().startDistrictMunicipalityFetch();
    context.read<SchemeCubit>().startSchemeFetch();
    _gender.text = "Female";
    context.read<GetUserCubit>().getUserData();

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state is BookingLoadingState) {
          BotToast.showLoading();
        } else if (state is BookingFailureState) {
          BotToast.closeAllLoading();
          BotToast.showText(text: state.error);
        } else if (state is BookingSuccessfulState) {
          BotToast.closeAllLoading();
          _firstName.text = "";
          _middleName.text = "";
          _lastName.text = "";
          _dob.text = "";
          _gender.text = "Female";
          _email.text = "";
          _phone.text = "";
          _province.text = "";
          _municipality.text = "";
          _district.text = "";
          _districtID.text = "";
          _ward.text = "";
          _tole.text = "";
          _clientId.text = "";
          _appointmentDate.text = "";
          _generalSchemeSelectedId.text = "";
          _generalScheme.text = "";
          _payingSchemeSelectedId.text = "";
          _payingScheme.text = "";
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BookingCheckoutPage(state.bookingModel)));
        } else {
          BotToast.closeAllLoading();
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: defaultPadding.copyWith(top: 27.h, bottom: 27.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset('assets/images/logo/book_appointment.png',
                    height: 80.sm, width: double.infinity),
                VerticalSpace(20.h),
                BlocBuilder<GetUserCubit, GetUserState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SwitchWidget(
                            onTap: () {
                              isForMe = true;
                              if (state is GetUserSuccess) {
                                  _firstName.text = state.user.firstName ?? '';
                                  _middleName.text = state.user.middleName ?? '';
                                  _lastName.text = state.user.lastName ?? '';
                                  _phone.text = state.user.phone.toString();
                                  _ward.text = state.user.ward ?? '';
                                  _tole.text = state.user.tole ?? '';
                                  _gender.text = "Female";
                                  _district.text = state.user.districtName ?? "";
                                  _municipality.text = state.user.municipalityName ?? "";
                                  _province.text = state.user.provinceName ?? "";
                              }
                              setState(() {});
                            },
                            type: isForMe,
                            label:LocaleKeys.label_for_myself.tr()),
                        SwitchWidget(
                            onTap: () {
                              isForMe = false;
                              _firstName.text = '';
                              _middleName.text = '';
                              _lastName.text = '';
                              _phone.text = "";
                              _ward.text = '';
                              _tole.text = '';
                              _district.text = "";
                              _municipality.text = "";
                              _province.text = "";
                              _gender.text = "Female";
                              setState(() {});
                            },
                            type: !isForMe,
                            label:LocaleKeys.label_for_other.tr()),
                      ],
                    );
                  },
                ),
                BlocConsumer<GetUserCubit, GetUserState>(
                  listener: (context, state) {
                    if (state is GetUserSuccess) {
                      if (isForMe) {
                        _firstName.text = state.user.firstName ?? '';
                        _middleName.text = state.user.middleName ?? '';
                        _lastName.text = state.user.lastName ?? '';
                        _phone.text = state.user.phone.toString();
                        _ward.text = state.user.ward ?? '';
                        _tole.text = state.user.tole ?? '';
                        _district.text = state.user.districtName ?? "";
                        _municipality.text = state.user.municipalityName ?? "";
                        _province.text = state.user.provinceName ?? "";
                        _gender.text = "Female";
                      }
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        VerticalSpace(20.h),
                        PrimaryTextField(
                          isEditable: isEdit,
                          controller: _firstName,
                          labelText: LocaleKeys.label_first_name.tr(),
                          hintText: LocaleKeys.placeholder_please_enter_first_name.tr(),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return  LocaleKeys.msg_first_name_cannot_be_empty.tr();
                            }
                            return null;
                          },
                        ),
                        VerticalSpace(20.h),
                        PrimaryTextField(
                            isEditable: isEdit,
                            controller: _middleName,
                            labelText: LocaleKeys.label_middle_name.tr() + " " + LocaleKeys.label_optional.tr(),
                            hintText:  LocaleKeys.placeholder_please_enter_middle_name.tr()),
                        VerticalSpace(20.h),
                        PrimaryTextField(
                          isEditable: isEdit,
                          controller: _lastName,
                          labelText: LocaleKeys.label_last_name.tr(),
                          hintText: LocaleKeys.placeholder_please_enter_last_name.tr(),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.msg_last_name_cannot_be_empty.tr();
                            }
                            return null;
                          },
                        ),
                        VerticalSpace(20.h),
                        PrimaryTextField(
                          isEditable: isEdit,
                          readOnly: true,
                          hintText: LocaleKeys.placeholder_please_enter_date_of_birth.tr(),
                          onTap: () async {
                            picked = await picker.showMaterialDatePicker(
                              context: context,
                              initialDate: picker.NepaliDateTime.now(),
                              firstDate: picker.NepaliDateTime(2000),
                              lastDate: picker.NepaliDateTime.now(),
                              initialDatePickerMode: DatePickerMode.day,
                            );

                            if (picked != null) {
                              _dob.text = formatter.format(picked!);
                            }
                          },
                          controller: _dob,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.warning_msg_lmp_no_empty.tr();
                            }
                            return null;
                          },
                          labelText: LocaleKeys.label_dob.tr()+ " " + LocaleKeys.label_optional.tr(),
                        ),
                        VerticalSpace(20.h),
                        Container(
                          padding: defaultPadding,
                          alignment: Alignment.topLeft,
                          child: Text(
                            LocaleKeys.label_gender.tr(),
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
                              items: gender,
                              isFromGender: true,
                              onChanged: (v) {
                                _gender.text = v.toString();
                                setState(() {});
                              },
                              isEditable: isEdit,
                              controller: _gender),
                        ),
                        VerticalSpace(20.h),
                        PrimaryTextField(
                          isEditable: isEdit,
                          controller: _email,
                          labelText: LocaleKeys.label_email.tr() + " " + LocaleKeys.label_optional.tr() ,
                          hintText:  LocaleKeys.placeholder_please_enter_email.tr(),
                        ),
                        VerticalSpace(20.h),
                        PrimaryTextField(
                          isEditable: isEdit,
                          controller: _phone,
                          isPhone: true,
                          maxLength:10,
                          hintText: LocaleKeys.placeholder_please_enter_mobile_number.tr(),
                          labelText: LocaleKeys.label_mobile_number.tr(),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.warning_msg_number_no_empty
                                  .tr();
                            }
                            if(int.parse(value)<10){
                              return "Invalid Number";
                            }
                            return null;
                          },
                        ),
                        VerticalSpace(20.h),
                        ProvinceDropDownListWidget(
                          isEditable: isEdit,
                          retainId: _provinceID,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.warning_msg_province_no_empty
                                  .tr();
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
                              return LocaleKeys.warning_msg_distrct_no_empty
                                  .tr();
                            }
                            return null;
                          },
                          provinceId: 0,
                          controller: _district,
                          districtId: 0,
                          municipalityController: _municipality,
                        ),
                        VerticalSpace(20.h),
                        MunicipalityDropdownListWidget(
                            isEditable: isEdit,
                            retainId: _municipalityID,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return LocaleKeys
                                    .warning_msg_municiplality_no_empty
                                    .tr();
                              }
                              return null;
                            },
                            districtId: 0,
                            controller: _municipality,
                            municipalityId: 0),
                        VerticalSpace(20.h),
                        PrimaryTextField(
                          isEditable: isEdit,
                          labelText: LocaleKeys.ward_no.tr(),
                          hintText:  LocaleKeys.placeholder_please_enter_ward_number.tr(),
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
                          hintText: LocaleKeys.placeholder_please_enter_tole.tr(),
                          labelText: LocaleKeys.lable_tole.tr(),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.warning_msg_tole_no_empty.tr();
                            }
                            return null;
                          },
                        ),
                        VerticalSpace(20.h),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  LocaleKeys.label_booking_type.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(fontSize: 16),
                                ),
                              ),
                              VerticalSpace(10.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SwitchWidget(
                                      onTap: () {
                                        isBookingTypeNew = true;
                                        setState(() {});
                                      },
                                      type: isBookingTypeNew,
                                      label: LocaleKeys.label_new.tr()),
                                  SwitchWidget(
                                      onTap: () {
                                        isBookingTypeNew = false;
                                        setState(() {});
                                      },
                                      type: !isBookingTypeNew,
                                      label: LocaleKeys.label_followup.tr()),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: isBookingTypeNew ? false : true,
                          child: Column(
                            children: [
                              VerticalSpace(20.h),
                              PrimaryTextField(
                                isEditable: isEdit,
                                controller: _clientId,
                                labelText: LocaleKeys.label_client_id.tr(),
                                hintText: LocaleKeys.placeholder_please_enter_client_id.tr(),
                              ),
                            ],
                          ),
                        ),
                        VerticalSpace(20.h),
                        PrimaryTextField(
                          isEditable: isEdit,
                          readOnly: true,
                          hintText:
                              LocaleKeys.label_choose_appointment_date.tr(),
                          onTap: () async {
                            var currentTime = DateTime.now().hour;
                            picked = await picker.showMaterialDatePicker(
                              context: context,
                              initialDate: currentTime <= 7
                                  ? picker.NepaliDateTime.now()
                                  : picker.NepaliDateTime.now()
                                      .add(Duration(days: 1)),
                              firstDate: currentTime <= 7
                                  ? picker.NepaliDateTime.now()
                                  : picker.NepaliDateTime.now()
                                      .add(Duration(days: 1)),
                              lastDate: picker.NepaliDateTime.now()
                                  .add(Duration(days: 2)),
                              initialDatePickerMode: DatePickerMode.day,
                            );

                            if (picked != null) {
                              _appointmentDate.text = formatter.format(picked!);
                            }
                          },
                          controller: _appointmentDate,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.warning_msg_lmp_no_empty.tr();
                            }
                            return null;
                          },
                          labelText: LocaleKeys.label_appointment_date.tr(),
                        ),
                        VerticalSpace(20.h),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  LocaleKeys.label_scheme.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(fontSize: 16),
                                ),
                              ),
                              VerticalSpace(10.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SwitchWidget(
                                      onTap: () {
                                        isSchemeTypePaying = true;
                                        setState(() {});
                                      },
                                      type: isSchemeTypePaying,
                                      label: LocaleKeys.label_paying.tr()),
                                  SwitchWidget(
                                      onTap: () {
                                        isSchemeTypePaying = false;
                                        setState(() {});
                                      },
                                      type: !isSchemeTypePaying,
                                      label: LocaleKeys.label_general.tr()),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: isSchemeTypePaying ? false : true,
                          child: Column(
                            children: [
                              SchemeGeneralDropDownListWidget(
                                isEditable: isEdit,
                                retainId: _generalSchemeSelectedId,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return LocaleKeys
                                        .label_select_general_service
                                        .tr();
                                  }
                                  return null;
                                },
                                controller: _generalScheme,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: isSchemeTypePaying ? true : false,
                          child: Column(
                            children: [
                              SchemePayingDropDownListWidget(
                                isEditable: isEdit,
                                retainId: _payingSchemeSelectedId,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return LocaleKeys.label_select_doctor.tr();
                                  }
                                  return null;
                                },
                                controller: _payingScheme,
                              ),
                            ],
                          ),
                        ),
                        VerticalSpace(40.h),
                        PrimaryActionButton(
                            height: 70.h,
                            onpress: () async {
                              if (_firstName.text.isEmpty ||
                                  _lastName.text.isEmpty ||
                                  _gender.text.isEmpty ||
                                  _phone.text.isEmpty ||
                                  _province.text.isEmpty ||
                                  _district.text.isEmpty ||
                                  _municipality.text.isEmpty ||
                                  _ward.text.isEmpty ||
                                  _tole.text.isEmpty ||
                                  _appointmentDate.text.isEmpty) {
                                BotToast.showText(
                                    text: LocaleKeys.warning_msg_fill_all_field
                                        .tr());
                              } else if (!isBookingTypeNew &&
                                  _clientId.text.isEmpty) {
                                BotToast.showText(
                                    text: LocaleKeys.msg_client_id_cannot_be_empty.tr());
                              } else if (isSchemeTypePaying &&
                                  _payingScheme.text.isEmpty) {
                                BotToast.showText(
                                    text: LocaleKeys.label_select_doctor.tr());
                              } else if (!isSchemeTypePaying &&
                                  _generalScheme.text.isEmpty) {
                                BotToast.showText(
                                    text: LocaleKeys
                                        .label_select_general_service
                                        .tr());
                              }
                              else  if(_phone.text.length<10){
                                BotToast.showText(
                                    text: LocaleKeys
                                        .error_msg_invalid_mobile_num
                                        .tr());
                              }
                              else {
                                context.read<BookingCubit>().bookingFormSubmit(
                                    bookingModel: BookingModel(
                                        firstName: _firstName.text,
                                        middleName: _middleName.text,
                                        lastName: _lastName.text,
                                        dob: _dob.text,
                                        gender: _gender.text,
                                        email: _email.text.isEmpty
                                            ? ""
                                            : _email.text,
                                        mobile: _phone.text,
                                        provienceName: _province.text,
                                        districtName: _district.text,
                                        municipalityName: _municipality.text,
                                        wardNo: _ward.text,
                                        tole: _tole.text,
                                        bookingType: isBookingTypeNew
                                            ? "New"
                                            : " Followup",
                                        clinetId: _clientId.text.isEmpty
                                            ? ""
                                            : _clientId.text,
                                        appointmentDate: _appointmentDate.text,
                                        schemeType: isSchemeTypePaying
                                            ? "Paying"
                                            : "General",
                                        id: isSchemeTypePaying
                                            ? _payingSchemeSelectedId.text
                                            : _generalSchemeSelectedId.text));
                              }
                            },
                            title: LocaleKeys.label_proceed_to_pay.tr()),
                        VerticalSpace(40.h),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SwitchWidget extends StatelessWidget {
  const SwitchWidget(
      {Key? key, required this.type, required this.label, required this.onTap})
      : super(key: key);

  final bool type;
  final String label;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          type
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
