import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:files_manager/cubits/add_member_cubit/add_member_cubit.dart';
import 'package:files_manager/cubits/board_settings_cubit/board_settings_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/models/invited_user_model.dart';
import 'package:files_manager/screens/add_member_screen/add_member_screen.dart';
import 'package:files_manager/screens/add_member_screen/update_member_screen.dart';
import 'package:files_manager/theme/color.dart';
import 'package:files_manager/widgets/custom_text_fields/custom_text_field.dart';
import 'package:files_manager/widgets/helper/no_data.dart';

import '../../core/functions/statics.dart';

class BoardUsersSection extends StatelessWidget {
  const BoardUsersSection(
      {super.key, required this.mediaQuery, required this.boardSettingsCubit});
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
              Row(
                children: [
                  SizedBox(
                    width: mediaQuery.width / 1.3,
                    child: CustomFormTextField(
                      fillColor: Colors.transparent,
                      controller: boardSettingsCubit.searchController,
                      borderRadius: 15,
                      borderColor: Colors.white10,
                      hintText: S.of(context).search_about_user,
                      nameLabel: '',
                      onChanged: (p0) async {
                        await boardSettingsCubit.search();
                      },
                      styleInput: const TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => AddMemberCubit(),
                              ),
                            ],
                            child: AddMemberScreen(
                              boardSettingsCubit: boardSettingsCubit,
                            ),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.add_circle,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              boardSettingsCubit.searchMembers.isEmpty
                  ? NoData(iconData: Icons.search, text: S.of(context).no_data)
                  : Expanded(
                      child: ListView(
                        // shrinkWrap: true,
                        children: List.generate(
                          boardSettingsCubit.searchMembers.length,
                          (index) {
                            return boardSettingsCubit.searchMembers[index]
                                    is InvitedUser
                                ? ListTile(
                                    leading: memberWidget(
                                        memberName: boardSettingsCubit
                                            .searchMembers[index].invitedEmail,
                                        role: null,
                                        mediaQuery: mediaQuery,
                                        userImage: boardSettingsCubit
                                            .searchMembers[index].image),
                                    title: Text(
                                      '${boardSettingsCubit.searchMembers[index].invitedEmail}',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      '${S.of(context).status}: ${boardSettingsCubit.searchMembers[index].status} ',
                                      style: const TextStyle(
                                          color: Colors.white54,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : ListTile(
                                    leading: memberWidget(
                                      memberName: boardSettingsCubit
                                          .searchMembers[index].firstName,
                                      role: boardSettingsCubit
                                          .searchMembers[index].role,
                                      mediaQuery: mediaQuery,
                                      userImage: boardSettingsCubit
                                          .searchMembers[index].image,
                                    ),
                                    title: Text(
                                      '${boardSettingsCubit.searchMembers[index].firstName} ${boardSettingsCubit.searchMembers[index].lastName}',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      '${boardSettingsCubit.searchMembers[index].role} ',
                                      style: const TextStyle(
                                          color: Colors.white54,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: PopupMenuButton(
                                      icon: const Icon(Icons.more_vert),
                                      onSelected: (value) {
                                        if (value == 'edit') {
                                          print('Setting');
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MultiBlocProvider(
                                                providers: [
                                                  BlocProvider(
                                                    create: (context) =>
                                                        AddMemberCubit()
                                                          ..initState(
                                                              boardSettingsCubit
                                                                  .searchMembers[
                                                                      index]
                                                                  .role),
                                                  ),
                                                ],
                                                child: UpdateMemberScreen(
                                                  currentMember:
                                                      boardSettingsCubit
                                                          .searchMembers[index],
                                                  boardSettingsCubit:
                                                      boardSettingsCubit,
                                                ),
                                              ),
                                            ),
                                          );
                                        } else if (value == 'delete') {
                                          print('delete');
                                        }
                                      },
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: 'edit',
                                          child: ListTile(
                                            leading: const Icon(Icons.settings),
                                            title: Text(S.of(context).edit),
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: 'delete',
                                          child: ListTile(
                                            leading: const Icon(Icons.delete),
                                            title: Text(S.of(context).delete),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                          },
                        ),
                      ),
                    )
            ],
          ),
        );
      },
    );
  }

  Widget memberWidget({
    required String memberName,
    required String? role,
    required Size mediaQuery,
    String? userImage,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: Statics.isPlatformDesktop
                ? mediaQuery.width / 100
                : mediaQuery.width / 30,
            vertical: Statics.isPlatformDesktop
                ? mediaQuery.width / 150
                : mediaQuery.height / 80,
          ),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blueAccent,
          ),
          child: Text(
            memberName[0],
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Statics.isPlatformDesktop
                    ? mediaQuery.width / 60
                    : mediaQuery.width / 30),
          ),
        ),
        if (role == 'admin')
          Positioned(
            bottom: Statics.isPlatformDesktop ? 10 : -5,
            right: -mediaQuery.width / 90,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.width / 120,
                  vertical: mediaQuery.height / 130),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.star,
                color: Colors.white,
                size: Statics.isPlatformDesktop
                    ? mediaQuery.width / 120
                    : mediaQuery.width / 30,
              ),
            ),
          ),
      ],
    );
  }
}
