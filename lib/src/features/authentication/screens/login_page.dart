import 'package:aamako_maya/src/core/widgets/border_container.dart';
import 'package:aamako_maya/src/core/widgets/buttons/primary_action_button.dart';
import 'package:aamako_maya/src/core/widgets/helper_widgets/blank_space.dart';
import 'package:aamako_maya/src/core/widgets/textfield/primary_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_assets/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../bottom_nav/bottom_navigation.dart';
import '../../home/homepage.dart';

class LoginPage extends StatelessWidget {

  const LoginPage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                AppAssets.logo,
                height: 197.h,
                width: 197.h,
                cacheHeight: 197,
              ),
            ),
            VerticalSpace(50.h),
            const PrimaryTextField(
              labelText: 'Username',
              hintText: 'Username',
            ),
            VerticalSpace(15.h),
            const PrimaryTextField(
              labelText: 'Password',
              hintText: 'Password',
              suffix: Icons.visibility
            ),
            VerticalSpace(20.h),
            PrimaryActionButton(
              padding: const EdgeInsets.symmetric(vertical: 20),
              width: 380.w,
              onpress:()=>Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => const HomePage(),),),
              title: 'Login',
            ),
            VerticalSpace(20.h),
            Text('OR', style: Theme.of(context).textTheme.headlineMedium),
            VerticalSpace(20.h),
            PrimaryActionButton(
              padding: const EdgeInsets.symmetric(vertical: 20),
              width: 380.w,
              onpress: ()=>Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) =>  CustomBottomNavigation(),),),
              title: '',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.qr_code),
                  const HorizSpace(10),
                  Flexible(
                    child: Text('Login With QR-code',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontSize: 18,
                            color: AppColors.white,
                            fontWeight: FontWeight.w600)),
                  )
                ],
              ),
            ),
            VerticalSpace(20.h),
            BorderContainer(
              padding: const EdgeInsets.symmetric(vertical: 20),
              width: 380.w,
              child: Center(
                child: Text('Guest Login',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontSize: 18,
                        color: AppColors.primaryRed,
                        fontWeight: FontWeight.w600)),
              ),
            ),
            VerticalSpace(20.h),
            RichText(
                text: TextSpan(children: [
              TextSpan(text: 'Not registered yet?  ',  style: Theme.of(context).textTheme.labelSmall,
              
              ),
              TextSpan(
                  text: 'Create an Account',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryRed,
                      )),
            ])),  
            VerticalSpace(50.h),

             RichText(
                text: TextSpan(children: [
               
              TextSpan(text: 'Call ',  style: Theme.of(context).textTheme.labelSmall,
              
              ),

            
             
              TextSpan(
                  text: '9860-3434-3434',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryRed,
                      )),
                       TextSpan(
                  text: '  for an enquiry',
                  style: Theme.of(context).textTheme.labelSmall),
            ]))
          ],
        ),
      ),
    );
  }
}
