import 'dart:ui';

import 'package:aamako_maya/src/core/app_assets/app_assets.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/primary_action_button.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final List _onboardList = ['1', '2', '3'];
  final PageController _controller = PageController();
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppAssets.logo),
                  Text(
                    'SKIP',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Expanded(
                child: PageView.builder(
                    onPageChanged: (selectedIndex) {
                      _currentIndex.value = selectedIndex;
                    },
                    controller: _controller,
                    itemCount: _onboardList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 10),
                        child: Column(
                          children: [
                            Text(
                              'Welcome to Aamakomaya app',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Text(
                              'All motherhood needs in one app',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            Flexible(
                              child: Image.asset(AppAssets.profileImage),
                            ),
                          ],
                        ),
                      );
                    })),
            SizedBox(
              height: 8,
              child: ValueListenableBuilder(
                  valueListenable: _currentIndex,
                  builder: (context, value, _) {
                    return ListView.builder(
                    
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _onboardList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 7),
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                                color: value == index
                                    ? AppColors.primaryRed
                                    : AppColors.primaryRed.withOpacity(0.49),
                                shape: BoxShape.circle),
                          );
                        });
                  }),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            ValueListenableBuilder(
                valueListenable: _currentIndex,
                builder: (context, value, _) {
                  return PrimaryActionButton(
                    title:
                        value == _onboardList.length - 1 ? 'Continue' : 'Next',
                    onpress: () {},
                  );
                }),
            SizedBox(
              height: size.height * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
