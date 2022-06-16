import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryScaffold extends StatelessWidget {
  final String? appBartitle;

  final double? height;
  final Widget? body;
  const PrimaryScaffold({
    Key? key,
    this.height,
    this.body,
    this.appBartitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(height.toString());
    final Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: ContainerWidget(
          width: size.width,
          height: height??70.h,
          decoration: const BoxDecoration(
              color: AppColors.primaryRed,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50))),
          child: Padding(
            padding: defaultPadding.copyWith(top: 15.h,),
            child:Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             const Icon(Icons.menu),
              HorizSpace(20.w),
             Text(
               appBartitle ?? 'Home',
               style: theme.textTheme.displaySmall,
             ),
             const Spacer(),
             const Icon(Icons.notifications_active),
             HorizSpace(10.w),
             const Icon(Icons.call),
             HorizSpace(10.w),
             const Icon(Icons.more_vert)
              ],
            )
          ),
        ),
        body: body,
      ),
    );
  }
}

class ContainerWidget extends StatelessWidget with PreferredSizeWidget {
  final Decoration? decoration;
  final Widget child;
  final double height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  ContainerWidget(
      {Key? key,
      required this.child,
      this.decoration,
     required this.height,
      this.width,
      this.margin,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      decoration: decoration,
      child: child,
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, height);
}
