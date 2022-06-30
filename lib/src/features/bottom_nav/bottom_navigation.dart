import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/features/bottom_nav/popup.dart';
import 'package:aamako_maya/src/features/video/screens/video_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/widgets/drawer/drawer_widget.dart';
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

  // int index = 0;

  ValueNotifier<int> selectedindex = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: SafeArea(
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          extendBody: true,
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          drawer: const DrawerWidget(),
          bottomNavigationBar: BottomAppBar(
            color: AppColors.primaryRed,
            elevation: 0,
            notchMargin: 15,
            shape: const CircularNotchedRectangle(),
            child: SizedBox(
              height: 60.h,
              child: ValueListenableBuilder(
                  valueListenable: selectedindex,
                  builder: (context, s, d) {
                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          iconSize: 30.0,
                          padding: const EdgeInsets.only(left: 28.0),
                          icon: Icon(
                            Icons.home,
                            color: selectedindex.value == 0
                                ? Colors.amber
                                : Colors.white,
                          ),
                          onPressed: () {
                            selectedindex.value = 0;
                          },
                        ),
                        IconButton(
                          iconSize: 30.0,
                          padding: const EdgeInsets.only(right: 28.0),
                          icon: Icon(
                            Icons.music_note,
                            color: selectedindex.value == 1
                                ? Colors.amber
                                : Colors.white,
                          ),
                          onPressed: () {
                            selectedindex.value = 1;
                          },
                        ),
                        IconButton(
                          iconSize: 30.0,
                          padding: const EdgeInsets.only(left: 28.0),
                          icon: Icon(
                            Icons.video_collection,
                            color: selectedindex.value == 2
                                ? Colors.amber
                                : Colors.white,
                          ),
                          onPressed: () {
                            selectedindex.value = 2;
                          },
                        ),
                        IconButton(
                          iconSize: 30.0,
                          padding: const EdgeInsets.only(right: 28.0),
                          icon: Icon(
                            Icons.insert_drive_file,
                            color: selectedindex.value == 3
                                ? Colors.amber
                                : Colors.white,
                          ),
                          onPressed: () {
                            selectedindex.value = 3;
                          },
                        )
                      ],
                    );
                  }),
            ),
          ),
          body: ValueListenableBuilder<int>(
              valueListenable: selectedindex,
              builder: (context, d, f) {
                return IndexedStack(
                  alignment: Alignment.center,
                  index: selectedindex.value,
                  children: const [
                    HomePage(),
                    AudioPage(),
                    VideoPage(),
                    WeeklyTipsPage(),
                    ShopPage(),
                  ],
                );
              }),
          floatingActionButton: ValueListenableBuilder(
            valueListenable: selectedindex,
            builder: (context,v,b) {
              return FloatingActionButton(
                backgroundColor:
                    selectedindex.value == 4? Colors.amber : Colors.white,
                mini: true,
                onPressed: () {
                  selectedindex.value = 4;
                },
                clipBehavior: Clip.none,
                child: Icon(
                  Icons.shopping_cart_sharp,
                  color: Colors.red,
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
