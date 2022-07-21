import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/features/symptoms/cubit/symptoms_cubit.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/padding/padding.dart';

class SymptomsPAge extends StatefulWidget {
  const SymptomsPAge({Key? key}) : super(key: key);

  @override
  State<SymptomsPAge> createState() => _SymptomsPAgeState();
}

class _SymptomsPAgeState extends State<SymptomsPAge> {
  @override
  void initState() {
    context.read<SymptomsCubit>().getSymptoms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Container(
            height: 70.h,
            decoration: const BoxDecoration(
                color: AppColors.primaryRed,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
            child: Padding(
              padding: defaultPadding,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                  Spacer(),
                  Text(
                    'Symptoms Assestment',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Spacer()
                ],
              ),
            ),
          ),
          Expanded(child: BlocBuilder<SymptomsCubit, SymptomsState>(
            builder: (context, state) {
              if (state.symptoms == null) {
                return ShimmerLoading(boxHeight: 200.h, itemCount: 4);
              } else if (state.symptoms?.isEmpty ?? false) {
                return Text('NO  REPORTS FOUND');
              } else {
                return ListView.separated(
                    itemBuilder: ((context, index) {
                      return Column(
                        children: [
                          Text(" Report${index + 1}".toUpperCase()),
                          VerticalSpace(10.h),
                          ListTile(
                            trailing: Text(
                              getYesNoValue(state.symptoms?[index].vaginaBleed),
                            ),
                            leading: Text("Bleeding from the vagina"),
                          ),
                          ListTile(
                            trailing: Text(
                              getYesNoValue(state.symptoms?[index].headache),
                            ),
                            leading:
                                Text("Headache a little too much headache"),
                          ),
                          ListTile(
                            trailing: Text(
                              getYesNoValue(
                                  state.symptoms?[index].trembleOrFaint),
                            ),
                            leading: Text("Hands and feet tremable or faint"),
                          ),
                          ListTile(
                            trailing: Text(
                              getYesNoValue(state.symptoms?[index].eyesBlur),
                            ),
                            leading: Text("Eyes blurred"),
                          ),
                          ListTile(
                            trailing: Text(
                              getYesNoValue(
                                  state.symptoms?[index].abdominalPain),
                            ),
                            leading: Text(
                                "Abominal pain in the first month of pregnancy"),
                          ),
                          ListTile(
                            trailing: Text(
                              getYesNoValue(
                                  state.symptoms?[index].feverHundred),
                            ),
                            leading: Text("Fever above 100.4 degree"),
                          ),
                          ListTile(
                            trailing: Text(
                              getYesNoValue(
                                  state.symptoms?[index].difficultBreathe),
                            ),
                            leading: Text("Difficulty in breathing"),
                          ),
                          ListTile(
                            trailing: Text(
                              getYesNoValue(
                                  state.symptoms?[index].coughAndCold),
                            ),
                            leading: Text("Cough and cold"),
                          ),
                          ListTile(
                            trailing: Text(
                              (state.symptoms?[index].otherProblems ??
                                  ''.toString()),
                            ),
                            leading: Text("Headache"),
                          ),
                        ],
                      );
                    }),
                    separatorBuilder: (ctx, index) {
                      return Divider(
                        height: 10.h,
                        indent: 10.w,
                        endIndent: 10.w,
                        color: AppColors.accentGrey,
                      );
                    },
                    itemCount: state.symptoms?.length ?? 0);
              }
            },
          ))
        ],
      )),
    );
  }

  String getYesNoValue(int? value) {
    if (value == 0) {
      return "No";
    } else {
      return "Yes";
    }
  }
}
