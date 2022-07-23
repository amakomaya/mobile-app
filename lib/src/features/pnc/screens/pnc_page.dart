import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/features/ancs/cubit/ancs_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/padding/padding.dart';
import '../../../core/theme/app_colors.dart';
import '../cubit/pnc_cubit.dart';

class PncsPage extends StatefulWidget {
  const PncsPage({Key? key}) : super(key: key);

  @override
  State<PncsPage> createState() => _PncsPageState();
}

class _PncsPageState extends State<PncsPage> {
  @override
  void initState() {
    context.read<PncsCubit>().getPncs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Container(
            width: size.width,
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
                    'PNCS',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Spacer()
                ],
              ),
            ),
          ),
          Expanded(child: BlocBuilder<PncsCubit, PncState>(
            builder: (context, state) {
              if (state.pncs == null) {
                return ShimmerLoading(boxHeight: 200.h, itemCount: 4);
              } else if (state.pncs?.isEmpty ?? false) {
                return Text('NO PNC REPORTS FOUND');
              } else {
                return ListView.separated(
                    itemBuilder: ((context, index) {
                      return Column(
                        children: [
                          Text("PNC Report${index + 1}".toUpperCase()),
                          VerticalSpace(10.h),
                          ListTile(
                            trailing: Text(
                                state.pncs?[index].dateOfVisit != null
                                    ? ''
                                    : toString()),
                            leading: Text('Visit of date'),
                          ),
                          ListTile(
                            trailing:
                                Text(state.pncs?[index].motherStatus ?? ''),
                            leading: Text('Mother status'),
                          ),
                          ListTile(
                            trailing: Text(state.pncs?[index].babyStatus ?? ''),
                            leading: Text('Baby Status'),
                          ),
                          ListTile(
                            trailing: Text(state.pncs?[index].familyPlan ?? ''),
                            leading: Text('Family Planning'),
                          ),
                          ListTile(
                            trailing: Text(state.pncs?[index].advice ?? ''),
                            leading: Text('Advices'),
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
                    itemCount: state.pncs?.length ?? 0);
              }
            },
          ))
        ],
      )),
    );
  }
}


//edit

//bloc.add
