import 'package:flutter/material.dart';
import 'package:files_manager/theme/color.dart';

class TrailingWidget extends StatelessWidget {
  const TrailingWidget(
      {super.key, required this.mediaQuery, required this.valueName});
  final Size mediaQuery;
  final String valueName;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(valueName),
        SizedBox(width: mediaQuery.width / 40),
        const Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColors.primaryColor,
        ),
      ],
    );
  }
}
