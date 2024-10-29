import 'package:files_manager/core/functions/statics.dart';
import 'package:flutter/material.dart';

class ApplicationWidget extends StatelessWidget {
  const ApplicationWidget(
      {super.key,
      required this.mediaQuery,
      required this.context,
      required this.asset,
      required this.title,
      this.onTap});
  final Size mediaQuery;
  final BuildContext context;
  final String asset;
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Statics.isPlatformDesktop
            ? mediaQuery.width / 5
            : mediaQuery.width / 2.3,
        margin: EdgeInsets.symmetric(
            horizontal: Statics.isPlatformDesktop
                ? mediaQuery.width / 150
                : mediaQuery.width / 90,
            vertical: mediaQuery.height / 120),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                asset,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
