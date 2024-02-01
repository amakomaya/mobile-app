import 'package:Amakomaya/src/core/widgets/textfield/primary_textfield.dart';
import 'package:Amakomaya/src/features/authentication/cubit/district_municipality_cubit.dart';
import 'package:Amakomaya/src/features/fetch%20user%20data/cubit/get_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    var appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Text(
          "${appLocalizations.msg_appointment_inprogress} 😮‍💨",
          style: TextStyle(fontSize: 24.sm),
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
