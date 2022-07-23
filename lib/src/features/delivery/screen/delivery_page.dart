// ignore_for_file: prefer_const_constructors

import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/features/delivery/cubit/delivery_cubit.dart';
import 'package:aamako_maya/src/features/medication/cubit/medication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({Key? key}) : super(key: key);

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  @override
  void initState() {
    context.read<DeliverCubit>().getDelivery();
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
                    'Delivery Test',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Spacer()
                ],
              ),
            ),
          ),
          Expanded(child: BlocBuilder<DeliverCubit, DeliveryState>(
            builder: (context, state) {
              if (state.delivery == null) {
                return ShimmerLoading(boxHeight: 200.h, itemCount: 4);
              } else if (state.delivery?.isEmpty ?? false) {
                return Text('NO  REPORTS FOUND');
              } else {
                return ListView.separated(
                    itemBuilder: ((context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "Delivery Report${index + 1}".toUpperCase(),
                                style: const TextStyle(
                                    fontFamily: "lato",
                                    color: AppColors.primaryRed,
                                    fontSize: 17)),
                          ),
                          VerticalSpace(10.h),
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
                                  leading: Text("Delivery Date",
                                      style: theme.textTheme.labelSmall),
                                  trailing: Text(state
                                          .delivery?[index].deliveryDate
                                          .toString() ??
                                      ''),
                                ),
                                ListTile(
                                  leading: Text("Delivery Time",
                                      style: theme.textTheme.labelSmall),
                                  trailing: Text(state
                                          .delivery?[index].deliveryTime
                                          .toString() ??
                                      ''),
                                ),
                                ListTile(
                                  leading: Text("Delivery Place",
                                      style: theme.textTheme.labelSmall),
                                  trailing: Text(state
                                          .delivery?[index].deliveryPlace
                                          .toString() ??
                                      ''),
                                ),
                                Divider(),
                                ListTile(
                                  leading: Text("Delivery Date",
                                      style: theme.textTheme.labelSmall),
                                  trailing: Text(state
                                          .delivery?[index].deliveryType
                                          .toString() ??
                                      ''),
                                ),
                                ListTile(
                                  leading: Text("Presentation",
                                      style: theme.textTheme.labelSmall),
                                  trailing: Text(state
                                          .delivery?[index].presentation
                                          .toString() ??
                                      ''),
                                ),
                                ListTile(
                                  leading: Text("Complexity",
                                      style: theme.textTheme.labelSmall),
                                  trailing: Text(state
                                          .delivery?[index].complexity
                                          .toString() ??
                                      ''),
                                ),
                                Divider(),
                                ListTile(
                                  leading: Text("Others Problems",
                                      style: theme.textTheme.labelSmall),
                                  trailing: Text(state
                                          .delivery?[index].otherProblem
                                          .toString() ??
                                      ''),
                                ),
                                ListTile(
                                  leading: Text("Advice",
                                      style: theme.textTheme.labelSmall),
                                  trailing: Text(state.delivery?[index].advice
                                          .toString() ??
                                      ''),
                                ),
                                ListTile(
                                  leading: Text("Delivery By",
                                      style: theme.textTheme.labelSmall),
                                  trailing: Text(state
                                          .delivery?[index].deliveryBy
                                          .toString() ??
                                      ''),
                                ),
                              ],
                            ),
                          ),
                          VerticalSpace(15.h),
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
                    itemCount: state.delivery?.length ?? 0);
              }
            },
          ))
        ],
      )),
    );
  }
}
