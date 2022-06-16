import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/scaffold/primary_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PrimaryScaffold(
      appBartitle: 'Video',
      body: SingleChildScrollView(
          padding: defaultPadding.copyWith(top: 20.h, bottom: 20.h),
          child: Column(
            children: [
              ShadowContainer(
                radius: 25,
                width: 383.w,
                height: 171.h,
                color: Colors.black,
                child: Center(
                    child: Icon(
                  Icons.play_circle_fill_rounded,
                  size: 40,
                )),
              ),
              VerticalSpace(30.h),
              ListView.separated(
                itemBuilder: (ctx, ind) => ShadowContainer(
                    radius: 25,
                    width: 383.w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Container(
                          height: 113.h,
                          width: 121.w,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(25)),
                          child: const Center(
                              child: Icon(
                            Icons.play_circle_fill_rounded,
                            size: 40,
                          )),
                        ),
                        HorizSpace(12.w),
                        Flexible(
                          child: Column(
                            children: [
                              Text(
                                'Things that are to be taken into consideration:',
                                style: theme.textTheme.titleSmall,
                              ),
                              Divider(
                                endIndent: 5,
                                indent: 5,
                                height: 15.w,
                                color: AppColors.accentGrey,
                              ),
                              Text(
                                "It's never too early to start healthy habts. Try eating whole fod;avoid smoking.",
                                style: theme.textTheme.labelSmall,
                              )
                            ],
                          ),
                        )
                      ],
                    )),
                separatorBuilder: (ctx, ind) => VerticalSpace(20.h),
                itemCount: 8,
                shrinkWrap: true,
                primary: false,
              )
            ],
          )),
    );
  }
}
