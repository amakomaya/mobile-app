// ignore_for_file: prefer_const_constructors

import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/features/delivery/cubit/delivery_cubit.dart';
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
                          Text("delivery Report${index + 1}".toUpperCase()),
                          VerticalSpace(10.h),
                          ListTile(
                            trailing: Text(
                                state.delivery?[0].deliveryDate != null
                                    ? ''
                                    : toString()),
                            leading: Text('Delivery date'),
                          ),
                          ListTile(
                            trailing:
                                Text(state.delivery?[index].deliveryTime ?? ''),
                            leading: Text(' Delivery Time'),
                          ),
                          ListTile(
                            trailing: Text(
                                state.delivery?[index].deliveryPlace ?? ''),
                            leading: Text(' Delivery Place'),
                          ),
                          Divider(),
                          ListTile(
                            trailing:
                                Text(state.delivery?[0].deliveryType ?? ''),
                            leading: Text("Delivery Type"),
                          ),
                          ListTile(
                            trailing:
                                Text(state.delivery?[0].presentation ?? ''),
                            leading: Text("Presentation"),
                          ),
                          ListTile(
                            trailing: Text(state.delivery?[0].complexity != null
                                ? ''.toString()
                                : toString()),
                            leading: Text("Complexity"),
                          ),
                          Divider(),
                          ListTile(
                            trailing:
                                Text(state.delivery?[0].otherProblem ?? ''),
                            leading: Text("Other Problems"),
                          ),
                          ListTile(
                            trailing: Text(state.delivery?[0].advice ?? ''),
                            leading: Text("Advice"),
                          ),
                          ListTile(
                            trailing: Text(state.delivery?[0].deliveryBy ?? ''),
                            leading: Text("Delivery By"),
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
                    itemCount: state.delivery?.length ?? 0);
              }
            },
          ))
        ],
      )),
    );
  }
}
