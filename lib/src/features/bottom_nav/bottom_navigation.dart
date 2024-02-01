import 'package:Amakomaya/src/core/app_assets/app_assets.dart';
import 'package:Amakomaya/src/core/theme/app_colors.dart';
import 'package:Amakomaya/src/core/widgets/scaffold/primary_appBar.dart';
import 'package:Amakomaya/src/features/ancs/screens/ancs_page.dart';
import 'package:Amakomaya/src/features/appointment_booking/screens/appointment_booking_history_page.dart';
import 'package:Amakomaya/src/features/appointment_booking/screens/booking_checkout_page.dart';
import 'package:Amakomaya/src/features/appointment_booking/screens/booking_page.dart';
import 'package:Amakomaya/src/features/authentication/widgets/complete_profile_section.dart';
import 'package:Amakomaya/src/features/bottom_nav/cubit/cubit/navigation_index_cubit.dart';
import 'package:Amakomaya/src/features/bottom_nav/popup.dart';
import 'package:Amakomaya/src/features/delivery/screen/delivery_page.dart';
import 'package:Amakomaya/src/features/faqs/screen/faqs_page.dart';
import 'package:Amakomaya/src/features/labtest/screen/labtestpage.dart';
import 'package:Amakomaya/src/features/medication/screen/medicationpage.dart';
import 'package:Amakomaya/src/features/pnc/screens/pnc_page.dart';
import 'package:Amakomaya/src/features/qrcode/qr.dart';
import 'package:Amakomaya/src/features/video/screens/video_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/widgets/drawer/drawer_widget.dart';
import '../appointment_booking/model/booking_model.dart';
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

class _CustomBottomNavigationState extends State<CustomBottomNavigation>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var currentIndex = -1;

  @override
  void initState() {
    super.initState();
    context.read<GetUserCubit>().getUserData();
    Future.delayed(const Duration(seconds: 3), () {
      try {
        var controller = DefaultTabController.of(context)!;
        controller.addListener(() async {
          setState(() {
            currentIndex = controller.index;
          });
        });
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        await showExitPopup(context);
        return false;
      },
      child: SafeArea(
        child: DefaultTabController(
          initialIndex: 0,
          length: 16,
          child: Scaffold(
            key: _scaffoldKey,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            extendBody: false,
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: true,
            drawer: DrawerWidget(currentIndex: currentIndex),
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
                                  color: state.index == 0
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    currentIndex = 0;
                                  });
                                  DefaultTabController.of(context).animateTo(0);
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
                                  setState(() {
                                    currentIndex = 1;
                                  });
                                  DefaultTabController.of(context).animateTo(1);
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
                                  color: state.index == 1
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),
                              label: ''),
                          BottomNavigationBarItem(
                              icon: IconButton(
                                iconSize: 35.sm,
                                onPressed: () {
                                  setState(() {
                                    currentIndex = 2;
                                  });
                                  DefaultTabController.of(context).animateTo(2);
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
                                  color: state.index == 2
                                      ? Colors.red
                                      : Colors.grey,
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
                                    setState(() {
                                      currentIndex = 3;
                                    });
                                    DefaultTabController.of(context)
                                        .animateTo(3);
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
                  final bool isEnglish = EasyLocalization.of(context)
                          ?.currentLocale
                          ?.languageCode ==
                      'en';
                  return Stack(
                    fit: StackFit.loose,
                    clipBehavior: Clip.hardEdge,
                    children: [
                      PrimaryAppBar(
                        currentIndex: currentIndex,
                        scaffoldKey: _scaffoldKey,
                        title: isEnglish
                            ? navState.appbarTitleEn
                            : navState.appbarTitleNp,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 70.h),
                        child: TabBarView(
                          clipBehavior: Clip.none,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            HomePage(
                              currentIndex: currentIndex,
                            ),
                            AudioPage(),
                            VideoPage(),
                            WeeklyTipsPage(),
                            BookingPage( currentIndex: currentIndex),
                            CompleteProfileSection(),
                            SymptomsPAge(),
                            QrCode(),
                            AncsPage(),
                            DeliveryPage(),
                            MedicationPage(),
                            PncsPage(),
                            Labtestpage(),
                            AppointmentBookingHistoryPage(),
                            FaqsPage(),
                            SirenPage(),
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
                      setState(() {
                        currentIndex = 4;
                      });
                      context
                          .read<DrawerCubit>()
                          .checkDrawerSelection(9);
                      DefaultTabController.of(context).animateTo(4);
                      context.read<NavigationIndexCubit>().changeIndex(
                          index: 4, titleEn: "Appointment Booking", titleNp: "अपोइन्टमेन्ट बुकिङ");
                    },
                    clipBehavior: Clip.none,
                    child:
                    ImageIcon(
                       AssetImage(
                         state.index == 4 ? AppAssets.appoitnmentWhiteIcon:AppAssets.appoitnmentIcon,
                      ),
                      size: 30.sm,
                      color: state.index == 4
                          ? Colors.white
                          : Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
