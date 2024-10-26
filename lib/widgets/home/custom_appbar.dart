import 'package:flutter/material.dart';
import 'package:files_manager/theme/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  const CustomAppBar(
      {required this.title, this.actions, super.key, this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.primaryColor,
      elevation: 0.0,
      title: Text(title),
      leading: leading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
