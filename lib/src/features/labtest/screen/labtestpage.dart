import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';

import 'package:aamako_maya/src/features/labtest/cubit/labtest_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Labtestpage extends StatefulWidget {
  const Labtestpage({Key? key}) : super(key: key);

  @override
  State<Labtestpage> createState() => _LabtestpageState();
}

class _LabtestpageState extends State<Labtestpage> {
  @override
  void initState() {
    context.read<LabtestCubit>().getlabtest();
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
                    'Lab Test',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Spacer()
                ],
              ),
            ),
          ),
          Expanded(child: BlocBuilder<LabtestCubit, labtestState>(
            builder: (context, state) {
              if (state.labtest == null) {
                return ShimmerLoading(boxHeight: 200.h, itemCount: 4);
              } else if (state.labtest?.isEmpty ?? false) {
                return Text('NO labtest REPORTS FOUND');
              } else {
                return ListView.separated(
                    itemBuilder: ((context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(" Report${index + 1}".toUpperCase(),
                                style: const TextStyle(
                                    fontFamily: "lato",
                                    color: AppColors.primaryRed,
                                    fontSize: 17)),
                          ),
                          VerticalSpace(12.h),
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
                                  leading: Text("Visit Date",
                                      style: theme.textTheme.labelSmall),
                                  trailing: Text(
                                      state.labtest?[index].testDate
                                              .toString() ??
                                          '',
                                      style: theme.textTheme.labelSmall),
                                ),
                                Divider(),
                                ListTile(
                                  leading: Text("HB",
                                      style: theme.textTheme.labelSmall),
                                  trailing: Text(
                                      state.labtest?[index].hb.toString() ?? '',
                                      style: theme.textTheme.labelSmall),
                                ),
                                ListTile(
                                  leading: Text("Albumin",
                                      style: theme.textTheme.labelSmall),
                                  trailing: Text(
                                      state.labtest?[index].albumin
                                              .toString() ??
                                          '',
                                      style: theme.textTheme.labelSmall),
                                ),
                                ListTile(
                                  leading: Text("Urine Protein",
                                      style: theme.textTheme.labelSmall),
                                  trailing: Text(
                                      state.labtest?[index].urineProtein
                                              .toString() ??
                                          '',
                                      style: theme.textTheme.labelSmall),
                                ),
                                ListTile(
                                  leading: Text("Urine Sugar",
                                      style: theme.textTheme.labelSmall),
                                  trailing: Text(
                                      state.labtest?[index].urineSugar
                                              .toString() ??
                                          '',
                                      style: theme.textTheme.labelSmall),
                                ),
                                ListTile(
                                  leading: Text("Blood Sugar",
                                      style: theme.textTheme.labelSmall),
                                  trailing: Text(
                                      state.labtest?[index].bloodSugar
                                              .toString() ??
                                          '',
                                      style: theme.textTheme.labelSmall),
                                ),
                                ListTile(
                                  leading: Text("HBsAg",
                                      style: theme.textTheme.labelSmall),
                                  trailing: Text(
                                      state.labtest?[index].hbsag.toString() ??
                                          '',
                                      style: theme.textTheme.labelSmall),
                                ),
                                ListTile(
                                  leading: Text("VDRL",
                                      style: theme.textTheme.labelSmall),
                                  trailing: Text(
                                      state.labtest?[index].vdrl.toString() ??
                                          '',
                                      style: theme.textTheme.labelSmall),
                                ),
                                ListTile(
                                  leading: Text("Retro Virus",
                                      style: theme.textTheme.labelSmall),
                                  trailing: Text(
                                      state.labtest?[index].retroVirus
                                              .toString() ??
                                          '',
                                      style: theme.textTheme.labelSmall),
                                ),
                                Divider(),
                                ListTile(
                                  leading: Text("Others",
                                      style: theme.textTheme.labelSmall),
                                  trailing: Text(
                                      state.labtest?[index].other.toString() ??
                                          '',
                                      style: theme.textTheme.labelSmall),
                                ),
                                VerticalSpace(12.h),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                    separatorBuilder: (ctx, index) {
                      return const Divider(
                        color: Colors.white,
                      );
                    },
                    itemCount: state.labtest?.length ?? 0);
              }
            },
          ))
        ],
      )),
    );
  }
}
