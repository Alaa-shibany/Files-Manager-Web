import 'package:flutter/material.dart';
import 'package:files_manager/theme/color.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key,
      required this.mediaQuery,
      this.onPressed,
      this.color = AppColors.primaryColor,
      required this.title});
  final Size mediaQuery;
  final void Function()? onPressed;
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Container(
        width: mediaQuery.width / 2,
        height: mediaQuery.height / 20,
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
