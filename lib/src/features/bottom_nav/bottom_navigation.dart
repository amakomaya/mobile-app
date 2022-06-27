import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/features/bottom_nav/popup.dart';
import 'package:aamako_maya/src/features/video/screens/video_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../audio/screens/audio_page.dart';
import '../home/homepage.dart';
import '../shop/shop_page.dart';
import '../weekly_tips/weekly_tips_page.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  final PageController _myPage = PageController(initialPage: 0);

 
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:()=> showExitPopup(context),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: AppColors.primaryRed,
          notchMargin: 15,
          shape: const CircularNotchedRectangle(),
          child: SizedBox(
            height: 60.h,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  iconSize: 30.0,
                  padding: EdgeInsets.only(left: 28.0),
                  icon: Icon(Icons.home),
                  onPressed: () {
                    _myPage.jumpToPage(0);
                  },
                ),
                IconButton(
                  iconSize: 30.0,
                  padding: EdgeInsets.only(right: 28.0),
                  icon: Icon(Icons.music_note),
                  onPressed: () {
                    _myPage.jumpToPage(1);
                  },
                ),
                IconButton(
                  iconSize: 30.0,
                  padding: EdgeInsets.only(left: 28.0),
                  icon: Icon(Icons.video_collection),
                  onPressed: () {
                    _myPage.jumpToPage(2);
                  },
                ),
                IconButton(
                  iconSize: 30.0,
                  padding: EdgeInsets.only(right: 28.0),
                  icon: Icon(Icons.insert_drive_file),
                  onPressed: () {
                    _myPage.jumpToPage(3);
                  },
                )
              ],
            ),
          ),
        ),
        body: PageView(
          controller: _myPage,
          onPageChanged: (int) {
            print('Page Changes to index $int');
          },
          children: <Widget>[
            HomePage(),
            AudioPage(),
            VideoPage(),
            WeeklyTipsPage(),
            ShopPage(),
          ],
          physics:
              NeverScrollableScrollPhysics(), // Comment this if you need to use Swipe.
        ),
        floatingActionButton: SizedBox(
          height: 50.h,
          width: 50.h,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                _myPage.jumpToPage(4);
              },
              child: Icon(
                Icons.shopping_cart_sharp,
                color: Colors.red,
              ),
              // elevation: 5.0,
            ),
          ),
        ),
      ),
    );
  }
}
