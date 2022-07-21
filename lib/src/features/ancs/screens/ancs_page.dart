import 'package:aamako_maya/src/core/widgets/drawer/drawer_widget.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/shadow_container.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/core/widgets/scaffold/primary_appBar.dart';
import 'package:aamako_maya/src/core/widgets/scaffold/secondary_appbar.dart';
import 'package:aamako_maya/src/features/ancs/cubit/ancs_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/padding/padding.dart';
import '../../../core/theme/app_colors.dart';
import '../cubit/page_change_cubit.dart';

class AncsPage extends StatefulWidget {
  const AncsPage({Key? key}) : super(key: key);

  @override
  State<AncsPage> createState() => _AncsPageState();
}

class _AncsPageState extends State<AncsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final thene=Theme.of(context);
    return BlocProvider(
      create: (context) => PageChangeCubit(),
      child: Builder(builder: (context) {
        return SafeArea(
          child: Scaffold(
              key: _scaffoldKey,
              drawer: const DrawerWidget(),
              body: SizedBox(
                height: size.height,
                width: size.width,
                child: Stack(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                          top: 80.h,
                        ),
                        child: PageView(
                          onPageChanged: (value) {
                            context.read<PageChangeCubit>().togglePage(value);
                          },
                          physics: const NeverScrollableScrollPhysics(),
                          controller: controller,
                          children: [
                            Center(
                              child: Text('INFO'),
                            ),
                            BlocBuilder<AncsCubit, AncsState>(
                              builder: (context, state) {
                                if (state.ancs == null) {
                                  return ShimmerLoading(
                                      boxHeight: 200.h, itemCount: 4);
                                } else if (state.ancs?.isEmpty ?? false) {
                                  return const Text('NO ANC REPORTS FOUND');
                                } else {
                                  return ListView.separated(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 30.h),
                                      itemBuilder: ((context, index) {
                                        return Column(
                                          children: [
                                            Text("ANC Report${0 + 1}"
                                                .toUpperCase()),
                                            VerticalSpace(10.h),
                                            ListTile(
                                              trailing: Text(

                                                  // state.ancs?[index].swelling ??

                                                  ''),
                                              leading: const Text('Swelling'),
                                            ),
                                            ListTile(
                                              trailing: Text(
                                                  // state.ancs?[index].babyPresentation ??
                                                  'dssd'),
                                              leading: const Text(
                                                  'Baby Presentation'),
                                            ),
                                          ],
                                        );
                                      }),
                                      separatorBuilder: (ctx, index) {
                                        return Divider(
                                          height: 10.h,
                                          indent: 10.w,
                                          endIndent: 10.w,
                                          color: AppColors.accentGrey,
                                        );
                                      },
                                      itemCount: 9);
                                }
                              },
                            ),
                          ],
                        )),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SecondaryAppBar(
                          scaffoldKey: _scaffoldKey,
                          title: 'ANC',
                          height: 80.h,
                        ),
                        Positioned(
                          bottom: -15,
                          left: 100.w,
                          right: 100.w,
                          child: BlocBuilder<PageChangeCubit, int>(
                            builder: (context, state) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: ShadowContainer(
                                  shadowColor: Colors.black,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: TextButton(
                                            onPressed: () {
                                              context
                                                  .read<PageChangeCubit>()
                                                  .togglePage(0);
                                              if (state == 1) {
                                                controller.previousPage(
                                                    duration: Duration(
                                                        milliseconds: 600),
                                                    curve: Curves.easeIn);
                                              }
                                            },
                                            child: Text(
                                              'INFO'.toUpperCase(),
                                            style: thene.textTheme.labelSmall?.copyWith(
                                                color:state==0 ? AppColors.primaryRed
                                                      : Colors.black

                                              ),
                                            )),
                                      ),
                                      Expanded(
                                        child: TextButton(
                                            onPressed: () {
                                              context
                                                  .read<PageChangeCubit>()
                                                  .togglePage(1);
                                              if (state == 0) {
                                                controller.nextPage(
                                                    duration: Duration(
                                                        milliseconds: 600),
                                                    curve: Curves.easeIn);
                                              }
                                            },
                                            child: Text(
                                              'REPORT'.toUpperCase(),
                                           
                                              style: thene.textTheme.labelSmall?.copyWith(
                                                color:state==1 ? AppColors.primaryRed
                                                      : Colors.black

                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )),
        );
      }),
    );
  }
}
