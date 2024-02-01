import 'dart:convert';
import 'package:Amakomaya/src/features/appointment_booking/fonepay_payment/payment_confirmation_page.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../l10n/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../authentication/drawer_cubit/drawer_cubit.dart';
import '../../bottom_nav/bottom_navigation.dart';
import '../../bottom_nav/cubit/cubit/navigation_index_cubit.dart';
import 'fonepay_payment_cubit.dart';

class FonePayWebViewPage extends StatefulWidget {
  final String responseBody;

  const FonePayWebViewPage(this.responseBody, {Key? key}) : super(key: key);

  @override
  State<FonePayWebViewPage> createState() => _FonePayWebViewPageState();
}

class _FonePayWebViewPageState extends State<FonePayWebViewPage> {
  late final WebViewController controller;
  var loadingPercentage = 0;

  //
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(Uri.dataFromString(widget.responseBody,
          mimeType: 'text/html', encoding: Encoding.getByName("UTF-8")));
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
          context.read<FonePayPaymentCubit>().verifyThePayment();
          // Future.delayed(const Duration(seconds: 10), () {
          //   context.read<FonePayPaymentCubit>().verifyThePayment();
          // });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
            // appBar: AppBar(
            //   backgroundColor: AppColors.primaryRed,
            //   leading: IconButton(
            //       icon: Icon(
            //         Icons.arrow_back_ios,
            //         color: Colors.white,
            //         size: 20.r,
            //       ),
            //       onPressed: () {
            //         Navigator.pushAndRemoveUntil(
            //           context,
            //           MaterialPageRoute(builder: (ctx) => const CustomBottomNavigation()),
            //               (route) => false,
            //         );
            //       }),
            //   title: Text(
            //     "FonePay Payment",
            //     style: TextStyle(fontSize: 16.sm, fontFamily: 'lato'),
            //   ),
            // ),
            body: BlocConsumer<FonePayPaymentCubit, FonePayPaymentState>(
              listener: (context, state) {
                if (state is VerifyPaymentSuccess) {
                  print("sytatusss ${state.verifyResponse.status}");
                  if(state.verifyResponse.status== "success"){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>
                            PaymentConfirmationPage(state.verifyResponse.status)));
                  }else{
                  }
                }
                if (state is VerifyPaymentFailure) {
                }
              },
              builder: (context, state) {
                return Stack(
                  children: [
                    WebViewWidget(controller: controller),
                    if (loadingPercentage < 100)
                      LinearProgressIndicator(
                        value: loadingPercentage / 100.0,
                      ),
                  ],
                );


              },
            )),
      ),
    );
  }
}
