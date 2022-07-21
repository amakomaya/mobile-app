import 'package:aamako_maya/src/core/padding/padding.dart';
import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/loading_shimmer/shimmer_loading.dart';
import 'package:aamako_maya/src/features/faqs/cubit/faqs_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FaqsPage extends StatefulWidget {
  const FaqsPage({Key? key}) : super(key: key);

  @override
  State<FaqsPage> createState() => _FaqsPageState();
}

class _FaqsPageState extends State<FaqsPage> {
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
                    'Faqs',
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
                return const Text('NO  REPORTS FOUND');
              } else {
                return ListView.separated(
                    itemBuilder: ((context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //   Text(" Report${index + 1}".toUpperCase()),
                          VerticalSpace(10.h),
                          Container(
                            child: Text(state.faqs?[index].question ?? ''),
                          ),
                          Container(
                            child: Text(state.faqs?[index].answer ?? ''),
                          ),
                          Container(
                            child: Text(state.faqs?[index].mediaLinks ?? ''),
                          ),
                        ],
                      );
                    }),

                    // Text(state.faqs?[index].answer ?? ''),
                    separatorBuilder: (ctx, index) {
                      return Divider(
                        height: 10.h,
                        indent: 10.w,
                        endIndent: 10.w,
                        color: AppColors.accentGrey,
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






// Container(
//                         margin: const EdgeInsets.only(left: 18, right: 18),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(35)),
//                             border: Border.all(width: 1, color: Colors.grey),
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Colors.white10,
//                                   blurRadius: 7,
//                                   offset: Offset(0, 7))
//                             ]),
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                               left: 5, right: 5, top: 10, bottom: 10),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(state.faqs?[0].question.toString() ?? ''),
//                               Divider(),
//                               Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius:
//                                           BorderRadius.all(Radius.zero),
//                                       border: Border.all(
//                                           width: 0.5, color: Colors.grey)),
//                                   child: Text(state.faqs?[0].answer ?? '')),
//                               Text("hbdh"),
//                               VerticalSpace(10.h),
//                             ],
//                           ),
//                         ),
//                       );
