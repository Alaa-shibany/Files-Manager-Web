import 'package:flutter/material.dart';
import 'package:files_manager/generated/l10n.dart';

class NoMessageFound extends StatelessWidget {
  const NoMessageFound({super.key, required this.mediaQuery});
  final Size mediaQuery;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mediaQuery.width,
      height: mediaQuery.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.message,
            color: Colors.grey,
            size: mediaQuery.width / 3,
          ),
          Text(S.of(context).no_messages_yet),
        ],
      ),
    );
  }
}
