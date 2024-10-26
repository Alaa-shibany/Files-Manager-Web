import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:files_manager/cubits/board_settings_cubit/board_settings_cubit.dart';
import 'package:files_manager/generated/l10n.dart';

class BoardPrivacySection extends StatelessWidget {
  const BoardPrivacySection(
      {super.key, required this.boardSettingsCubit, required this.mediaQuery});
  final Size mediaQuery;
  final BoardSettingsCubit boardSettingsCubit;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BoardSettingsCubit, BoardSettingsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: mediaQuery.width / 30,
            vertical: mediaQuery.height / 90,
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () async {
                  await boardSettingsCubit.changePrivacy(value: 'private');
                },
                leading: Radio(
                    activeColor: Colors.white,
                    value: 'private',
                    groupValue: boardSettingsCubit.currentBoard.visibility,
                    onChanged: (value) async {
                      await boardSettingsCubit.changePrivacy(value: value!);
                    }),
                title: Text(S.of(context).private,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Text(
                  S.of(context).only_board_users_can_view_it,
                  style: const TextStyle(color: Colors.white54),
                ),
              ),
              ListTile(
                onTap: () async {
                  await boardSettingsCubit.changePrivacy(value: 'public');
                },
                leading: Radio(
                    activeColor: Colors.white,
                    value: 'public',
                    groupValue: boardSettingsCubit.currentBoard.visibility,
                    onChanged: (value) async {
                      await boardSettingsCubit.changePrivacy(value: value!);
                    }),
                title: Text(S.of(context).general,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Text(
                  S.of(context).anyone_with_the_link_to_the_board_can_view_it,
                  style: const TextStyle(color: Colors.white54),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
