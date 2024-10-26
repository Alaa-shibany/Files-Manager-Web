import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/theme/color.dart';
part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleInitial()) {
    initializeLocale();
  }

  late Locale locale;

  void initializeLocale() {
    String? currentLang = CashNetwork.getCashData(key: 'currentLang');
    if (currentLang.isEmpty) {
      locale = const Locale('en', 'US');
    } else if (currentLang == 'ar') {
      locale = const Locale('ar', 'AR');
    } else {
      locale = const Locale('en', 'US');
    }
    emit(ChangeLocaleState()); // Emit state to update UI
  }

  Future setLocale(Locale value) async {
    locale = value;
    print('Change the locale');
    print('The code is ${locale.languageCode}');
    await CashNetwork.insertToCash(
        key: 'currentLang', value: locale.languageCode);
    emit(ChangeLocaleState());
  }

  void clearLocale() {
    locale = const Locale('en', 'US'); // Set a default value
    emit(ClearLocaleState());
  }

  void showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextStyle styleLang = const TextStyle(color: Colors.white);
        return AlertDialog(
          backgroundColor: AppColors.dark,
          title: Text(
            S.of(context).change_language,
            style: const TextStyle(color: AppColors.primaryColor),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Image.asset('assets/icons/usa.png', width: 32),
                title: Text(S.of(context).english, style: styleLang),
                onTap: () {
                  setLocale(const Locale('en', 'US'));
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Image.asset('assets/icons/sa.png', width: 32),
                title: Text(S.of(context).arabic, style: styleLang),
                onTap: () {
                  setLocale(const Locale('ar', 'AR'));
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
