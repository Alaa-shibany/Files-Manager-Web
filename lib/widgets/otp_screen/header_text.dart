import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  const HeaderText(
      {super.key,
      required this.mediaQuery,
      required this.mainText,
      required this.generalText});
  final Size mediaQuery;
  final String generalText;
  final String mainText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mediaQuery.width / 30,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              SizedBox(
                width: mediaQuery.width / 2,
                child: Text(
                  generalText,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: mediaQuery.width / 20,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: mediaQuery.width / 1.15,
                child: Text(
                  mainText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: mediaQuery.width / 28,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
