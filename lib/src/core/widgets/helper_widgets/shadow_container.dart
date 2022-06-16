import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class ShadowContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final Color? color;
  final double? radius;
  final Decoration? decoration;
  const ShadowContainer(
      {Key? key,
      this.height,
      this.width,
      this.padding,
      this.margin,
      this.child,
      this.color,
      this.radius,
      this.decoration})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: child,
      margin: margin,
      padding: padding,
      decoration: decoration ??
          BoxDecoration(
              color: color?? AppColors.white,
              borderRadius: BorderRadius.circular(radius??10),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 1,
                  offset: const Offset(1, 1),
                  color: AppColors.accentGrey.withOpacity(0.3),
                )
              ]),
    );
  }
}
