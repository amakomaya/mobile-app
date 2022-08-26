import 'package:aamako_maya/l10n/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../features/authentication/drawer_cubit/drawer_cubit.dart';
import '../../../features/bottom_nav/cubit/cubit/navigation_index_cubit.dart';
import '../../padding/padding.dart';
import '../../theme/app_colors.dart';
import '../buttons/localization_button.dart';
import '../helper_widgets/blank_space.dart';

class PrimaryAppBar extends StatelessWidget {
  final double? height;
  final String? title;
  final bool? isUnauth;
  final Widget? unAuthChild;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const PrimaryAppBar(
      {Key? key,
      this.height,
      this.scaffoldKey,
      this.unAuthChild,
      this.isUnauth,
      this.title})
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
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        child: Padding(
          padding: defaultPadding.copyWith(
            top: 15.h,
          ),
          child: isUnauth == false || isUnauth == null
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Builder(builder: (context) {
                      return InkWell(
                        onTap: () {
                          // scaffoldKey?.currentState?.openDrawer();
                          Scaffold.of(context).openDrawer();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          color: Colors.transparent,
                          child: const Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }),
                    HorizSpace(20.w),
                    Text(
                     title??'',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const Spacer(),
                    // ImageIcon(
                    //   const AssetImage("assets/images/notification.png"),
                    //   size: 22.sm,
                    // ),
                    // HorizSpace(20.w),
                    GestureDetector(
                      onTap: (){
                         context.read<NavigationIndexCubit>().changeIndex(
                                  titleNp: 'Siren',
                                  index: 14,
                                  titleEn: 'Emergency Siren');
                              context
                                  .read<DrawerCubit>()
                                  .checkDrawerSelection(-1);
                      },
                      child: ImageIcon(
                        const AssetImage("assets/images/siren.png"),
                        size: 22.sm,
                        
                      ),
                    ),
                    HorizSpace(20.w),
                   const LocalizationButton(
                    color: AppColors.white,
                   ),
                  ],
                )
              : unAuthChild,
        ));
  }
}
