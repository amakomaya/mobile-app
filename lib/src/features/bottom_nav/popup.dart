import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

Future<bool> showExitPopup(context) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Do you want to exit?",
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text(
                          "Yes",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: AppColors.primaryRed),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text("No", style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        );
      });


}
