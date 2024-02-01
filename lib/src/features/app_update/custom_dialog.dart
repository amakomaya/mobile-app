import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomDialog extends StatelessWidget {
  final String message;
  final String title;
  final IconData icon;

  final Function()? onAction;
  final String actionText;
  final String? dismissText;
  final bool showDismiss;

  const CustomDialog(
      {Key? key,
      required this.message,
      required this.title,
      this.onAction,
      this.showDismiss = false,
      this.dismissText,
      this.actionText = '',
      this.icon = Icons.info_outline_rounded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: EdgeInsets.all(40.0.r),
          padding: EdgeInsets.only(top: 40.r, bottom: 10.r),
          decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0.r))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 80.sp, color: Colors.black26),
              Flexible(
                child: RPadding(
                  padding:
                       EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              RPadding(
                padding:
                     EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
                child: Text(
                  message,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (showDismiss)
                      SizedBox(
                        height: 40.h,
                        width: 120.w,
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0.r),
                            ),
                          ),
                          child: Text(
                            dismissText ?? "Cancel",
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(
                      width: 8.w,
                    ),
                    if (onAction != null)
                      SizedBox(
                        height: 40.h,
                        width: 120.w,
                        child: TextButton(
                          onPressed: onAction,
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0).r,
                            ),
                          ),
                          child: Text(
                            actionText,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.white,
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
