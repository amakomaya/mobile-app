import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/scaffold/primary_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/audio_container_widget.dart';

class AudioPage extends StatelessWidget {
  const AudioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PrimaryScaffold(
      appBartitle: 'Audio',
      body: SingleChildScrollView(
        padding: defaultPadding.copyWith(bottom: 20.h, top: 20.h),
        primary: true,
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This week Audio',
              style: theme.textTheme.labelMedium,
            ),
            VerticalSpace(20.h),
            AudioContainerWidget(),
            VerticalSpace(20.h),
            Text(
              'Other week Audio',
              style: theme.textTheme.labelMedium,
            ),
            VerticalSpace(20.h),
            ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return AudioContainerWidget();
                }),
                separatorBuilder: (ctx, ind) => VerticalSpace(20.h),
                itemCount: 11),
          ],
        ),
      ),
    );
  }
}
