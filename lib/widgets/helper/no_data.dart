import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:files_manager/theme/color.dart';

class NoData extends StatelessWidget {
  const NoData({super.key, required this.iconData, required this.text});
  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          color: AppColors.primaryColor,
          size: mediaQuery.width / 8,
        ),
        SizedBox(
          height: mediaQuery.height / 70,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: mediaQuery.width / 40,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: mediaQuery.width / 30,
            ),
          ),
        )
      ],
    ).animate().fade(
          duration: const Duration(milliseconds: 500),
        );
  }
}
