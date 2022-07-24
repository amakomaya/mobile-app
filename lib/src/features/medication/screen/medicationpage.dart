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

import '../cubit/medication_page_cubit.dart';

class MedicationPage extends StatefulWidget {
  const MedicationPage({Key? key}) : super(key: key);

  @override
  State<MedicationPage> createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  final controller = PageController();
  @override
  void initState() {
    context.read<MedicationCubit>().getMedication();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => MedicationPageCubit(),
      child: Builder(builder: (context) {
        return SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              PageView(
                onPageChanged: (value) {
                  context.read<MedicationPageCubit>().togglePage(value);
                },
                controller: controller,
                children: [
                  const Center(
                    child: Text('INFORMATION'),
                  ),
                  BlocBuilder<MedicationCubit, MedicationState>(
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
                                    padding: defaultPadding.copyWith(
                                        top: 10, bottom: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          leading: Text(state.medication?[index]
                                                  .vaccineType
                                                  .toString() ??
                                              ''),
                                        ),
                                        Divider(),
                                        ListTile(
                                          leading: Text("given date"),
                                          trailing: Text(state
                                                  .medication?[index]
                                                  .vaccinatedDateNp
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
                                                  .medication?[index]
                                                  .vaccineRegNo
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
                  )
                ],
              ),
              Positioned(
                  left: 100.w,
                  right: 100.w,
                  top: -20,
                  child: BlocBuilder<MedicationPageCubit, int>(
                    builder: (context, state) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: ShadowContainer(
                          shadowColor: Colors.black,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextButton(
                                    onPressed: () {
                                      context
                                          .read<MedicationPageCubit>()
                                          .togglePage(0);
                                      if (state == 1) {
                                        controller.previousPage(
                                            duration: const Duration(
                                                milliseconds: 600),
                                            curve: Curves.easeIn);
                                      }
                                    },
                                    child: Text(
                                      'INFO'.toUpperCase(),
                                      style: theme.textTheme.labelSmall
                                          ?.copyWith(
                                              color: state == 0
                                                  ? AppColors.primaryRed
                                                  : Colors.black),
                                    )),
                              ),
                              Expanded(
                                child: TextButton(
                                    onPressed: () {
                                      context
                                          .read<MedicationPageCubit>()
                                          .togglePage(1);
                                      if (state == 0) {
                                        controller.nextPage(
                                            duration: const Duration(
                                                milliseconds: 600),
                                            curve: Curves.easeIn);
                                      }
                                    },
                                    child: Text(
                                      'REPORT'.toUpperCase(),
                                      style: theme.textTheme.labelSmall
                                          ?.copyWith(
                                              color: state == 1
                                                  ? AppColors.primaryRed
                                                  : Colors.black),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
            ],
          ),
        );
      }),
    );
  }
}
