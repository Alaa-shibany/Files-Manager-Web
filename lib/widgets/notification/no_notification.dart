import 'package:flutter/material.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/theme/color.dart';

class NoNotification extends StatelessWidget {
  const NoNotification({super.key});

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_on_rounded,
              color: AppColors.primaryColor,
              size: mediaQuery.width / 6,
            ),
            Text(
              S.of(context).oops_no_notifications_yet,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: mediaQuery.width / 23,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: mediaQuery.width / 40),
              child: Text(
                S.of(context).no_notification,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: mediaQuery.width / 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
