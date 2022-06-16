import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryActionButton extends StatelessWidget {
  final VoidCallback onpress;
  final String title;
  final double? width;
  final double? height;
  final double? radius;
  final Color? color;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  const PrimaryActionButton(
      {Key? key,
      required this.onpress,
      required this.title,
      this.width,
      this.height,
      this.color,
      this.radius,
      this.padding,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 22),
        child: Material(
          color: color ?? AppColors.primaryRed,
          child: InkWell(
            onTap: onpress,
            splashColor: Colors.white.withOpacity(0.5),
            child: Container(
              padding: padding ??
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              width: width ?? 185.w,
              height: height,
              decoration: BoxDecoration(color: Colors.transparent),
              child: child ??
                  Center(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontSize: 18,
                          color: AppColors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
