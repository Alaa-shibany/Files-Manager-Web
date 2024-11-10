import 'package:files_manager/cubits/all_boards_cubit/all_boards_cubit.dart';
import 'package:files_manager/cubits/application_cubit/application_cubit.dart';
import 'package:files_manager/cubits/folder/folder_cubit/folder_cubit.dart';
import 'package:files_manager/interfaces/applications_abstract.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/functions/color_to_hex.dart';
import '../../core/functions/statics.dart';
import '../../cubits/board_cubit/board_cubit.dart';
import '../../generated/l10n.dart';
import '../../widgets/applications_widgets/file_widget.dart';
import '../../widgets/applications_widgets/folder_widget.dart';
import '../../widgets/custom_text_fields/custom_text_fields.dart';

class FolderScreen extends StatelessWidget {
  const FolderScreen(
      {super.key,
      required this.boardCubit,
      required this.currentFolder,
      required this.applicationCubit,
      required this.allBoardsCubit});
  final BoardCubit boardCubit;
  final ApplicationCubit applicationCubit;
  final AllBoardsCubit allBoardsCubit;
  final Application currentFolder;

  @override
  Widget build(BuildContext context) {
    final folderCubit = context.read<FolderCubit>();
    final mediaQuery = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: BlocConsumer<FolderCubit, FolderState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Localizations.override(
            locale: Locale('en'),
            context: context,
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                backgroundColor: hexToColor(boardCubit.currentBoard.color),
                appBar: AppBar(
                  title: CustomTextFields(
                    textAlign: TextAlign.center,
                    styleInput: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Statics.isPlatformDesktop
                            ? mediaQuery.width / 60
                            : mediaQuery.width / 25),
                    controller: TextEditingController(
                        text: currentFolder.getApplicationName()),
                    onChanged: (p0) async {
                      currentFolder.updateApplicationTitle(p0);
                      allBoardsCubit.refresh();
                      boardCubit.refresh();
                    },
                  ),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      tooltip: S.of(context).add_application,
                      icon: const Icon(Icons.add),
                      onPressed: () async {},
                    ),
                  ],
                ),
                body: folderCubit.allFiles.isEmpty
                    ? SizedBox(
                        width: mediaQuery.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('assets/images/folder.png'),
                              width: Statics.isPlatformDesktop
                                  ? mediaQuery.width / 30
                                  : mediaQuery.width / 10,
                            ),
                            SizedBox(
                              height: mediaQuery.height / 90,
                            ),
                            Text(
                              'This folder is empty',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      )
                    : TabBarView(
                        children: [
                          //Applications Data
                          RefreshIndicator(
                            onRefresh: () async {},
                            child: Statics.isPlatformDesktop
                                ? Wrap(
                                    children: List.generate(
                                      folderCubit.allFiles.length,
                                      (index) {
                                        return folderCubit.allFiles[index]
                                                .isFolder()
                                            ? FolderWidget(
                                                mediaQuery: mediaQuery,
                                                allBoardsCubit: allBoardsCubit,
                                                boardCubit: boardCubit,
                                                currentApplication:
                                                    folderCubit.allFiles[index],
                                                applicationCubit:
                                                    applicationCubit)
                                            : FileWidget(
                                                mediaQuery: mediaQuery,
                                                allBoardsCubit: allBoardsCubit,
                                                boardCubit: boardCubit,
                                                index: index,
                                                applicationCubit:
                                                    applicationCubit);
                                      },
                                    ),
                                  )
                                : ListView(
                                    children: List.generate(
                                      folderCubit.allFiles.length,
                                      (index) {
                                        return folderCubit.allFiles[index]
                                                .isFolder()
                                            ? FolderWidget(
                                                mediaQuery: mediaQuery,
                                                allBoardsCubit: allBoardsCubit,
                                                boardCubit: boardCubit,
                                                currentApplication:
                                                    folderCubit.allFiles[index],
                                                applicationCubit:
                                                    applicationCubit)
                                            : FileWidget(
                                                mediaQuery: mediaQuery,
                                                allBoardsCubit: allBoardsCubit,
                                                boardCubit: boardCubit,
                                                index: index,
                                                applicationCubit:
                                                    applicationCubit);
                                      },
                                    ),
                                  ),
                          ),
                        ],
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
