import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../padding/padding.dart';

class ShimmerLoading extends StatelessWidget {
  final int itemCount;
  final double boxHeight;
 const ShimmerLoading({Key? key, required this.boxHeight, required this.itemCount})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.white,
      child: ListView.builder(
      shrinkWrap: true,
        padding: defaultPadding.copyWith(top: 20, bottom: 20),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Card(
            elevation: 1.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: SizedBox(
              height: boxHeight,
            ),
          );
        },
      ),
    );
  }
}
