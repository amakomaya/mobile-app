import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/helper_widgets/blank_space.dart';
import '../../audio/screens/audio_player_section.dart';

class HomeAudioPlayerPage extends StatelessWidget {
  const HomeAudioPlayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // appBar: AppBar(automaticallyImplyLeading: true,),
      body: Column(
        children: [
          SizedBox(
            height: 60.h,
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.accentGrey,
                ),
              ),
            ),
          ),
          Container(
            width: 360.w,
            height: 360.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(33),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://img.freepik.com/free-psd/cover-compact-disc-mockup_7838-394.jpg?w=2000"))),
          ),
          Padding(
            padding: defaultPadding,
            child: Text('Title'),
          ),
          VerticalSpace(10.h),
          Padding(
            padding: defaultPadding,
            child: Text('Author'),
          ),
          Slider(
            thumbColor: Colors.white,
            activeColor: AppColors.primaryRed,
            inactiveColor: AppColors.primaryRed.withOpacity(0.2),
            max: 100,
            min: 0,
            value: 90,
            onChanged: (double value) async {
              final position = Duration(seconds: value.toInt());
              // await _controller.seekTo(position);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text('0:22'),
                Spacer(),
                Text('3:33'
                    // formatTime(
                    //   duration.value,

                    )
              ],
            ),
          ),
          VerticalSpace(20.h),


          Container(
            color: Colors.red,
            child: Row(
              children: [
               Icon(
                      Icons.skip_previous_rounded,
                      color: AppColors.accentGrey,
                      size: 66.sm,
                    ),
                Icon(
                      Icons.play_arrow_rounded,
                      color: AppColors.accentGrey,
                      size: 66.sm,
                    ),
                 Icon(
                      Icons.skip_next_rounded,
                      color: AppColors.accentGrey,
                      size: 66.sm,
                    )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
