import 'package:files_manager/models/themestate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/theme_cubit/app_theme_cubit.dart';

class ThemeToggleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, AppThemeState>(
      builder: (context, state) {
        final isDarkTheme = state is AppThemeDark;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: isDarkTheme
                  ? [Colors.black, Colors.grey]
                  : [Colors.white, Colors.lightBlue],
            ),
          ),
          child: IconButton(
            icon: Icon(
              isDarkTheme ? Icons.dark_mode : Icons.light_mode,
              color: isDarkTheme ? Colors.white : Colors.black,
            ),
            onPressed: () {
              final themeCubit = context.read<AppThemeCubit>();
              themeCubit.changeTheme(isDarkTheme ? ThemeState.Light : ThemeState.Dark);
            },
          ),
        );
      },
    );
  }
}
