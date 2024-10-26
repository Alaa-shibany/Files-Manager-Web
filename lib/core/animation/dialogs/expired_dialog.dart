import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quickalert/quickalert.dart';
import 'package:files_manager/theme/color.dart';

import '../../../../generated/l10n.dart';

void showExpiredDialog(
    {required BuildContext context,
    required void Function()? onConfirmBtnTap}) {
  const textStyle =
      TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w600);
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.dark,
      title: Text(S.of(context).error),
      content: Text(S.of(context).session_expired),
      actions: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              AppColors.primaryColor.withOpacity(0.1),
            ),
          ),
          onPressed: onConfirmBtnTap,
          child: Text(S.of(context).cancel, style: textStyle),
        ),
      ],
    ),
  );
}

void noInternetDialog(
    {required BuildContext context,
    required Size mediaQuery,
    required void Function()? onPressed}) {
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
            'assets/lotties/no_internet.json',
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
          ElevatedButton(
              onPressed: onPressed,
              child: const Text(
                'Try again',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))
        ],
      ),
    ),
  );
}

void serverFiledDialog({
  required BuildContext context,
}) {
  QuickAlert.show(
    context: context,
    disableBackBtn: false,
    barrierDismissible: false,
    type: QuickAlertType.error,
    title: S.of(context).error,
    text: S.of(context).server_down,
    confirmBtnText: S.of(context).ok,
    confirmBtnColor: Colors.red,
    onConfirmBtnTap: () async {
      Navigator.of(context).pop();
    },
  );
}
