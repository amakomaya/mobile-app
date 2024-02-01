import 'package:Amakomaya/src/core/theme/app_colors.dart';
import 'package:Amakomaya/src/core/widgets/border_container.dart';
import 'package:Amakomaya/src/core/widgets/buttons/localization_button.dart';
import 'package:Amakomaya/src/core/widgets/buttons/primary_action_button.dart';
import 'package:Amakomaya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:Amakomaya/src/core/widgets/scaffold/primary_appBar.dart';
import 'package:Amakomaya/src/features/authentication/widgets/register_fields_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../l10n/locale_keys.g.dart';
import '../../../../core/padding/padding.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  ValueNotifier<int> selected = ValueNotifier(1);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<RegisterAsModel> registerAs = [
      RegisterAsModel(
        id: 1,
        text: LocaleKeys.label_women_health.tr(),
        value: "planning",
        image: Image.asset(
          'assets/images/logo/item1.png',
          height: 60.w,
          width: 60.w,
          fit: BoxFit.fitWidth,
        ),
      ),
      RegisterAsModel(
        id: 2,
        text: LocaleKeys.label_pregnant.tr(),
        value: "pregnant",
        image: Image.asset(
          'assets/images/logo/item2.png',
          height: 60.w,
          width: 60.w,
          fit: BoxFit.cover,
        ),
      ),
      RegisterAsModel(
        id: 3,
        text: LocaleKeys.label_growth_of_child.tr(),
        value: "ongoing",
        image: Image.asset(
          'assets/images/logo/item3.png',
          height: 70.w,
          width: 70.w,
          // colorBlendMode: BlendMode.darken,
          fit: BoxFit.cover,
        ),
      ),
    ];
    return SafeArea(
      child: Scaffold(
        body:Column(
              children: <Widget>[
                PrimaryAppBar(
                  isUnauth: true,
                  unAuthChild: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: REdgeInsets.only(left: 18.0, bottom: 12),
                        child: Text(
                          LocaleKeys.label_register.tr(),
                          style:  TextStyle(
                              fontFamily: 'lato',
                              fontSize: 18.sm,
                              color: Colors.white),
                        ),
                      ),
                      const LocalizationButton(
                        icon: Icon(Icons.more_vert_outlined),
                      )
                    ],
                  ),
                ),
                VerticalSpace(10.h),
                Column(
                  children: [
                    Text(
                      LocaleKeys.label_choose_option_your_need.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18.sm, fontFamily: 'lato'),
                    )
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: REdgeInsets.all(10.0),
                  child: Card(
                    child: Padding(
                      padding:REdgeInsets.all(12.0),
                      child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (c, i) => VerticalSpace(5.h),
                        itemCount: registerAs.length,
                        itemBuilder: (c, inde) {
                          return GestureDetector(
                            onTap: () {
                              selected.value = inde;
                              // if (inde == 0 || inde == 2) {
                              //   BotToast.showText(
                              //       text: LocaleKeys
                              //           .msg_option_unavailable.tr());
                              // }
                            },
                            child: Padding(
                              padding: REdgeInsets.all(8.0),
                              child: ValueListenableBuilder(
                                  valueListenable: selected,
                                  builder: (context, i, _) {
                                    return BorderContainer(
                                        hasBorder: true,
                                        color: i == inde
                                            ? AppColors.primaryRed
                                            : Colors.grey,
                                        margin: defaultPadding,
                                        padding: defaultPadding.copyWith(
                                            top: 15.r, bottom: 15.r),
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
                                                    registerAs[inde]
                                                        .image
                                                        .image,
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
                              registerAs: registerAs[selected.value].text, selectedIndex: selected.value,)));
                    },
                    title: LocaleKeys.label_next.tr()),
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
