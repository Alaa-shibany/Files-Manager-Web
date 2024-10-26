import 'package:flutter/material.dart';
import 'package:files_manager/theme/color.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget(
      {super.key,
      this.onPressed,
      required this.mediaQuery,
      required this.title,
      this.color = AppColors.primaryColor});
  final void Function()? onPressed;
  final Size mediaQuery;
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shadowColor: Colors.black,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Border radius
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: mediaQuery.width / 5,
          vertical: mediaQuery.height / 60,
        ),
        child: Text(
          title,
          style:
              TextStyle(color: Colors.white, fontSize: mediaQuery.width / 25),
        ),
      ),
    );
  }
}
