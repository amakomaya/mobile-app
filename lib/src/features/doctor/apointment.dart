import 'package:aamako_maya/l10n/locale_keys.g.dart';
import 'package:aamako_maya/src/core/widgets/textfield/primary_textfield.dart';
import 'package:aamako_maya/src/features/authentication/cubit/district_municipality_cubit.dart';
import 'package:aamako_maya/src/features/fetch%20user%20data/cubit/get_user_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Apointment extends StatefulWidget {
  const Apointment({Key? key}) : super(key: key);

  @override
  State<Apointment> createState() => _ApointmentState();
}

class _ApointmentState extends State<Apointment> {
  final TextEditingController _name = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    context.read<DistrictMunicipalityCubit>().startDistrictMunicipalityFetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Text(
          "Appointment is in progress 😮‍💨",
          style: TextStyle(fontSize: 24),
        ),
      )),
    );
    // return BlocConsumer<GetUserCubit, GetUserState>(listener: (context, state) {
    //   if (state is GetUserSuccess) {
    //     _name.text = state.user.name ?? '';
    //   }
    // }, builder: (context, state) {
    //   return SingleChildScrollView(
    //     child: Form(
    //       key: _formKey,
    //       child: PrimaryTextField(
    //         controller: _name,
    //         labelText: LocaleKeys.name.tr(),
    //         validator: (value) {
    //           if (value!.isEmpty) {
    //             return 'Name can not be Empty';
    //           }
    //           return null;
    //         },
    //       ),
    //     ),
    //   );
    // });
  }
}
