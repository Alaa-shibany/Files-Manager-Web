import 'package:files_manager/core/functions/statics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:files_manager/core/animation/dialogs/dialogs.dart';
import 'package:files_manager/core/animation/dialogs/expired_dialog.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/cubits/all_boards_cubit/all_boards_cubit.dart';
import 'package:files_manager/cubits/board_settings_cubit/board_settings_cubit.dart';
import 'package:files_manager/cubits/locale_cubit/locale_cubit.dart';
import 'package:files_manager/generated/l10n.dart';

import 'package:files_manager/theme/color.dart';
import 'package:files_manager/widgets/board_settings/board_privacy_section.dart';
import 'package:files_manager/widgets/board_settings/board_settings_section.dart';
import 'package:files_manager/widgets/board_settings/board_users_section.dart';
import 'package:files_manager/widgets/custom_text_fields/custom_text_fields.dart';

class BoardSettingsScreen extends StatelessWidget {
  const BoardSettingsScreen({super.key, required this.allBoardCubit});
  final AllBoardsCubit allBoardCubit;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final boardSettingsCubit = context.read<BoardSettingsCubit>();
    final localeCubit = context.read<LocaleCubit>();

    return BlocConsumer<BoardSettingsCubit, BoardSettingsState>(
      listener: (context, state) {
        if (state is BoardSettingsLoadingState) {
          loadingDialog(
              context: context,
              mediaQuery: mediaQuery,
              title: S.of(context).saving);
        } else if (state is BoardSettingsSuccessState) {
          Navigator.pop(context);
        } else if (state is BoardSettingsFailedState) {
          errorDialog(context: context, text: state.errorMessage);
        } else if (state is BoardSettingsExpiredState) {
          showExpiredDialog(
            context: context,
            onConfirmBtnTap: () async {
              await CashNetwork.clearCash();
              await Hive.box('main').clear();
              await Phoenix.rebirth(context);
            },
          );
        }
      },
      builder: (context, state) {
        return Localizations.override(
          locale: boardSettingsCubit.currentBoard.language.code == 'default'
              ? localeCubit.locale
              : Locale(boardSettingsCubit.currentBoard.language.code),
          context: context,
          child: WillPopScope(
            onWillPop: () async {
              await allBoardCubit.refresh();
              return true;
            },
            child: DefaultTabController(
              length: boardSettingsCubit.currentBoard.parentId != null ? 1 : 3,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.darkGray,
                  flexibleSpace: SizedBox(
                    height: mediaQuery.height / 3,
                  ),
                  toolbarHeight: Statics.isPlatformDesktop
                      ? mediaQuery.height / 8
                      : mediaQuery.height / 12,
                  title: SizedBox(
                    child: CustomTextFields(
                      textAlign: TextAlign.end,
                      styleInput: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: Statics.isPlatformDesktop
                              ? mediaQuery.width / 60
                              : mediaQuery.width / 15),
                      controller: boardSettingsCubit.boardTitleController,
                      onChanged: (p0) async {
                        await boardSettingsCubit.changeTitle();
                      },
                    ),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        allBoardCubit.refresh();
                        FocusScope.of(context).unfocus();
                      },
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: Colors.white,
                      )),
                  bottom: TabBar(
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white,
                    indicator: const BoxDecoration(
                      color: AppColors.dark,
                    ),
                    labelStyle: TextStyle(
                        fontSize: Statics.isPlatformDesktop
                            ? mediaQuery.width / 90
                            : mediaQuery.width / 30),
                    unselectedLabelStyle: TextStyle(
                        fontSize: Statics.isPlatformDesktop
                            ? mediaQuery.width / 90
                            : mediaQuery.width / 30),
                    tabs: boardSettingsCubit.currentBoard.parentId != null
                        ? [
                            Tab(
                              text: S.of(context).settings,
                              icon: const Icon(
                                Icons.settings,
                                color: Colors.white,
                              ),
                            ),
                          ]
                        : [
                            Tab(
                              text: S.of(context).settings,
                              icon: Icon(
                                Icons.settings,
                                color: Colors.white,
                                size: Statics.isPlatformDesktop
                                    ? mediaQuery.width / 50
                                    : mediaQuery.width / 30,
                              ),
                            ),
                            Tab(
                              text: S.of(context).users,
                              icon: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: Statics.isPlatformDesktop
                                    ? mediaQuery.width / 50
                                    : mediaQuery.width / 30,
                              ),
                            ),
                            Tab(
                              text: S.of(context).privacy,
                              icon: Icon(
                                Icons.visibility,
                                color: Colors.white,
                                size: Statics.isPlatformDesktop
                                    ? mediaQuery.width / 50
                                    : mediaQuery.width / 30,
                              ),
                            ),
                          ],
                  ),
                ),
                body: SizedBox(
                  child: boardSettingsCubit.currentBoard.parentId != null
                      ? TabBarView(
                          children: [
                            BoardSettingsSection(
                              boardSettingsCubit: boardSettingsCubit,
                              mediaQuery: mediaQuery,
                            ),
                          ],
                        )
                      : TabBarView(
                          children: [
                            BoardSettingsSection(
                              boardSettingsCubit: boardSettingsCubit,
                              mediaQuery: mediaQuery,
                            ),
                            BoardUsersSection(
                                mediaQuery: mediaQuery,
                                boardSettingsCubit: boardSettingsCubit),
                            BoardPrivacySection(
                              boardSettingsCubit: boardSettingsCubit,
                              mediaQuery: mediaQuery,
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
