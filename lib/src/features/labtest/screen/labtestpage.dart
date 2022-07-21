import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
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
                          Text("LabTest Report${index + 1}".toUpperCase()),
                          VerticalSpace(10.h),
                          ListTile(
                            trailing: Text(state.labtest?[0].testDate != null
                                ? ''
                                : toString()),
                            leading: Text('TestDate'),
                          ),
                          ListTile(
                            trailing: Text(state.labtest?[index].hb ?? ''),
                            leading: Text('Hb'),
                          ),
                          ListTile(
                            trailing: Text(state.labtest?[index].albumin ?? ''),
                            leading: Text(' Albmin'),
                          ),
                          ListTile(
                            trailing:
                                Text(state.labtest?[index].urineProtein ?? ''),
                            leading: Text(' Urine Prtein'),
                          ),
                          ListTile(
                            trailing:
                                Text(state.labtest?[index].urineSugar ?? ''),
                            leading: Text(' Urine sugar'),
                          ),
                          ListTile(
                            trailing: Text(state.labtest?[index].hbsag ?? ''),
                            leading: Text(' HBsAg'),
                          ),
                          ListTile(
                            trailing: Text(state.labtest?[index].vdrl ?? ''),
                            leading: Text(' VdRl'),
                          ),
                          ListTile(
                            trailing:
                                Text(state.labtest?[index].retroVirus ?? ''),
                            leading: Text(' Retro Virus'),
                          ),
                          ListTile(
                            trailing: Text(state.labtest?[index].other ?? ''),
                            leading: Text(' Others'),
                          ),
                        ],
                      );
                    }),
                    separatorBuilder: (ctx, index) {
                      return Divider(
                        height: 10.h,
                        indent: 10.w,
                        endIndent: 10.w,
                        color: Color.fromARGB(255, 31, 6, 6),
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
