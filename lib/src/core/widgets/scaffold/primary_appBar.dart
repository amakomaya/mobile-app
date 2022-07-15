import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../padding/padding.dart';
import '../../theme/app_colors.dart';
import '../helper_widgets/blank_space.dart';

class PrimaryAppBar extends StatelessWidget {
  final double? height;
  final String? title;
  final bool? isUnauth;
  final Widget? unAuthChild;
  const PrimaryAppBar(
      {Key? key, this.height, this.unAuthChild, this.isUnauth, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
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
          child: isUnauth == false || isUnauth == null
              ? Row(
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
                      title ?? '',
                      style: Theme.of(context).textTheme.displaySmall,
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
                )
              : unAuthChild,
        ));
  }
}
