import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PrimaryActionButton extends StatelessWidget {
  final VoidCallback onpress;
  final String title;
  const PrimaryActionButton(
      {Key? key, required this.onpress, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      width: 150,
      decoration: BoxDecoration(
          color: AppColors.primaryRed, borderRadius: BorderRadius.circular(22)),
      child: Center(
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
