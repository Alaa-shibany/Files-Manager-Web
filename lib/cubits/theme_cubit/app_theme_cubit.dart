import 'package:bloc/bloc.dart';
import 'package:files_manager/models/themestate.dart';
import 'package:meta/meta.dart';

import '../../core/shared/local_network.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(AppThemeInitial()) {
    final cachedTheme = CashNetwork.getCashData(key: 'theme');
   if (cachedTheme == 'Light') {
      theme = ThemeState.Light;
      emit(AppThemeLight());
    } else {
      theme = ThemeState.Dark; // Default
      emit(AppThemeDark());
    }
  }

  late ThemeState theme;

  changeTheme(ThemeState state) {
    switch (state) {
      case ThemeState.Light:
        theme = ThemeState.Light;
        CashNetwork.insertToCash(key: 'theme', value: 'Light');
        emit(AppThemeLight());
        break;
      case ThemeState.Dark:
        theme = ThemeState.Dark;
        CashNetwork.insertToCash(key: 'theme', value: 'Dark');
        emit(AppThemeDark());
        break;
      default:
        break;
    }
  }
}
