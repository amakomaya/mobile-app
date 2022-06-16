import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/scaffold/primary_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';

class WeeklyTipsPage extends StatelessWidget {
  const WeeklyTipsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PrimaryScaffold(
      appBartitle: 'Weekly Tips',
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: defaultPadding.copyWith(top: 20.h, bottom: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('This Week Information',
                  style: theme.textTheme.headlineMedium),
              VerticalSpace(20.h),
              ShadowContainer(
                radius: 30,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Special consideration:',
                        style: theme.textTheme.labelMedium),
                    Divider(
                      height: 15.w,
                      color: AppColors.accentGrey,
                    ),
                    Text(
                      "It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.",
                      style: theme.textTheme.labelSmall,
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              ),
              VerticalSpace(20.h),
              Text(
                'Other Week Information',
                style: theme.textTheme.headlineMedium,
              ),
              VerticalSpace(20.h),
              ShadowContainer(
                radius: 30,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Special consideration:',
                        style: theme.textTheme.labelMedium),
                    Divider(
                      height: 15.w,
                      color: AppColors.accentGrey,
                    ),
                    Text(
                      "It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.",
                     
                        style: theme.textTheme.labelSmall,
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              ),
              VerticalSpace(30.h),
              ShadowContainer(
                radius: 30,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Special consideration:',style: theme.textTheme.labelMedium),
                    Divider(
                      height: 15.w,
                      color: AppColors.accentGrey,
                    ),
                    Text(
                      "It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.It's never too early to start healthy habts. Try eating whole fod;avoid smoking.",
                     
                        style: theme.textTheme.labelSmall,
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
