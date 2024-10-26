import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:files_manager/cubits/add_board_cubit/add_board_cubit.dart';
import 'package:files_manager/cubits/all_boards_cubit/all_boards_cubit.dart';
import 'package:files_manager/cubits/application_cubit/application_cubit.dart';
import 'package:files_manager/cubits/barent_boards_cubit/parent_boards_cubit.dart';
import 'package:files_manager/cubits/board_favorite_cubit/board_favorite_cubit.dart';
import 'package:files_manager/cubits/board_settings_cubit/board_settings_cubit.dart';
import 'package:files_manager/cubits/move_board_cubit/move_board_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/models/board_model.dart';
import 'package:files_manager/models/member_model.dart';
import 'package:files_manager/screens/home/board_settings_screen.dart';
import 'package:files_manager/screens/move_board_screen/move_board_screen.dart';
import 'package:files_manager/theme/color.dart';

import '../../cubits/board_cubit/board_cubit.dart';
import '../../cubits/leave_from_board_cubit/leave_from_board_cubit.dart';
import '../../screens/add_board_screen/add_board_screen.dart';

class BoardWidget extends StatelessWidget {
  final Board? currentBoard;
  final int currentIndex;
  final AllBoardsCubit allBoardsCubit;
  final BoardCubit? boardCubit;
  final AddBoardCubit? addBoardCubit;
  final BoardFavoriteCubit? favoriteCubit;

  Future<void> share() async {
    print('we will share this link => ${currentBoard!.shareLink}');
    Share.share(currentBoard!.shareLink);
  }

