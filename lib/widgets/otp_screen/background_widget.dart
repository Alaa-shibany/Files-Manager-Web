import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget(
      {super.key,
      required this.child,
      required this.backgroundColor,
      required this.mediaQuery});
  final Size mediaQuery;
  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: mediaQuery.width,
          height: mediaQuery.height / 2.5,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: mediaQuery.height / 30,
              ),
              Image(
                image: const AssetImage('assets/icons/logo.png'),
                height: mediaQuery.height / 8,
                width: mediaQuery.width / 3,
                fit: BoxFit.contain,
              ),
              child,
            ],
          ),
        ),
      ],
    );
  }
}
