import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/features/medication/cubit/medication_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicationPage extends StatefulWidget {
  const MedicationPage({Key? key}) : super(key: key);

  @override
  State<MedicationPage> createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  void initState() {
    context.read<MedicationCubit>().getMedication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                    'Medication',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Spacer()
                ],
              ),
            ),
          ),
          Expanded(child: BlocBuilder<MedicationCubit, MedicationState>(
            builder: (context, state) {
              if (state.medication == null) {
                return ShimmerLoading(boxHeight: 200.h, itemCount: 4);
              } else if (state.medication?.isEmpty ?? false) {
                return Text('NO  REPORTS FOUND');
              } else {
                return ListView.separated(
                    itemBuilder: ((context, index) {
                      return Column(
                        children: [
                          ShadowContainer(
                            radius: 20,
                            width: 380.w,
                            color: Colors.white,
                            padding:
                                defaultPadding.copyWith(top: 10, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: Text(state
                                          .medication?[index].vaccineType
                                          .toString() ??
                                      ''),
                                ),
                                Divider(),
                                ListTile(
                                  leading: Text("given date"),
                                  trailing: Text(state
                                          .medication?[index].vaccinatedDateNp
                                          .toString() ??
                                      ''),
                                ),
                                ListTile(
                                  leading: Text("Iron Pill"),
                                  trailing: Text(state
                                          .medication?[index].noOfPills
                                          .toString() ??
                                      ''),
                                ),
                                ListTile(
                                  leading: Text(" VaccineReg NO"),
                                  trailing: Text(state
                                          .medication?[index].vaccineRegNo
                                          .toString() ??
                                      ''),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                    separatorBuilder: (ctx, index) {
                      return Divider(
                        color: AppColors.white,
                      );
                    },
                    itemCount: state.medication?.length ?? 0);
              }
            },
          ))
        ],
      )),
    );
  }
}
