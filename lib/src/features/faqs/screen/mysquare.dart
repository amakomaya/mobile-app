import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySquare extends StatefulWidget {
  const MySquare({Key? key}) : super(key: key);

  @override
  State<MySquare> createState() => _MySquareState();
}

class _MySquareState extends State<MySquare> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: REdgeInsets.only(left: 18, right: 18),
          child: Container(
            height: 200.h,
            color: Colors.purpleAccent,
          ),
        ),
      ],
    );
  }
}
