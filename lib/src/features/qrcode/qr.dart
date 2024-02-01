import 'dart:typed_data';

import 'package:Amakomaya/src/features/card/card_cubit.dart';
import 'package:Amakomaya/src/features/fetch%20user%20data/cubit/get_user_cubit.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:io';
import 'dart:ui' as ui;
import '../../core/widgets/helper_widgets/shadow_container.dart';
import '../authentication/local_storage/authentication_local_storage.dart';

class QrCode extends StatefulWidget {
  const QrCode({Key? key}) : super(key: key);

  @override
  State<QrCode> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  late TargetPlatform? platform;
  late bool _permissionReady;

  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey genKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
  }

  Future<bool> _checkPermission() async {
    if (platform == TargetPlatform.android) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final sdkInt = androidInfo.version.sdkInt ?? 32;
      var  status;
      if (sdkInt >=33) {
        status  = await Permission.phone.status;
      }
      else{
        status = await Permission.storage.status;
      }

      if (status != PermissionStatus.granted) {
        var result ;
        if (sdkInt >=33) {
          result = await Permission.photos.request();
        }
        else{
          result = await Permission.storage.request();
        }
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<Uint8List?> takePicture() async {
    RenderRepaintBoundary boundary = genKey.currentContext?.findRenderObject()  as RenderRepaintBoundary ;
    final image = await boundary.toImage(pixelRatio: 3);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData?.buffer.asUint8List();
    FlushbarHelper.createInformation(message: "Downloading").show(context);
    try {
      await ImageGallerySaver.saveImage(pngBytes!);
      FlushbarHelper.createSuccess(
              message: "Download Completed. Check in your image gallery")
          .show(context);
    } catch (e) {
      FlushbarHelper.createError(message: "Download failed").show(context);
    }
    return pngBytes;
  }

  @override
  Widget build(BuildContext context) {

    return RepaintBoundary(
      key: genKey,
      child: ShadowContainer(
        radius: 20.r,
        margin: REdgeInsets.all(45.0),
        child: Stack(children: [
          Positioned(
            right: 10.r,
            top: 15.r,
            child: IconButton(
                onPressed: () async {
                  BotToast.showText(text: 'pppppp !');
                  _permissionReady = await _checkPermission();
                  BotToast.showText(text: '$_permissionReady');
                  if (_permissionReady) {
                    BotToast.showText(text: 'ssss!');
                    takePicture();
                  }
                },
                icon: Icon(Icons.download, color: Colors.black, size: 36.r)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: REdgeInsets.only(left: 20.0, top: 20.0),
                child: Text(
                  "Pregnancy Card",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Lato-Bold',
                    fontSize: 20.sm,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              BlocProvider(
                create: (context) => CardCubit(AuthLocalData())..getTokenForQr(),
                child: Builder(builder: (context) {
                  return BlocBuilder<CardCubit, String>(
                    builder: (context, state) {
                      print(state + " Basyal generating qr code");

                      return Center(
                        child: QrImageView(
                          data: state,
                          version: QrVersions.auto,
                          size: 200.sm,
                        ),
                      );
                    },
                  );
                }),
              ),
              SizedBox(
                height: 40.h,
              ),
              BlocConsumer<GetUserCubit, GetUserState>(
                listener: (context, state) {
                  if (state is GetUserSuccess) {
                    _name.text = state.user.name ?? '';
                  }
                },
                builder: (context, state) {
                  return Padding(
                    padding: REdgeInsets.only(left: 70.0),
                    child: Text(
                      "Name : " + _name.text,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Lato-Black',
                        fontSize: 20.sm,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              BlocConsumer<GetUserCubit, GetUserState>(
                listener: (context, state) {
                  if (state is GetUserSuccess) {
                    _phone.text = state.user.phone ?? '';
                  }
                },
                builder: (context, state) {
                  return Padding(
                    padding: REdgeInsets.only(left: 70.0),
                    child: Text("Phone : " + _phone.text,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Lato-Black',
                          fontSize: 20.sm,
                        )),
                  );
                },
              ),
              SizedBox(height: 40.h),
              Center(
                child: Text(
                  "Note: You need to bring this card to checkup",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w900,
                      fontSize: 16.sm),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ]),
      ),
    );
  }
}
