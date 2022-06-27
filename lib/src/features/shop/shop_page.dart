import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:aamako_maya/src/core/widgets/buttons/primary_action_button.dart';
import 'package:aamako_maya/src/core/widgets/scaffold/primary_scaffold.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      appBartitle: 'Shop',
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:[
            Icon(Icons.shopping_bag,color: AppColors.primaryRed,size: 200,)
            ,PrimaryActionButton(onpress: (){}, title: 'GET STARTED')

          ]
        ),
      ),

      
    );
  }
}