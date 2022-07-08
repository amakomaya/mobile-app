import 'package:aamako_maya/src/core/padding/padding.dart';
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
import '../register_bloc/register_bloc.dart';
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
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isLoading && state.error == null) {
          BotToast.showLoading();
        }
        if (state.error != null) {
          BotToast.closeAllLoading();
          BotToast.showText(text: state.error ?? 'Something Went Wrong');
        }
        state.when(
            initial: ((isLoading, error) {}),
            success: ((isLoading, error, user) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                return const CustomBottomNavigation();
              }), (route) => false);
              BotToast.showText(
                  text: state.error ?? 'Registered Successfully!!');
            }));
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: _name,
                        decoration: InputDecoration(
                          label: Text('Name'),
                        ),
                      ),
                      TextField(
                        controller: _age,
                        decoration: InputDecoration(
                          label: Text('Age'),
                        ),
                      ),
                      TextField(
                        controller: _lmp,
                        decoration: InputDecoration(
                          label: Text('LMP'),
                        ),
                      ),
                      DistrictDropDownListWidget(),
                      MunicipalityDropdownListWidget(),
                      TextField(
                        controller: _ward,
                        decoration: InputDecoration(
                          label: Text('Ward no'),
                        ),
                      ),
                      TextField(
                        controller: _tole,
                        decoration: InputDecoration(
                          label: Text('Tole'),
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          label: Text('Mobile Number'),
                        ),
                      ),
                    ],
                  ),
                )),
                PrimaryActionButton(
                    onpress: () {
                      context.read<RegisterBloc>().add(
                            RegisterEvent.gegisterStarted(
                                user: RegisterRequestModel()),
                          );

                      // print(widget.reg.toJson());
                    },
                    title: 'Register'),
                VerticalSpace(50.h),
              ],
            ));
      },
    );
  }
}
