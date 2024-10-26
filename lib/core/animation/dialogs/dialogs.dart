import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:lottie/lottie.dart';
import 'package:quickalert/quickalert.dart';
import 'package:files_manager/theme/color.dart';

import '../../../generated/l10n.dart';

void loadingDialog(
    {required BuildContext context,
    required Size mediaQuery,
    String title = ''}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SpinKitFadingCircle(
            color: AppColors.primaryColor,
            size: mediaQuery.width / 8,
          ),
          SizedBox(
            height: mediaQuery.height / 90,
          ),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

void internetToast({
  required BuildContext context,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(S.of(context).no_internet),
  ));
}

void serverToast({
  required BuildContext context,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(S.of(context).server_down),
  ));
}

void internetDialog({required BuildContext context, required Size mediaQuery}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white70,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lottie/no_internet.json',
            fit: BoxFit.contain,
            width: mediaQuery.width / 5,
            height: mediaQuery.height / 5,
          ),
          Text(
            S.of(context).internet_connect_field,
            softWrap: true,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    ),
  );
}

void errorDialog({
  required BuildContext context,
  required String text,
}) {
  const textStyle =
      TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w600);
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.dark,
      title: Text(S.of(context).error),
      content: Text(text),
      actions: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              AppColors.primaryColor.withOpacity(0.1),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(S.of(context).cancel, style: textStyle),
        ),
      ],
    ),
  );
}

void infoDialog(
    {required BuildContext context,
    required String text,
    required void Function()? onConfirmBtnTap}) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.info,
    title: S.of(context).info,
    text: text,
    confirmBtnColor: Colors.amber.shade400,
    confirmBtnText: S.of(context).cancel,
    onConfirmBtnTap: onConfirmBtnTap,
  );
}

void successDialog({
  required BuildContext context,
  required String text,
}) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.success,
    title: S.of(context).info,
    text: text,
    confirmBtnColor: Colors.green,
    confirmBtnText: S.of(context).cancel,
  );
}
