import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BorderContainer extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? height;
  final Color? color;
  final double? width;
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  const BorderContainer({
    Key? key,
    this.child,
    this.borderRadius,
    this.padding,
    this.color,
    this.margin,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: InkWell(
        child: Container(
          margin: margin ?? defaultPadding,
        padding: padding ??
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              width: width ?? 185.w,
              height: height,
          decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: borderRadius ?? BorderRadius.circular(22),
            border: Border.all(color: AppColors.primaryRed,),
          ),
          child: child,
        ),
      ),
    );
  }
}
