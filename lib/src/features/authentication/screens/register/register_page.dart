import 'package:aamako_maya/src/core/widgets/buttons/primary_action_button.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/features/authentication/cubit/district_municipality_cubit.dart';
import 'package:aamako_maya/src/features/authentication/widgets/register_fields_section.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/padding/padding.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/scaffold/primary_scaffold.dart';

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
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20),
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
                          return ShadowContainer(
                            color: selected.value == inde ? Colors.red : null,
                            margin: defaultPadding,
                            padding:
                                defaultPadding.copyWith(top: 15, bottom: 15),
                            width: size.width,
                            child: Text(
                              registerAs[inde].name,
                              style: TextStyle(
                                  color: selected.value == inde
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          );
                        }),
                  );
                },
              ),
            )),
            PrimaryActionButton(
                onpress: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => RegisterSection(
                          registerAs: registerAs[selected.value].name)));
                },
                title: 'Next'),
            VerticalSpace(50.h),
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
