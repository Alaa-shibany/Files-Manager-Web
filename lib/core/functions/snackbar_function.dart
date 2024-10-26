import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:flutter/material.dart';
import 'package:files_manager/theme/color.dart';

void showLightSnackBar(BuildContext context, String messageText) {
  DelightToastBar(
          builder: (context) => ToastCard(
                color: AppColors.dark,
                leading: Image.asset('assets/icons/logo.png'),
                title: Text(
                  messageText,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
          autoDismiss: true,
          snackbarDuration: const Duration(seconds: 2))
      .show(context);
}