  const BoardWidget({
    super.key,
    this.boardCubit,
    this.addBoardCubit,
    required this.currentBoard,
    required this.currentIndex,
    required this.allBoardsCubit,
    this.favoriteCubit,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final leaveFromBoardCubit = context.read<LeaveFromBoardCubit>();

    // final allBoardsCubit = context.read<AllBoardsCubit>();
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => LeaveFromBoardCubit(),
                ),
                BlocProvider(
                  create: (context) => AddBoardCubit(),
                ),
                BlocProvider(
                  create: (context) => BoardCubit(currentBoard: currentBoard!)
                    ..initState(
                      context: context,
                      uuid: currentBoard!.uuid,
                    ),
                ),
                BlocProvider(
                  create: (context) => ApplicationCubit()
                    ..initState(
                      context: context,
                      uuid: currentBoard!.uuid,
                    ),
                ),
              ],
              child: AddBoardScreen(
                allBoardsCubit: allBoardsCubit,
                uuid: currentBoard!.uuid,
              ),
            ),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: mediaQuery.height / 20,
                          width: mediaQuery.width / 10,
                          child: currentBoard!.hasImage
                              ? currentBoard!.image.isEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(360),
                                      child: Image.file(
                                        currentBoard!.imageFile!,
                                        fit: BoxFit.contain,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(360),
                                      child: CachedNetworkImage(
                                        imageUrl: currentBoard!.image,
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(
                                            color: Colors.white,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        fit: BoxFit.contain,
                                      ),
                                    )
                              : CircleAvatar(
                                  child: Text(
                                    currentBoard!.icon,
                                    style: TextStyle(
                                        fontSize: mediaQuery.width / 15),
                                  ),
                                ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Container(
                                color: Colors.transparent,
                                width: mediaQuery.width / 2,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  currentBoard!.title,
                                  style: const TextStyle(
                                    color: AppColors.dark,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  currentBoard!.parentId != null
                                      ? S.of(context).subpanel
                                      : 'Main Group',
                                  style: const TextStyle(
                                    color: Colors.black38,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: mediaQuery.width / 40,
                                ),
                                Icon(
                                  Icons.file_copy,
                                  size: mediaQuery.width / 25,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: mediaQuery.width / 90,
                                ),
                                Text(
                                  '2',
                                  style: const TextStyle(
                                    color: Colors.black38,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    currentBoard!.parentId != null
                        ? Row(
                            children: [
                              PopupMenuButton(
                                icon: const Icon(Icons.more_vert),
                                onSelected: (value) {
                                  if (value == 'settings') {
                                    print('Setting');
                                    Navigator.of(context)
                                        .push(
                                      MaterialPageRoute(
                                        builder: (context) => MultiBlocProvider(
                                          providers: [
                                            BlocProvider(
                                              create: (context) =>
                                                  BoardSettingsCubit(
                                                      currentBoard:
                                                          currentBoard!)
                                                    ..initState(),
                                            ),
                                          ],
                                          child: BoardSettingsScreen(
                                            allBoardCubit: allBoardsCubit,
                                          ),
                                        ),
                                      ),
                                    )
                                        .then(
                                      (value) async {
                                        if (currentBoard!.parentId == null) {
                                          return;
                                        }

                                        await boardCubit!.refresh();
                                      },
                                    );
                                  } else if (value == 'share') {
                                    print('Share');
                                    share();
                                  }
                                },
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 'share',
                                    child: ListTile(
                                      leading: const Icon(Icons.link),
                                      title: Text(S.of(context).share_link),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'settings',
                                    child: ListTile(
                                      leading: const Icon(Icons.settings),
                                      title: Text(S.of(context).board_settings),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              PopupMenuButton(
                                icon: const Icon(Icons.more_vert),
                                onSelected: (value) async {
                                  if (value == 'settings') {
                                    print('Setting');
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => MultiBlocProvider(
                                          providers: [
                                            BlocProvider(
                                              create: (context) =>
                                                  BoardSettingsCubit(
                                                      currentBoard:
                                                          currentBoard!)
                                                    ..initState(),
                                            ),
                                          ],
                                          child: BoardSettingsScreen(
                                            allBoardCubit: allBoardsCubit,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else if (value == 'share') {
                                    print('Share');
                                    share();
                                  } else if (value == 'leave') {
                                    print('leave board');
                                    leaveFromBoardCubit.leaveBoard(
                                        context: context,
                                        index: currentIndex,
                                        currentBoard: currentBoard!);
                                  } else if (value == 'create_sub_board') {
                                    print('create_sub_board');
                                    print(
                                        'current Board Id is:=> ${currentBoard!.id.toString()}');

                                    await addBoardCubit!.addSubBoard(
                                      parentBoard: currentBoard!,
                                      context: context,
                                      parentId: currentBoard!.id.toString(),
                                    );
                                  } else if (value == 'move_board') {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => MultiBlocProvider(
                                            providers: [
                                              BlocProvider(
                                                create: (context) =>
                                                    ParentBoardsCubit()
                                                      ..initState(
                                                          context: context),
                                              ),
                                              BlocProvider(
                                                create: (context) =>
                                                    MoveBoardCubit(),
                                              ),
                                            ],
                                            child: MoveBoardScreen(
                                              allBoardsCubit: allBoardsCubit,
                                              movedBoard: currentBoard!,
                                            )),
                                      ),
                                    );
                                  }
                                },
                                itemBuilder: (context) => currentBoard!
                                        .children.isNotEmpty
                                    ? [
                                        PopupMenuItem(
                                          value: 'share',
                                          child: ListTile(
                                            leading: const Icon(Icons.link),
                                            title:
                                                Text(S.of(context).share_link),
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: 'leave',
                                          child: ListTile(
                                            leading:
                                                const Icon(Icons.exit_to_app),
                                            title: Text(
                                                S.of(context).leave_the_board),
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: 'settings',
                                          child: ListTile(
                                            leading: const Icon(Icons.settings),
                                            title: Text(
                                                S.of(context).board_settings),
                                          ),
                                        ),
                                      ]
                                    : [
                                        PopupMenuItem(
                                          value: 'share',
                                          child: ListTile(
                                            leading: const Icon(Icons.link),
                                            title:
                                                Text(S.of(context).share_link),
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: 'leave',
                                          child: ListTile(
                                            leading:
                                                const Icon(Icons.exit_to_app),
                                            title: Text(
                                                S.of(context).leave_the_board),
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: 'settings',
                                          child: ListTile(
                                            leading: const Icon(Icons.settings),
                                            title: Text(
                                                S.of(context).board_settings),
                                          ),
                                        ),
                                      ],
                              ),
                            ],
                          ),
                  ],
                ),
                // SizedBox(height: mediaQuery.height / 90),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: List.generate(
                    currentBoard!.members.length,
                    (index) {
                      return memberWidget(
                        mediaQuery: mediaQuery,
                        member: currentBoard!.members[index],
                      );
                    },
                  ),
                ),
                // SizedBox(height: mediaQuery.height / 50),
                currentBoard!.description.isEmpty
                    ? const SizedBox()
                    : Text(
                        currentBoard!.description,
                        style: const TextStyle(color: Colors.black45),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget memberWidget({required Member member, required Size mediaQuery}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        (member.image.isEmpty || member.image == '')
            ? Container(
                padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.width / 30,
                  vertical: mediaQuery.height / 40,
                ),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueAccent,
                ),
                child: Text(
                  member.firstName[0],
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: mediaQuery.width / 20),
                ),
              )
            : ClipOval(
                child: CachedNetworkImage(
                  imageUrl: member.image,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: mediaQuery.width / 8, // Adjust the size as needed
                      height: mediaQuery.width / 8, // Adjust the size as needed
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                  width: mediaQuery.width / 8, // Adjust the size as needed
                  height: mediaQuery.width / 8, // Adjust the size as needed
                ),
              ),
        if (member.role == 'admin')
          Positioned(
            bottom: 10,
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
                size: mediaQuery.width / 30,
              ),
            ),
          ),
      ],
    );
  }
}
