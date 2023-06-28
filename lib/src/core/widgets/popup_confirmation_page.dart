
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../l10n/locale_keys.g.dart';
import '../theme/app_colors.dart';

class PopUpConfirmation extends StatefulWidget {
  final String message;
  final bool? forProfileFill;

  final Function() onConfirmed;
  final Function()? onCanceled;

  const PopUpConfirmation({
    Key? key,
    required this.message,
    required this.onConfirmed,
    this.onCanceled,
    this.forProfileFill = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => PopUpConfirmationState();
}

class PopUpConfirmationState extends State<PopUpConfirmation>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: REdgeInsets.all(40.0),
          padding: REdgeInsets.only(top: 40, bottom: 10),
          decoration: ShapeDecoration(
              color: AppColors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
               Icon(
                Icons.info_outline_rounded,
                size: 80.r,
                color: Colors.black26,
              ),
              Flexible(
                child: Padding(
                  padding:
                      REdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: Text(
                    widget.message,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20.sm,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 40.h,
                      width: 120.w,
                      child: TextButton(
                        onPressed:
                            widget.onCanceled ?? () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0.r),
                          ),
                        ),
                        child: Text(
                          widget.forProfileFill== true ? LocaleKeys.label_later.tr():LocaleKeys.label_no.tr(),
                          style: TextStyle(
                            fontSize: 14.sm,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                     SizedBox(
                      width: 8.w,
                    ),
                    SizedBox(
                      height: 40.h,
                      width: 120.w,
                      child: TextButton(
                        onPressed: widget.onConfirmed,
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.primaryRed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0.r),
                          ),
                        ),
                        child: Text(
                          widget.forProfileFill== true ? LocaleKeys.label_fill_now.tr():LocaleKeys.label_yes.tr(),
                          style: TextStyle(
                            fontSize: 14.sm,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
               SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
