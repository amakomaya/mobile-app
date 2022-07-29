import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/features/authentication/local_storage/authentication_local_storage.dart';
import 'package:aamako_maya/src/features/card/card_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CardPage extends StatefulWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
    GlobalKey<FormState> formKey =  GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardCubit(AuthLocalData()),
      child: Builder(builder: (context) {
        return BlocBuilder<CardCubit, String>(
          buildWhen: (previous, current) => current.isNotEmpty,
          builder: (context, state) {
            List fist = ["ds", "es", "wd"];

            return QrImage(
              data: state,
              version: QrVersions.auto,
              size: 200.sm,
            );

            List<TextEditingController> list = [];
            for (int i = 0; i <= fist.length; i++) {
              final s =TextEditingController();
              list.add(s);
            }

            print(list.toString());

            return Form(
              key: formKey,
              child: Column(children: [
                Expanded(child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: fist.length,
                  itemBuilder: (c, i) {
                    return TextField(
                      
                      controller: list[i],
                      onChanged: (d){
                        print(d);
                      },
                      decoration: InputDecoration(
                        
                        
                        
                        label: Text(fist[i]),
                        filled: true,
                      ),
                    );
                  }),),
                  ElevatedButton(onPressed: (){
                    print(list[0].text);
                    print(list[1].text);
                    print(list[2].text);
                  }, child: Text('Submit')),
                  VerticalSpace(90.h),
              ],),
            );
          },
        );
      }),
    );
  }
}
