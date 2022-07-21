import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/drawer/drawer_widget.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryScaffold extends StatelessWidget {
  final String? appBartitle;
  final VoidCallback? onMenuPressed;
  final double? height;
  final Widget? body;
  const PrimaryScaffold({
    Key? key,
    this.height,
    this.body,
    this.appBartitle,
    this.onMenuPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Column(children: [
      ContainerWidget(
        width: size.width,
        height: height ?? 70.h,
        decoration: const BoxDecoration(
            color: AppColors.primaryRed,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50))),
        child: Padding(
            padding: defaultPadding.copyWith(
              top: 15.h,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  // splashColor: Colors.white.withOpacity(0.5),
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.transparent,
                    child: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                  ),
                ),
                HorizSpace(20.w),
                Text(
                  appBartitle ?? 'Home',
                  style: theme.textTheme.displaySmall,
                ),
                const Spacer(),
                ImageIcon(
                  AssetImage("assets/images/notification.png"),
                  size: 20.sm,
                ),
                HorizSpace(10.w),
                ImageIcon(
                  AssetImage("assets/images/siren.png"),
                  size: 20.sm,
                ),
                HorizSpace(10.w),
                ImageIcon(
                  AssetImage("assets/images/language.png"),
                  size: 20.sm,
                ),
              ],
            )),
      ),
      Expanded(child: body ?? Container()),
    ]);
  }
}

class ContainerWidget extends StatelessWidget {
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
