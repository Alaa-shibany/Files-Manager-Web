import 'package:flutter/material.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/theme/color.dart';

class NoApplicationFound extends StatelessWidget {
  const NoApplicationFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.grid_view,
          size: 64,
          color: AppColors.primaryColor,
        ),
        const SizedBox(height: 16),
        Text(
          S.of(context).there_are_no_applications,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
