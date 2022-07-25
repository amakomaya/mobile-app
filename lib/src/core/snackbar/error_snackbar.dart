import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/helper_widgets/shadow_container.dart';

class ErrorSnackBar extends StatelessWidget {

  final String message;
  const ErrorSnackBar({ Key? key, required this.message }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ShadowContainer(
              color: AppColors.primaryRed,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(message ,style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.white
                ),),
              ),
            );
  }
}