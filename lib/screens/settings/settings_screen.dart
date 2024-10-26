import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:files_manager/core/animation/dialogs/dialogs.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/cubits/auth/delete_account/delete_account_cubit.dart';
import 'package:files_manager/cubits/locale_cubit/locale_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/theme/color.dart';
import 'package:files_manager/widgets/settings/setting_section_widget.dart';
import 'package:files_manager/widgets/settings/trailing_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final localeCubit = context.read<LocaleCubit>();
    return Scaffold(
      backgroundColor: AppColors.dark,
      appBar: AppBar(
        toolbarHeight: mediaQuery.height / 80,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<LocaleCubit, LocaleState>(
            listener: (context, state) {
              if (state is ChangeLocaleState) {
                context.read<LocaleCubit>().emit(state);
              }
            },
          ),
          BlocListener<DeleteAccountCubit, DeleteAccountState>(
            listener: (context, state) {
              if (state is LogoutLoading || state is DeleteAccountLoading) {
                loadingDialog(context: context, mediaQuery: mediaQuery);
              }
              if (state is LogoutSuccess || state is DeleteAccountSuccess) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login_screen', (Route<dynamic> route) => false);
                CashNetwork.clearCash();
                Hive.box('main').clear();
                Phoenix.rebirth(context);
              }
            },
          ),
        ],
        child: BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, state) {
            String currentLanguage =
                localeCubit.locale.languageCode == 'en' ? 'English' : 'العربية';
            return BlocListener<DeleteAccountCubit, DeleteAccountState>(
              listener: (context, state) {
                if (state is LogoutLoading) {
                  loadingDialog(context: context, mediaQuery: mediaQuery);
                } else if (state is LogoutSuccess) {
                  Navigator.of(context).pushReplacementNamed('/login_screen');
                  CashNetwork.clearCash();
                  Hive.box('main').clear();
                  Phoenix.rebirth(context);
                }
              },
              child: SettingsList(
                applicationType: ApplicationType.both,
                lightTheme: const SettingsThemeData(
                  leadingIconsColor: AppColors.primaryColor,
                  settingsListBackground: AppColors.dark,
                  dividerColor: AppColors.primaryColor,
                  settingsSectionBackground: Colors.transparent,
                  titleTextColor: AppColors.primaryColor,
                  trailingTextColor: AppColors.primaryColor,
                  settingsTileTextColor: AppColors.white,
                  inactiveTitleColor: AppColors.primaryColor,
                  inactiveSubtitleColor: AppColors.primaryColor,
                  tileDescriptionTextColor: AppColors.white,
                  tileHighlightColor: Colors.transparent,
                ),
                platform: DevicePlatform.device,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.width / 40,
                ),
                sections: [
                  SettingSectionWidget(
                    sectionTitle: S.of(context).profile,
                    tiles: [
                      SettingsTile.navigation(
                        description: Text(S.of(context).profile_information),
                        leading: const Icon(Icons.person),
                        title: Text(S.of(context).profile),
                        onPressed: (context) {
                          Navigator.of(context).pushNamed('/user_profile');
                        },
                      ),
                    ],
                  ),
                  SettingSectionWidget(
                    sectionTitle: S.of(context).common,
                    tiles: [
                      SettingsTile.navigation(
                        leading: const Icon(Icons.language),
                        description: Text(S.of(context).change_language),
                        trailing: TrailingWidget(
                          mediaQuery: mediaQuery,
                          valueName: currentLanguage,
                        ),
                        title: Text(S.of(context).language),
                        onPressed: (context) {
                          localeCubit.showLanguageDialog(context);
                        },
                      ),
                      SettingsTile.navigation(
                        leading: const Icon(Icons.password_rounded),
                        description: Text(S.of(context).change_password),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColors.primaryColor,
                        ),
                        title: Text(S.of(context).change_password),
                        onPressed: (context) {
                          Navigator.of(context).pushNamed('/change_password');
                        },
                      ),
                      SettingsTile.navigation(
                        leading: const Icon(Icons.my_library_books_rounded),
                        description: Text(S.of(context).report),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColors.primaryColor,
                        ),
                        title: Text(S.of(context).daily_report),
                        onPressed: (context) {
                          Navigator.of(context).pushNamed('/report_screen');
                        },
                      ),
                      SettingsTile.navigation(
                        leading: const Icon(Icons.privacy_tip_rounded),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColors.primaryColor,
                        ),
                        title: Text(S.of(context).privacy_and_policy),
                        onPressed: (context) {
                          Navigator.of(context)
                              .pushNamed('/privacy_and_policy');
                        },
                      ),
                      SettingsTile.navigation(
                        leading: const Icon(Icons.find_in_page),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColors.primaryColor,
                        ),
                        title: Text(S.of(context).terms_and_conditions),
                        onPressed: (context) {
                          Navigator.of(context)
                              .pushNamed('/terms_and_conditions');
                        },
                      ),
                    ],
                  ),
                  SettingSectionWidget(
                    sectionTitle: S.of(context).account,
                    tiles: [
                      SettingsTile.navigation(
                        leading: const Icon(Icons.remove_circle),
                        title: Text(
                          S.of(context).removeAccount,
                        ),
                        onPressed: (context) async {
                          context
                              .read<DeleteAccountCubit>()
                              .showDialogRemoveAccount(context);
                        },
                      ),
                      SettingsTile.navigation(
                        leading: const Icon(Icons.logout_rounded),
                        description: Text(S.of(context).logout),
                        title: Text(S.of(context).logout),
                        onPressed: (context) async {
                          context
                              .read<DeleteAccountCubit>()
                              .showDialogLogout(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
