import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/scaffold/primary_appBar.dart';
import 'package:aamako_maya/src/features/ancs/screens/ancs_page.dart';
import 'package:aamako_maya/src/features/baby/screen/babypage.dart';
import 'package:aamako_maya/src/features/bottom_nav/popup.dart';
import 'package:aamako_maya/src/features/video/screens/video_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/widgets/drawer/drawer_widget.dart';
import '../audio/screens/audio_page.dart';
import '../home/screens/homepage.dart';
import '../shop/shop_page.dart';
import '../weekly_tips/cubit/weekly_tips_cubit.dart';
import '../weekly_tips/weekly_tips_page.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  ValueNotifier<int> selectedindex = ValueNotifier(0);
  ValueNotifier<String> selectedAppBar = ValueNotifier('Home');
  @override
  void initState() {
    super.initState();
  }

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
          bottomNavigationBar: SizedBox(
            height: 60.h,
            child: BottomAppBar(
              color: Colors.white,
              elevation: 4,
              notchMargin: 7,
              shape: const CircularNotchedRectangle(),
              child: ValueListenableBuilder(
                  valueListenable: selectedindex,
                  builder: (context, s, d) {
                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                          iconSize: 30.0,
                          padding: const EdgeInsets.only(right: 28.0),
                          icon: ImageIcon(
                            const AssetImage("assets/images/home1.png"),
                            color: selectedindex.value == 0
                                ? Colors.red
                                : Colors.grey,
                          ),
                          onPressed: () {
                            selectedindex.value = 0;
                            selectedAppBar.value = 'Home';
                          },
                        ),
                        IconButton(
                          iconSize: 30.0,
                          padding: const EdgeInsets.only(right: 28.0),
                          icon: ImageIcon(
                            const AssetImage("assets/images/audio.png"),
                            color: selectedindex.value == 1
                                ? Colors.red
                                : Colors.grey,
                          ),
                          onPressed: () {
                            selectedindex.value = 1;
                            selectedAppBar.value = ' Audio';
                          },
                        ),
                        IconButton(
                          iconSize: 30.0,
                          padding: const EdgeInsets.only(right: 28.0),
                          icon: ImageIcon(
                            const AssetImage("assets/images/video.png"),
                            color: selectedindex.value == 2
                                ? Colors.red
                                : Colors.grey,
                          ),
                          onPressed: () {
                            selectedindex.value = 2;
                            selectedAppBar.value = ' Video';
                          },
                        ),
                        IconButton(
                          iconSize: 30.0,
                          padding: const EdgeInsets.only(right: 28.0),
                          icon: ImageIcon(
                            const AssetImage("assets/images/text.png"),
                            color: selectedindex.value == 3
                                ? Colors.red
                                : Colors.grey,
                          ),
                          onPressed: () {
                            selectedindex.value = 3;
                            selectedAppBar.value = 'Weekly Tips';
                          },
                        )
                      ],
                    );
                  }),
            ),
          ),
          body: ValueListenableBuilder(
              valueListenable: selectedAppBar,
              builder: (context, f, h) {
                return ValueListenableBuilder<int>(
                    valueListenable: selectedindex,
                    builder: (context, d, f) {
                      return Column(
                        children: [
                          PrimaryAppBar(
                            title: selectedAppBar.value,
                            height: selectedindex.value == 0 ? 100.h : null,
                          ),
                          Expanded(
                            child: IndexedStack(
                              alignment: Alignment.center,
                              index: selectedindex.value,
                              children: const [
                                HomePage(),
                                AudioPage(),
                                VideoPage(),
                                WeeklyTipsPage(),
                              ],
                            ),
                          )
                        ],
                      );
                    });
              }),
          floatingActionButton: ValueListenableBuilder(
              valueListenable: selectedindex,
              builder: (context, v, b) {
                return FloatingActionButton(
                  backgroundColor: selectedindex.value == 4
                      ? AppColors.primaryRed
                      : Colors.white,
                  isExtended: true,
                  onPressed: () {
                    selectedindex.value = 4;
                    selectedAppBar.value = 'Shopping';
                  },
                  clipBehavior: Clip.none,
                  child: Icon(
                    Icons.shopping_cart_sharp,
                    size: 30.sm,
                    color: selectedindex.value == 4 ? Colors.white : Colors.red,
                  ),
                );
              }),
        ),
      ),
    );
  }
}
