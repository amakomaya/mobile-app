import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/features/faqs/cubit/faqs_cubit.dart';
import 'package:aamako_maya/src/features/faqs/screen/mysquare.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FaqsPage extends StatefulWidget {
  const FaqsPage({Key? key}) : super(key: key);

  @override
  State<FaqsPage> createState() => _FaqsState();
}

class _FaqsState extends State<FaqsPage> {
  @override
  void initState() {
    context.read<FaqsCubit>().getfaqs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Container(
            height: 70.h,
            decoration: const BoxDecoration(
                color: AppColors.primaryRed,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
            child: Padding(
              padding: defaultPadding,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  const Spacer(),
                  Text(
                    'FAQs',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const Spacer()
                ],
              ),
            ),
          ),
          Expanded(child: BlocBuilder<FaqsCubit, FaqsState>(
            builder: (context, state) {
              if (state.faqs == null) {
                return ShimmerLoading(boxHeight: 200.h, itemCount: 4);
              } else if (state.faqs?.isEmpty ?? false) {
                return const Text('NO faqs REPORTS FOUND');
              } else {
                return ListView.separated(
                    itemBuilder: ((context, index) {
                      return Column(
                        children: [
                          //  Text(" Report${index + 1}".toUpperCase()),
                          VerticalSpace(10.h),
                          Container(
                            margin: EdgeInsets.only(left: 18, right: 18),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(23),
                              ),
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    state.faqs?[index].question.toString() ??
                                        '',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.red,
                                        fontFamily: "lato"),
                                  ),
                                ),
                                Container(
                                    decoration: BoxDecoration(),
                                    child: Text(
                                        state.faqs?[index].answer.toString() ??
                                            ''))
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                    separatorBuilder: (ctx, index) {
                      return Divider(
                        color: AppColors.white,
                      );
                    },
                    itemCount: state.faqs?.length ?? 0);
              }
            },
          ))
        ],
      )),
    );
  }
}
