import 'package:aamako_maya/src/features/bottom_nav/bottom_navigation.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../core/theme/app_colors.dart';
import '../../qr_code_cubit/qr_code_cubit.dart';

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

    controller.scannedDataStream.listen(
      (onData) {
        result = onData.code;
        if (result != null) {
          controller.pauseCamera();
          BotToast.showLoading();
          context.read<QrCodeCubit>().loginWithQr(result!);
        }
      },
      onError: (err) {},
      cancelOnError: false,
      onDone: () {},
    );
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
    return BlocListener<QrCodeCubit, LoggedInState>(
      listener: (context, state) {
        if (state.error != null) {
          BotToast.closeAllLoading();

          BotToast.showText(text: 'Error Logging In');
        }
        if (state.error == null && state.user != null) {
          BotToast.closeAllLoading();
          Navigator.push(context,
              MaterialPageRoute(builder: (ctx) => CustomBottomNavigation()));
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
