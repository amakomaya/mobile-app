import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/scaffold/primary_appBar.dart';
import 'package:aamako_maya/src/features/ancs/screens/ancs_page.dart';
import 'package:aamako_maya/src/features/baby/screen/babypage.dart';
import 'package:aamako_maya/src/features/bottom_nav/cubit/cubit/navigation_index_cubit.dart';
import 'package:aamako_maya/src/features/bottom_nav/popup.dart';
import 'package:aamako_maya/src/features/video/screens/video_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/widgets/drawer/drawer_widget.dart';
import '../audio/cubit/audio_cubit.dart';
import '../audio/screens/audio_page.dart';
import '../home/screens/homepage.dart';
import '../shop/shop_page.dart';
import '../video/cubit/video_cubit.dart';
import '../weekly_tips/cubit/weekly_tips_cubit.dart';
import '../weekly_tips/weekly_tips_page.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          extendBody: true,
          // extendBodyBehindAppBar: true,
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          drawer: const DrawerWidget(),
          bottomNavigationBar: Builder(builder: (context) {
            return BlocBuilder<NavigationIndexCubit, NavigationIndexState>(
              builder: (context, state) {
                return SizedBox(
                  height: 60.h,
                  child: BottomAppBar(
                      color: Colors.white,
                      elevation: 4,
                      notchMargin: 7,
                      shape: const CircularNotchedRectangle(),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          IconButton(
                            iconSize: 35.sm,
                            padding: const EdgeInsets.only(right: 28.0),
                            icon: ImageIcon(
                              const AssetImage("assets/images/home1.png"),
                              color:
                                  state.index == 0 ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              context
                                  .read<NavigationIndexCubit>()
                                  .changeIndex(index: 0, title: "Home");
                            },
                          ),
                          IconButton(
                            iconSize: 35.sm,
                            padding: const EdgeInsets.only(right: 28.0),
                            icon: ImageIcon(
                              const AssetImage("assets/images/audio.png"),
                              color:
                                  state.index == 1 ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              context
                                  .read<NavigationIndexCubit>()
                                  .changeIndex(index: 1, title: "Audio");

                              context.read<AudioCubit>().getAudio();
                            },
                          ),
                          IconButton(
                            iconSize: 35.sm,
                            padding: const EdgeInsets.only(right: 28.0),
                            icon: ImageIcon(
                              const AssetImage("assets/images/video.png"),
                              color:
                                  state.index == 2 ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              context
                                  .read<NavigationIndexCubit>()
                                  .changeIndex(index: 2, title: "Video");

                              context.read<VideoCubit>().getVideos();
                            },
                          ),
                          IconButton(
                            alignment: Alignment.center,
                            iconSize: 35.sm,
                            padding: const EdgeInsets.only(right: 28.0),
                            icon: ImageIcon(
                              const AssetImage(
                                "assets/images/text.png",
                              ),
                              color:
                                  state.index == 3 ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              context
                                  .read<NavigationIndexCubit>()
                                  .changeIndex(index: 3, title: "Weekly Tips");

                              context.read<WeeklyTipsCubit>().getWeeklyTips();
                            },
                          )
                        ],
                      )),
                );
              },
            );
          }),
          body: BlocBuilder<NavigationIndexCubit, NavigationIndexState>(
            builder: (context, state) {
              return Stack(
                children: [
                  PrimaryAppBar(
                    scaffoldKey: _scaffoldKey,
                    title: state.appbarTitle,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 70.h),
                    child: IndexedStack(
                      alignment: Alignment.center,
                      index: state.index,
                      children: const [
                        HomePage(),
                        AudioPage(),
                        VideoPage(),
                        WeeklyTipsPage(),
                        ShopPage(),
                        AncsPage()
                      ],
                    ),
                  )
                ],
              );
            },
          ),
          floatingActionButton:
              BlocBuilder<NavigationIndexCubit, NavigationIndexState>(
            builder: (context, state) {
              return FloatingActionButton(
                backgroundColor:
                    state.index == 4 ? AppColors.primaryRed : Colors.white,
                isExtended: true,
                onPressed: () {
                  context
                      .read<NavigationIndexCubit>()
                      .changeIndex(index: 4, title: "Shopping");
                },
                clipBehavior: Clip.none,
                child: Icon(
                  Icons.shopping_cart_sharp,
                  size: 30.sm,
                  color: state.index == 4 ? Colors.white : Colors.red,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
