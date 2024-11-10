import 'package:files_manager/cubits/all_boards_cubit/all_boards_cubit.dart';
import 'package:files_manager/cubits/application_cubit/application_cubit.dart';
import 'package:files_manager/cubits/board_cubit/board_cubit.dart';
import 'package:files_manager/cubits/folder/folder_cubit/folder_cubit.dart';
import 'package:files_manager/interfaces/applications_abstract.dart';
import 'package:files_manager/screens/folder_screen/folder_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/functions/statics.dart';
import '../../cubits/move_application_cubit/move_application_cubit.dart';
import '../../screens/move_application_screen/move_application_screen.dart';

class FolderWidget extends StatelessWidget {
  const FolderWidget(
      {super.key,
      required this.mediaQuery,
      required this.allBoardsCubit,
      required this.boardCubit,
      required this.currentApplication,
      required this.applicationCubit});
  final Size mediaQuery;
  final AllBoardsCubit allBoardsCubit;
  final BoardCubit boardCubit;
  final Application currentApplication;
  final ApplicationCubit applicationCubit;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => FolderCubit()),
            ],
            child: FolderScreen(
                boardCubit: boardCubit,
                currentFolder: currentApplication,
                applicationCubit: applicationCubit,
                allBoardsCubit: allBoardsCubit),
          ),
        ));
      },
      child: SizedBox(
        width:
            Statics.isPlatformDesktop ? mediaQuery.width / 3 : mediaQuery.width,
        child: Card(
          color: Colors.white,
          child: ListTile(
            leading: Icon(
              Icons.folder,
              color: Colors.amberAccent,
            ),
            trailing: PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 'settings') {
                } else if (value == 'share') {
                  print('Share');
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => MoveApplicationCubit(
                              allBoardsCubit: allBoardsCubit)
                            ..initState(),
                        )
                      ],
                      child: MoveApplicationScreen(
                          boardCubit: boardCubit,
                          allBoardsCubit: allBoardsCubit,
                          isCopy: false,
                          applicationCubit: applicationCubit,
                          application: currentApplication),
                    ),
                  ));
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'share',
                  child: ListTile(
                    leading: const Icon(Icons.link),
                    title: Text(
                      'Share',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'copy',
                  child: ListTile(
                    leading: const Icon(Icons.copy),
                    title: Text(
                      'Copy',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            title: SizedBox(
              width: Statics.isPlatformDesktop
                  ? mediaQuery.width / 3.5
                  : mediaQuery.width / 1.5,
              child: Text(currentApplication.getApplicationName()),
            ),
            subtitle: Text(
              'Count of file ${currentApplication.getApplicationFilesCount()}',
              style: TextStyle(color: Colors.black26),
            ),
          ),
        ).animate().fade(
              duration: const Duration(milliseconds: 500),
            ),
      ),
    );
  }
}
