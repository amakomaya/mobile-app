import 'package:aamako_maya/l10n/locale_keys.g.dart';
import 'package:aamako_maya/src/core/widgets/border_container.dart';
import 'package:aamako_maya/src/core/widgets/buttons/localization_button.dart';
import 'package:aamako_maya/src/core/widgets/buttons/primary_action_button.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/scaffold/primary_appBar.dart';
import 'package:aamako_maya/src/features/authentication/cubit/district_municipality_cubit.dart';
import 'package:aamako_maya/src/features/authentication/widgets/register_fields_section.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
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
  List<RegisterAsModel> registerAs = [
    RegisterAsModel(
      id: 1,
      text: LocaleKeys.preparingforpregancy.tr(),
      value: "planning",
      image: Image.asset(
        'assets/images/logo/item1.png',
        height: 60,
        width: 60,
        fit: BoxFit.fitWidth,
      ),
    ),
    RegisterAsModel(
      id: 2,
      text: LocaleKeys.pregnant.tr(),
      value: "pregnant",
      image: Image.asset(
        'assets/images/logo/item2.png',
        height: 60,
        width: 60,
        fit: BoxFit.cover,
      ),
    ),
    RegisterAsModel(
      id: 3,
      text: LocaleKeys.growth.tr(),
      value: "ongoing",
      image: Image.asset(
        'assets/images/logo/item3.png',
        height: 70,
        width: 70,
        // colorBlendMode: BlendMode.darken,
        fit: BoxFit.cover,
      ),
    ),
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
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, bottom: 12),
                    child: Text(
                      LocaleKeys.registered.tr(),
                      style: const TextStyle(
                          fontFamily: 'lato',
                          fontSize: 22,
                          color: Colors.white),
                    ),
                  ),
                  const LocalizationButton(
                    icon: Icon(Icons.more_vert_outlined),
                  )
                ],
              ),
            ),
            const VerticalSpace(10),
            Column(
              children: [
                Text(
                  LocaleKeys.option.tr(),
                  style: const TextStyle(fontSize: 17, fontFamily: 'lato'),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (c, i) => VerticalSpace(5.h),
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ValueListenableBuilder(
                              valueListenable: selected,
                              builder: (context, i, _) {
                                return BorderContainer(
                                    hasBorder: true,
                                    color:
                                        i == inde ? Colors.black : Colors.grey,
                                    margin: defaultPadding,
                                    padding: defaultPadding.copyWith(
                                        top: 15, bottom: 15),
                                    width: size.width,
                                    child: SingleChildScrollView(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(registerAs[inde].text),
                                          // SizedBox(
                                          //   width: 90,
                                          // ),
                                          // CircleAvatar(

                                          //  ),

                                          // Image(
                                          //     image: registerAs[inde].image.image)

                                          CircleAvatar(
                                            backgroundColor: Colors.white,
                                            backgroundImage:
                                                registerAs[inde].image.image,
                                          )
                                        ],
                                      ),
                                    ));
                              }),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            VerticalSpace(10.h),
            PrimaryActionButton(
                width: 170.w,
                onpress: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => RegisterSection(
                          registerAs: registerAs[selected.value].text)));
                },
                title: LocaleKeys.next.tr()),
          ],
        ),
      ),
    );
  }
}

class RegisterAsModel {
  int id;
  String text;
  String value;
  Image image;
  RegisterAsModel(
      {required this.text,
      required this.value,
      required this.id,
      required this.image});
}
