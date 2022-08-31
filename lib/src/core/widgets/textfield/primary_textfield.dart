import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef ValidatorFunc = String? Function(String?);

class PrimaryTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? obscureText;
  final VoidCallback? sufixTap;
  final VoidCallback? onTap;
  final Decoration? decoration;
  final String? hintText;
  final String? labelText;
  final FocusNode? focus;
  final FocusNode? nextFocus;
  final IconData? suffix;
  final double? height;
  final double? width;
  final bool? isPhone;
  final bool? readOnly;
  final EdgeInsetsGeometry? boxMargin;
  final EdgeInsetsGeometry? textPadding;
  final ValidatorFunc? validator;
  final EdgeInsetsGeometry? padding;
  const PrimaryTextField({
    Key? key,
    this.decoration,
    this.onTap,
    this.readOnly,
    this.height,
    this.width,
    this.isPhone,
    this.padding,
    this.hintText,
    this.suffix,
    this.labelText,
    this.boxMargin,
    this.textPadding,
    this.validator,
    this.focus,
    this.nextFocus,
    this.controller,
    this.sufixTap,
    this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: textPadding ?? const EdgeInsets.symmetric(horizontal: 22),
          child: Text(
            labelText ?? '',
            style:
                Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 16),
          ),
        ),
        VerticalSpace(5.h),
        Padding(
          padding: defaultPadding,
          child: TextFormField(
            
            onTap: onTap,
            readOnly: readOnly??false,
            keyboardType:
                isPhone != null && isPhone == true ? TextInputType.phone : null,
            obscureText: obscureText ?? false,
            controller: controller,
            cursorColor: AppColors.primaryRed,
            focusNode: focus,
            onFieldSubmitted: (value) => nextFocus != null
                ? FocusScope.of(context).requestFocus(nextFocus)
                : FocusScope.of(context).unfocus(),
            validator: validator,
            decoration: InputDecoration(
              
                suffixIcon: GestureDetector(
                  onTap: sufixTap,
                  child: Icon(
                    suffix,
                    color: Colors.grey,
                  ),
                ),
                hintText: hintText,
                hintStyle: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: Colors.grey),
                  
                    enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                        color: AppColors.accentGrey, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                        color: AppColors.accentGrey, width: 1)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                        color: AppColors.accentGrey, width: 1)),
                contentPadding: const EdgeInsets.only(
                    left: 15, right: 10, top: 15, bottom: 15)),
          ),
        ),
      ],
    );
  }
}
