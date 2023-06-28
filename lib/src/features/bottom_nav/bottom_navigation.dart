import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/scaffold/primary_appBar.dart';
import 'package:aamako_maya/src/features/ancs/screens/ancs_page.dart';
import 'package:aamako_maya/src/features/authentication/widgets/complete_profile_section.dart';
import 'package:aamako_maya/src/features/bottom_nav/cubit/cubit/navigation_index_cubit.dart';
import 'package:aamako_maya/src/features/bottom_nav/popup.dart';
import 'package:aamako_maya/src/features/delivery/screen/delivery_page.dart';
import 'package:aamako_maya/src/features/doctor/apointment.dart';
import 'package:aamako_maya/src/features/faqs/screen/faqs_page.dart';
import 'package:aamako_maya/src/features/labtest/screen/labtestpage.dart';
import 'package:aamako_maya/src/features/medication/screen/medicationpage.dart';
import 'package:aamako_maya/src/features/pnc/screens/pnc_page.dart';
import 'package:aamako_maya/src/features/qrcode/qr.dart';
import 'package:aamako_maya/src/features/video/screens/video_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/widgets/drawer/drawer_widget.dart';
import '../audio/screens/audio_page.dart';
import '../authentication/drawer_cubit/drawer_cubit.dart';
import '../card/card_page.dart';
import '../fetch user data/cubit/get_user_cubit.dart';
import '../home/screens/homepage.dart';
import '../shop/shop_page.dart';
import '../siren/siren_page.dart';
import '../symptoms/screen/symptomspage.dart';
import '../weekly_tips/weekly_tips_page.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


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
          key: _scaffoldKey,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          extendBody: false,
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          drawer: const DrawerWidget(),
          bottomNavigationBar: Builder(builder: (context) {
            return BlocBuilder<NavigationIndexCubit, NavigationIndexState>(
              builder: (context, state) {
                return BottomAppBar(
                    clipBehavior: Clip.antiAlias,
                    color: Colors.white,
                    elevation: 4,
                    notchMargin: 7,
                    shape: const CircularNotchedRectangle(),
                    child: BottomNavigationBar(
                      selectedLabelStyle: TextStyle(fontSize: 0),
                      unselectedLabelStyle: TextStyle(fontSize: 0),
                      type: BottomNavigationBarType.fixed,
                      items: [
                        BottomNavigationBarItem(
                            icon: IconButton(
                              iconSize: 35.sm,
                              icon: ImageIcon(
                                const AssetImage("assets/images/home1.png"),
                                color:
                                    state.index == 0 ? Colors.red : Colors.grey,
                              ),
                              onPressed: () {
                                context
                                    .read<NavigationIndexCubit>()
                                    .changeIndex(
                                        index: 0,
                                        titleEn: "Home",
                                        titleNp: "होम");
                                context
                                    .read<DrawerCubit>()
                                    .checkDrawerSelection(0);
                              },
                            ),
                            label: ''),
                        BottomNavigationBarItem(
                            icon: IconButton(
                              iconSize: 35.sm,
                              onPressed: () {
                                context
                                    .read<NavigationIndexCubit>()
                                    .changeIndex(
                                        index: 1,
                                        titleNp: "अडियो",
                                        titleEn: "Audio");

                                context
                                    .read<DrawerCubit>()
                                    .checkDrawerSelection(-1);
                              },
                              icon: ImageIcon(
                                const AssetImage(
                                  "assets/images/audio.png",
                                ),
                                color:
                                    state.index == 1 ? Colors.red : Colors.grey,
                              ),
                            ),
                            label: ''),
                        BottomNavigationBarItem(
                            icon: IconButton(
                              iconSize: 35.sm,
                              onPressed: () {
                                context
                                    .read<NavigationIndexCubit>()
                                    .changeIndex(
                                        titleNp: "भिडियो",
                                        index: 2,
                                        titleEn: 'Video');
                                context
                                    .read<DrawerCubit>()
                                    .checkDrawerSelection(-1);

                              },
                              icon: ImageIcon(
                                const AssetImage("assets/images/video.png"),
                                color:
                                    state.index == 2 ? Colors.red : Colors.grey,
                              ),
                            ),
                            label: ''),
                        BottomNavigationBarItem(
                            icon: IconButton(
                                iconSize: 35.sm,
                                icon: ImageIcon(
                                  const AssetImage(
                                    "assets/images/text.png",
                                  ),
                                  color: state.index == 3
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  context
                                      .read<NavigationIndexCubit>()
                                      .changeIndex(
                                          titleNp: "साप्ताहिक सुझावहरू",
                                          index: 3,
                                          titleEn: 'Weekly Tips');
                                  context
                                      .read<DrawerCubit>()
                                      .checkDrawerSelection(-1);
                                }),
                            label: ''),
                      ],
                    ));
              },
            );
          }),
          body: Builder(builder: (context) {
            return BlocBuilder<NavigationIndexCubit, NavigationIndexState>(
              builder: (navCont, navState) {
                final bool isEnglish =
                    EasyLocalization.of(context)?.currentLocale?.languageCode ==
                        'en';
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    PrimaryAppBar(
                          scaffoldKey: _scaffoldKey,
                          title: isEnglish
                              ? navState.appbarTitleEn
                              : navState.appbarTitleNp,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 70.h),
                      child: IndexedStack(
                        alignment: Alignment.center,
                        index: navState.index,
                        children: const [
                          HomePage(),
                          AudioPage(),
                          VideoPage(),
                          WeeklyTipsPage(),
                          ShopPage(),
                          //index =5

                          AncsPage(),
                          DeliveryPage(),
                          MedicationPage(),
                          PncsPage(),

                          ///index 9
                          Labtestpage(),
                          //profile index=10
                          CompleteProfileSection(),
                          //card index =11
                          CardPage(),
                          //faq=12
                          FaqsPage(),
                          //syztemassetment index=13
                          SymptomsPAge(),
                          //14
                          SirenPage(),

                          //15
                          QrCode(),

                          //16
                          // Apointment()
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          }),
          floatingActionButton: Visibility(
            visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
            child: BlocBuilder<NavigationIndexCubit, NavigationIndexState>(
              builder: (context, state) {
                return FloatingActionButton(
                  backgroundColor:
                      state.index == 4 ? AppColors.primaryRed : Colors.white,
                  isExtended: true,
                  onPressed: () {
                    context
                        .read<NavigationIndexCubit>()
                        .changeIndex(index: 4, titleEn: "Shopping", titleNp: "किनमेल");
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
      ),
    );
  }
}
