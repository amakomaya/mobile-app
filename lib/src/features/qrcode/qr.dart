import 'package:aamako_maya/src/features/card/card_cubit.dart';
import 'package:aamako_maya/src/features/fetch%20user%20data/cubit/get_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../authentication/local_storage/authentication_local_storage.dart';

class QrCode extends StatefulWidget {
  const QrCode({Key? key}) : super(key: key);

  @override
  State<QrCode> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      color: Color.fromARGB(255, 241, 243, 141),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                "Pregnant Women Card",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.download, color: Colors.black))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: BlocProvider(
                create: (context) =>
                    CardCubit(AuthLocalData())..getTokenForQr(),
                child: Builder(builder: (context) {
                  return BlocBuilder<CardCubit, String>(
                    builder: (context, state) {
                      print(state + " Basyal generating qr code");

                      return QrImage(
                        data: state,
                        version: QrVersions.auto,
                        size: 200.sm,
                      );
                    },
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, top: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text("Name : " " Test"),
                          BlocConsumer<GetUserCubit, GetUserState>(
                            listener: (context, state) {
                              if (state is GetUserSuccess) {
                                _name.text = state.user.name ?? '';
                               
                              }
                            },
                            builder: (context, state) {
                              return Column(
                                children: [
                                  Text("Name : " + _name.text),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 30),
                        child: Row(
                          children: [
                            BlocConsumer<GetUserCubit, GetUserState>(
                              listener: (context, state) {
                                if (state is GetUserSuccess) {
                                  _phone.text =
                                      state.user.phone ?? '';
                                 
                                }
                              },
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    Text("Phone : " + _phone.text),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                 
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18, left: 20, right: 20),
              child: Container(
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 50,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Center(
                        child: Text(
                          "Note: You Need to bring this card to check up",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    
  }
}
