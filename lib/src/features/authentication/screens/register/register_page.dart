// ignore_for_file: prefer_const_constructors

import 'package:aamako_maya/src/core/widgets/border_container.dart';
import 'package:aamako_maya/src/core/widgets/buttons/localization_button.dart';
import 'package:aamako_maya/src/core/widgets/buttons/primary_action_button.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/scaffold/primary_appBar.dart';
import 'package:aamako_maya/src/features/authentication/cubit/district_municipality_cubit.dart';
import 'package:aamako_maya/src/features/authentication/widgets/register_fields_section.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/padding/padding.dart';
import '../../../../core/theme/app_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    context.read<DistrictMunicipalityCubit>().startDistrictMunicipalityFetch();
    super.initState();
  }

  List<RegisterAsModel> registerAs = [
    RegisterAsModel(id: 1, name: "Preparing for pregnancy", value: "planning"),
    RegisterAsModel(id: 2, name: "Pregnant", value: "pregnant"),
    RegisterAsModel(id: 3, name: "Growth of child", value: "ongoing"),
  ];
  ValueNotifier<int> selected = ValueNotifier(1);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            PrimaryAppBar(
              isUnauth: true,
              unAuthChild: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 18.0, bottom: 12),
                    child: Text(
                      'Register',
                      style: TextStyle(
                          fontFamily: 'lato',
                          fontSize: 22,
                          color: Colors.white),
                    ),
                  ),
                 
                  LocalizationButton(
                    icon: Icon(Icons.more_vert_outlined),
                  )
                ],
              ),
            ),
            VerticalSpace(10),
            Column(
              children: const [
                Text(
                  "Choose Option that describe your need",
                  style: TextStyle(fontSize: 17, fontFamily: 'lato'),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (c, i) => VerticalSpace(20.h),
                itemCount: registerAs.length,
                itemBuilder: (c, inde) {
                  return GestureDetector(
                    onTap: () {
                      selected.value = 1;
                      if (inde == 0 || inde == 2) {
                        BotToast.showText(
                            text: "Option Unavailable at the moment");
                      }
                    },
                    child: ValueListenableBuilder(
                        valueListenable: selected,
                        builder: (context, i, _) {
                          return BorderContainer(
                            hasBorder: true,
                            color: i == inde ? Colors.red : Colors.grey,
                            margin: defaultPadding,
                            padding:
                                defaultPadding.copyWith(top: 15, bottom: 15),
                            width: size.width,
                            child: Text(
                              registerAs[inde].name,
                            ),
                          );
                        }),
                  );
                },
              ),
            )),
            PrimaryActionButton(
                width: 170.w,
                onpress: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => RegisterSection(
                          registerAs: registerAs[selected.value].name)));
                },
                title: 'Next'),
            VerticalSpace(500.h),
          ],
        ),
      ),
    );
  }
}

class RegisterAsModel {
  int id;
  String name;
  String value;
  RegisterAsModel({required this.name, required this.value, required this.id});
}
