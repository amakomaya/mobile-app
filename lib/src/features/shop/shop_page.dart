import 'package:flutter/material.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Image.asset(
        "assets/images/shop.jpg",
        fit: BoxFit.cover,
      ),
    ));
  }
}
