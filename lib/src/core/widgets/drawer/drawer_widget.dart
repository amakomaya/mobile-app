import 'dart:ui';

import 'package:aamako_maya/src/core/app_assets/app_assets.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/features/ancs/cubit/ancs_cubit.dart';

import 'package:aamako_maya/src/features/ancs/screens/ancs_page.dart';
import 'package:aamako_maya/src/features/authentication/screens/login/login_page.dart';
import 'package:aamako_maya/src/features/baby/screen/babypage.dart';
import 'package:aamako_maya/src/features/bottom_nav/cubit/cubit/navigation_index_cubit.dart';

import 'package:aamako_maya/src/features/delivery/screen/delivery_page.dart';
import 'package:aamako_maya/src/features/faqs/model/faqs_model.dart';
import 'package:aamako_maya/src/features/faqs/screen/faqs_page.dart';
import 'package:aamako_maya/src/features/labtest/screen/labtestpage.dart';
import 'package:aamako_maya/src/features/medication/screen/medicationpage.dart';
import 'package:aamako_maya/src/features/pnc/screens/pnc_page.dart';
import 'package:aamako_maya/src/features/symptoms/screen/symptomspage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../features/authentication/local_storage/authentication_local_storage.dart';
import '../../../features/bottom_nav/bottom_navigation.dart';
import '../../theme/app_colors.dart';
import '../helper_widgets/blank_space.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Container(
        color: Colors.white,
        width: size.width * 0.8,
        height: size.height,
        child: Stack(
          children: [
            Container(
              height: 225.h,
              decoration: const BoxDecoration(
                  color: AppColors.primaryRed,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  )),
            ),
            Padding(
                padding: EdgeInsets.only(
                  top: 30.h,
                  left: 10,
                  right: 10,
                  bottom: 39.h,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(AppAssets.girl),
                        radius: 30.w,
                      ),
                    ),
                    VerticalSpace(5.h),
                    Align(
                        alignment: Alignment.topCenter,
                        child: Text('Rita Lama',
                            style: theme.textTheme.titleSmall?.copyWith(
                                fontSize: 34, color: AppColors.white))),
                    VerticalSpace(5.h),
                    Align(
                        alignment: Alignment.topCenter,
                        child: Text('40 weeks 5 days',
                            style: theme.textTheme.titleSmall?.copyWith(
                                fontSize: 12, color: AppColors.white))),
                    VerticalSpace(15.h),
                    Expanded(
                      child: ShadowContainer(
                        color: Colors.white,
                        child: ListView(
                          children: [
                            ListTile(
                              onTap: () {
                                // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>CustomBottomNavigation()), (route) => false)
;                              },
                              leading: Image.asset(
                                AppAssets.homeIcon,
                                height: 30.sm,
                              ),
                              title: Text(
                                'Home',
                                style: theme.textTheme.titleSmall,
                              ),
                            ),
                            //profile
                            ListTile(
                              leading: Image.asset(
                                AppAssets.profileIcon,
                                height: 30.sm,
                              ),
                              title: Text('Profile',
                                  style: theme.textTheme.titleSmall),
                            ),

                            //card
                            ListTile(
                              leading: Image.asset(
                                AppAssets.cardIcon,
                                height: 30.sm,
                              ),
                              title: Text('Card',
                                  style: theme.textTheme.titleSmall),
                            ),
                            //
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SymptomsPAge()));
                              },
                              leading: Image.asset(
                                AppAssets.symptomIcon,
                                height: 30.sm,
                              ),
                              title: Text('Symptoms Assessment',
                                  style: theme.textTheme.titleSmall),
                            ),
                            //Appointment
                            ListTile(
                              leading: Image.asset(
                                AppAssets.appoitnmentIcon,
                                height: 30.sm,
                              ),
                              title: Text('Appointment',
                                  style: theme.textTheme.titleSmall),
                            ),
                            //health Report
                            ExpansionTile(
                              leading: Image.asset(
                                AppAssets.healthreportIcon,
                                height: 30.sm,
                              ),
                              title: Text('Health Report',
                                  style: theme.textTheme.titleSmall),
                              children: [
                                ListTile(
                                  onTap: () {
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: (context) => AncsPage()));
                                    Navigator.pop(context);

                                    context.read<NavigationIndexCubit>().changeIndex(index: 5, title: 'ANC');
                                    context.read<AncsCubit>().getAncs();
                                  // BlocProvider.of<AncsCubit>(context).getAncs();
                                  },
                                  title: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 80, right: 50),
                                    child: Text("ANC",
                                        style: theme.textTheme.titleSmall),
                                  ),
                                ),
                                ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DeliveryPage()));
                                  },
                                  title: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 80, right: 50),
                                    child: Text("Delivery",
                                        style: theme.textTheme.titleSmall),
                                  ),
                                ),
                                ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MedicationPage()));
                                  },
                                  title: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 80, right: 50),
                                    child: Text("Medication",
                                        style: theme.textTheme.titleSmall),
                                  ),
                                ),
                                ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => PncsPage()));
                                  },
                                  title: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 80, right: 50),
                                    child: Text("PCN",
                                        style: theme.textTheme.titleSmall),
                                  ),
                                ),
                                ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Labtestpage()));
                                  },
                                  title: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 80, right: 50),
                                    child: Text("Lab Test",
                                        style: theme.textTheme.titleSmall),
                                  ),
                                ),
                              ],
                            ),

                            ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BabyPage()));
                              },
                              leading: Image.asset(
                                AppAssets.babyIcon,
                                height: 30.sm,
                                color: Colors.red,
                              ),
                              title: Text('Baby',
                                  style: theme.textTheme.titleSmall),
                            ),

                            ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FaqsPage()));
                              },
                              leading: Image.asset(
                                AppAssets.faqsIcon,
                                height: 30.sm,
                              ),
                              title: Text('FAQs',
                                  style: theme.textTheme.titleSmall),
                            ),
                            //log out button
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: TextButton.icon(
                                    label: Text(
                                      'Logout',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    onPressed: () async {
                                      final AuthLocalData _localData =
                                          AuthLocalData();
                                      String? token =
                                          await _localData.getTokenFromocal();
                                      if (token != null && token.isNotEmpty) {
                                        final status =
                                            await _localData.clearToken();
                                        if (status) {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      const LoginPage()),
                                              (route) => false);
                                        }
                                      }
                                    },
                                    icon:
                                        Icon(Icons.logout, color: Colors.red)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
