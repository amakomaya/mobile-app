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
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 400,
        color: Colors.grey,
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
                                if (_formKey.currentState!.validate()) {
                                  print('name:${_name.text.toString()}');
                                }
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
                          children: const [
                            Text("Phone: " " 9860479552"),
                          ],
                        ),
                      )
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

    // return DefaultTabController(
    //   initialIndex: 0,
    //   length: 2,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       backgroundColor: Color.fromARGB(255, 1, 149, 255),
    //       bottom: TabBar(tabs: [
    //         Tab(
    //           text: "QR Code for Mummy",
    //         ),
    //         Tab(
    //           text: "QR Code for Baby",
    //         ),
    //       ]),
    //     ),
    //     body: TabBarView(children: [
    //       Container(
    //         //for first tab

    //         child: Column(
    //           children: [
    //             Flexible(
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Padding(
    //                     padding: const EdgeInsets.only(top: 30, left: 10),
    //                     child: Container(
    //                       child: Padding(
    //                         padding: const EdgeInsets.only(top: 30, left: 5),
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.start,
    //                           children: [
    //                             Text(
    //                               "Pregnant Women Card",
    //                               style: TextStyle(
    //                                   fontSize: 17,
    //                                   fontWeight: FontWeight.bold),
    //                             ),
    //                             Padding(
    //                               padding: EdgeInsets.only(right: 5),
    //                               child: Divider(
    //                                 color: Colors.black,
    //                               ),
    //                             ),
    //                             SizedBox(
    //                               height: 20,
    //                             ),
    //                             BlocProvider(
    //                               create: (context) =>
    //                                   CardCubit(AuthLocalData())
    //                                     ..getTokenForQr(),
    //                               child: Builder(builder: (context) {
    //                                 return BlocBuilder<CardCubit, String>(
    //                                   builder: (context, state) {
    //                                     print(state +
    //                                         " Basyal generating qr code");

    //                                     return QrImage(
    //                                       data: state,
    //                                       version: QrVersions.auto,
    //                                       size: 200.sm,
    //                                     );
    //                                   },
    //                                 );
    //                               }),
    //                             )
    //                           ],
    //                         ),
    //                       ),

    //                       //Text("Municipality Report"),
    //                       color: Color.fromARGB(179, 213, 211, 211),
    //                       height: 290,
    //                       width: 170,
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.only(top: 30, right: 10),
    //                     child: Container(
    //                       child: Padding(
    //                         padding: const EdgeInsets.only(top: 30, left: 5),
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.start,
    //                           children: [
    //                             Text(
    //                               "Pregnant Women Card",
    //                               style: TextStyle(
    //                                   fontSize: 17,
    //                                   fontWeight: FontWeight.bold),
    //                             ),
    //                             Padding(
    //                               padding: EdgeInsets.only(right: 5),
    //                               child: Divider(
    //                                 color: Colors.yellow,
    //                               ),
    //                             ),
    //                             SizedBox(
    //                               height: 20,
    //                             ),
    //                             Text("Municipality Report"),
    //                             Padding(
    //                               padding: EdgeInsets.only(left: 10, top: 25),
    //                               child: Row(children: [
    //                                 Icon(Icons.person),
    //                                 // Text(" Name "),
    // BlocConsumer<GetUserCubit, GetUserState>(
    //   listener: (context, state) {
    //     if (state is GetUserSuccess) {
    //       _name.text = state.user.name ?? '';
    //     }
    //   },
    //   builder: (context, state) {
    //     return Column(
    //       children: [
    //         Text("Name : " + _name.text),
    //       ],
    //     );
    //   },
    // ),
    //                               ]),
    //                             ),
    //                             Padding(
    //                               padding: EdgeInsets.only(left: 10, top: 10),
    //                               child: Row(children: [
    //                                 Icon(Icons.phone_android_outlined),
    //                                 Text(" Phone "),
    //                                 Text(": 9851071281 "),
    //                               ]),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                       color: Colors.grey,
    //                       height: 290,
    //                       width: 220,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       Container(
    //         //for second tab
    //         height: 400,
    //         child: Center(child: Text('No Data Found 😢, Try again 😂')),
    //       ),
    //     ]),
    //   ),
    // );
  }
}
