import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:files_manager/cubits/chat_cubit/chat_cubit.dart';
import 'package:files_manager/cubits/locale_cubit/locale_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/theme/color.dart';

part 'chat_settings_state.dart';

class ChatSettingsCubit extends Cubit<ChatSettingsState> {
  final ChatCubit chatCubit;

  ChatSettingsCubit(this.chatCubit) : super(ChatSettingsInitial());

  Future<void> refresh() async {
    emit(ChatSettingsInitial());
  }

  String? chatLanguageCode;

  Future<void> changeLanguage({required String lang}) async {
    emit(ChatSettingsInitial());
    await chatCubit.refresh();
  }

  void showLanguageDialog(BuildContext context) {
    final localCubit = context.read<LocaleCubit>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextStyle styleTextLang =
            const TextStyle(color: AppColors.primaryColor);
        return AlertDialog(
          backgroundColor: AppColors.dark,
          title: Text(S.of(context).change_language),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title:
                    Text(S.of(context).default_language, style: styleTextLang),
                onTap: () async {
                  // Handle default language selection
                  print(
                      'Default Language App is :=> ${localCubit.locale.languageCode}');
                  await changeLanguage(lang: 'default');
                  await refresh();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text(S.of(context).arabic, style: styleTextLang),
                onTap: () async {
                  await changeLanguage(lang: 'ar');
                  await refresh();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text(S.of(context).english, style: styleTextLang),
                onTap: () async {
                  await changeLanguage(lang: 'en');
                  await refresh();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              style: const ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(AppColors.primaryColor)),
              child: Text(S.of(context).cancel,
                  style: const TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
