import 'package:aamako_maya/src/features/authentication/local_storage/authentication_local_storage.dart';
import 'package:aamako_maya/src/features/card/card_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CardPage extends StatelessWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardCubit(AuthLocalData()),
      child: Builder(builder: (context) {
        return BlocBuilder<CardCubit, String>(
          buildWhen: (previous, current) => current.isNotEmpty,
          builder: (context, state) {
            return QrImage(
              data: state,
              version: QrVersions.auto,
              size: 200.sm,
            );
          },
        );
      }),
    );
  }
}
