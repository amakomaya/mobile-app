import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryTextField extends StatelessWidget {
  final Decoration? decoration;
  final String? hintText;
    final String? labelText;

  final IconData? suffix;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? boxMargin;
    final EdgeInsetsGeometry? textPadding;

  final EdgeInsetsGeometry? padding;
  const PrimaryTextField(
      {Key? key,
      this.decoration,
      this.height,
      this.width,
      this.padding,
      this.hintText,
      this.suffix, this.labelText, this.boxMargin, this.textPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: textPadding?? const EdgeInsets.symmetric(horizontal: 22),
          child: Text(
          labelText??'',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: 16
            ),
          ),
        ),
        VerticalSpace(5.h),
        Container(
          padding: padding,
          margin: boxMargin?? defaultPadding,
          height: height,
          width: width,
          decoration: decoration ??
              BoxDecoration(
                border: Border.all(color: AppColors.accentGrey, width: 1),
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
          child: TextFormField(
            decoration: InputDecoration(
                suffixIcon:  Icon(suffix),
                hintText: hintText,
                hintStyle: Theme.of(context).textTheme.labelSmall,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(
                    left: 10, right: 10, top: 15, bottom: 15)),
          ),
        ),
      ],
    );
  }
}
