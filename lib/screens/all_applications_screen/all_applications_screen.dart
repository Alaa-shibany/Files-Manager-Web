import 'package:files_manager/models/file_model.dart';
import 'package:files_manager/models/folder_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:files_manager/core/animation/dialogs/dialogs.dart';
import 'package:files_manager/cubits/all_boards_cubit/all_boards_cubit.dart';
import 'package:files_manager/cubits/application_cubit/application_cubit.dart';
import 'package:files_manager/cubits/board_add_application_cubit/board_add_application_cubit.dart';
import 'package:files_manager/cubits/board_cubit/board_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/theme/color.dart';
import 'package:files_manager/widgets/all_applications_screen/application_widget.dart';
import 'package:file_picker/file_picker.dart';
import '../../core/functions/statics.dart';

class AllApplicationsScreen extends StatelessWidget {
  const AllApplicationsScreen({
    super.key,
    required this.boardCubit,
    required this.uuid,
    required this.allBoardsCubit,
    required this.applicationCubit,
  });
  final BoardCubit boardCubit;
  final String uuid;
  final AllBoardsCubit allBoardsCubit;
  final ApplicationCubit applicationCubit;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    // final boardAddApplicationCubit = context.read<BoardAddApplicationCubit>();
    return Scaffold(
      backgroundColor: AppColors.dark,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.cancel_outlined,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        height: mediaQuery.height,
        width: mediaQuery.width,
        padding: EdgeInsets.symmetric(
          horizontal: mediaQuery.width / 30,
          vertical: mediaQuery.height / 15,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(
            S.of(context).applications,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: Statics.isPlatformDesktop
                  ? mediaQuery.width / 55
                  : mediaQuery.width / 18,
            ),
          ),
          Text(
            S.of(context).click_on_the_app_to_add_it_to_the_board,
            style: TextStyle(
              color: Colors.white30,
              fontSize: Statics.isPlatformDesktop
                  ? mediaQuery.width / 75
                  : mediaQuery.width / 25,
            ),
          ),
          SizedBox(
            height: mediaQuery.height / 80,
          ),
          BlocConsumer<BoardAddApplicationCubit, BoardAddApplicationState>(
            listener: (context, state) {
              if (state is BoardAddApplicationLoading) {
                loadingDialog(context: context, mediaQuery: mediaQuery);
              } else if (state is BoardAddApplicationSuccess) {
                Navigator.of(context).pop();

                applicationCubit.pagingController
                    .appendLastPage([state.addedApplication]);
                Navigator.of(context).pop();
              } else if (state is BoardAddApplicationFailure) {
                errorDialog(context: context, text: state.errorMessage);
              }
            },
            builder: (context, state) {
              return Wrap(
                alignment: WrapAlignment.end,
                children: [
                  ApplicationWidget(
                    mediaQuery: mediaQuery,
                    context: context,
                    asset: 'assets/images/todo-hover.jpg',
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();

                      if (result != null) {
                        boardCubit.currentBoard.allFiles.add(FileModel(
                            id: boardCubit.currentBoard.allFiles.isEmpty
                                ? 1
                                : boardCubit.currentBoard.allFiles.last
                                        .getApplicationId() +
                                    1,
                            boardId: boardCubit.currentBoard.id,
                            title: 'New file',
                            mode: 'free',
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now()));
                        await boardCubit.refresh();
                        await allBoardsCubit.refresh();
                        Navigator.pop(context);
                      } else {
                        // User canceled the picker
                      }
                    },
                    title: 'New File',
                  ),
                  ApplicationWidget(
                      mediaQuery: mediaQuery,
                      context: context,
                      asset: 'assets/images/chat-hover.jpg',
                      onTap: () async {
                        boardCubit.currentBoard.allFiles.add(FolderModel(
                            id: boardCubit.currentBoard.allFiles.isEmpty
                                ? 1
                                : boardCubit.currentBoard.allFiles.last
                                        .getApplicationId() +
                                    1,
                            boardId: boardCubit.currentBoard.id,
                            allFiles: [],
                            title: 'New folder',
                            mode: 'free',
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now()));
                        await boardCubit.refresh();
                        await allBoardsCubit.refresh();
                        Navigator.pop(context);
                      },
                      title: 'New Folder'),
                ],
              );
            },
          )
        ]),
      ),
    );
  }
}
