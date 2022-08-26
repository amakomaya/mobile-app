
import 'package:aamako_maya/src/core/app_assets/app_assets.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/buttons/primary_action_button.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/features/authentication/screens/login/login_page.dart';
import 'package:aamako_maya/src/features/onboarding/bloc/onboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<OnboardBloc, OnboardState>(
      listener: (context, state) {
        if (state.isLoading == false && state.error != null) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) => const LoginPage()));
        }
      },
      builder: (context, state) {
        return state.maybeWhen(
            orElse: () => const Scaffold(
                    body: Center(
                        child: CircularProgressIndicator(
                  color: AppColors.primaryRed,
                ))),
            success: (isLoadind, exception, list) {
              final _onboardList = list;
              return Scaffold(
                body: SafeArea(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Image.asset(
                              AppAssets.logo,
                              height: 197.h,
                              width: 197.h,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => const LoginPage(),
                              ),
                            ),
                            child: Container(
                              height: 43.h,
                              width: 104.w,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      bottomLeft: Radius.circular(50)),
                                  color: AppColors.primaryRed.withOpacity(0.2)),
                              child: Center(
                                child: Text(
                                  'SKIP',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          )
                        ],
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
                                        _onboardList[index].title ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge,
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Text(
                                        _onboardList[index].motto ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                      VerticalSpace(20.h),
                                      Expanded(
                                        child: Image.network(
                                          _onboardList[index].image ?? '',
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const Icon(
                                            Icons.image_not_supported,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      VerticalSpace(20.h),
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
                                      height: 8.h,
                                      width: 8.h,
                                      decoration: BoxDecoration(
                                          color: value == index
                                              ? AppColors.primaryRed
                                              : AppColors.primaryRed
                                                  .withOpacity(0.49),
                                          shape: BoxShape.circle),
                                    );
                                  });
                            }),
                      ),
                      VerticalSpace(15.h),
                      ValueListenableBuilder(
                          valueListenable: _currentIndex,
                          builder: (context, value, _) {
                            return PrimaryActionButton(
                              width: 185.w,
                              height: 43.h,
                              title: value == _onboardList.length - 1
                                  ? 'Continue'
                                  : 'Next',
                              onpress: value == _onboardList.length - 1
                                  ? () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ctx) => const LoginPage(),
                                        ),
                                      )
                                  : () => _controller.nextPage(
                                        duration:
                                            const Duration(milliseconds: 400),
                                        curve: Curves.decelerate,
                                      ),
                            );
                          }),
                      VerticalSpace(80.h)
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
