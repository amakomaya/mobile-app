import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/scaffold/primary_scaffold.dart';
import 'package:aamako_maya/src/features/ancs/cubit/ancs_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AncsPage extends StatelessWidget {
  const AncsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
        appBartitle: 'ANCS',
        body: BlocBuilder<AncsCubit, AncsState>(
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
        ));
  }
}
