import 'dart:async';

import 'package:aamako_maya/src/features/bottom_nav/bottom_navigation.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../core/theme/app_colors.dart';
import '../../authentication_cubit/auth_cubit.dart';

class QRViewPage extends StatefulWidget {
  const QRViewPage({Key? key}) : super(key: key);

  @override
  State<QRViewPage> createState() => _QRViewPageState();
}

class _QRViewPageState extends State<QRViewPage> {
  String? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((onData) {
      result = onData.code;
      if (result != null) {
        controller.pauseCamera();

        context.read<AuthenticationCubit>().loginWithQr(result!);
      }
    }, onError: (err) {
      BotToast.showText(text: 'There was an error');
    }, cancelOnError: false, onDone: () {});
  }

  void _onPermissionSet(QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationLoadingState) {
          BotToast.showLoading();
        } else if (state is LoginFailureState) {
          BotToast.closeAllLoading();
          BotToast.showText(text: state.error);
          controller?.resumeCamera();
        } else if (state is LoginSuccessfulState) {
          BotToast.closeAllLoading();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (ctx) => const CustomBottomNavigation(),
              ),
              (route) => false);

          Timer(const Duration(seconds: 3), () {
            BotToast.showText(text: 'Login Successful');
          });
        } else {
          BotToast.closeAllLoading();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: QRView(
                  key: qrKey,
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.red,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                  ),
                  onQRViewCreated: _onQRViewCreated,
                  onPermissionSet: _onPermissionSet,
                )),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.cancel,
                      color: AppColors.primaryRed,
                      size: 70.sm,
                    ))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
