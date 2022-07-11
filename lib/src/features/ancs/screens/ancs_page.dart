import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/scaffold/primary_scaffold.dart';
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

class AncsPage extends StatelessWidget {
  const AncsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dismissible(
      background: Container(
        color: Colors.white,
      
      ),
      key: ValueKey('DissmissANCs'),
      direction: DismissDirection.startToEnd,
     onDismissed: (direction){
      Navigator.pop(context);


     }, 
      child: SafeArea(
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
                      'ANCS',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Spacer()
                  ],
                ),
              ),
            ),
            Expanded(child: BlocBuilder<AncsCubit, AncsState>(
              builder: (context, state) {
                return ListView.separated(
                    itemBuilder: ((context, index) {
                      return Text(state.ancs?[index].babyPresentation ?? '');
                    }),
                    separatorBuilder: (ctx, index) {
                      return VerticalSpace(10.h);
                    },
                    itemCount: state.ancs?.length ?? 0);
              },
            ))
          ],
        )),
      ),
    );
  }
}
