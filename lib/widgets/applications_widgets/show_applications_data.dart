import 'package:files_manager/core/functions/statics.dart';
import 'package:files_manager/widgets/applications_widgets/file_widget.dart';
import 'package:files_manager/widgets/applications_widgets/folder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:files_manager/core/animation/dialogs/dialogs.dart';
import 'package:files_manager/core/animation/dialogs/expired_dialog.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/cubits/all_boards_cubit/all_boards_cubit.dart';
import 'package:files_manager/cubits/application_cubit/application_cubit.dart';
import 'package:files_manager/cubits/board_cubit/board_cubit.dart';

class ShowApplicationsData extends StatelessWidget {
  const ShowApplicationsData({super.key, required this.allBoardsCubit});
  final AllBoardsCubit allBoardsCubit;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final applicationCubit = context.read<ApplicationCubit>();
    final boardCubit = context.read<BoardCubit>();

    return Localizations.override(
      context: context,
      child: BlocConsumer<ApplicationCubit, ApplicationState>(
        listener: (context, state) {
          if (state is GetAllApplicationsInBoardFailure) {
            errorDialog(context: context, text: state.errorMessage);
          } else if (state is AllBoardsExpiredState) {
            showExpiredDialog(
              context: context,
              onConfirmBtnTap: () async {
                await CashNetwork.clearCash();
                await Hive.box('main').clear();
                Phoenix.rebirth(context);
              },
            );
          } else if (state is AllBoardsNoInternetState) {
            internetDialog(context: context, mediaQuery: mediaQuery);
          } else if (state is GetAllApplicationsInBoardSuccess) {
            final isLastPage = state.isReachMax;
            print('Is the last page => $isLastPage');
            // Use set to avoid duplicating items.
            final existingItems =
                applicationCubit.pagingController.itemList ?? [];
            // Check for new items and ignore duplicates
            final newItems = state.newBoardsApp
                .where((app) => !existingItems.any((existingApp) =>
                    existingApp.getApplicationId() == app.getApplicationId()))
                .toList();
            if (isLastPage) {
              applicationCubit.pagingController.appendLastPage(newItems);
            } else {
              if (applicationCubit.pagingController.itemList == null) {
                applicationCubit.pagingController.appendPage(newItems, 2);
                return;
              }
              final nextPageKey =
                  (applicationCubit.pagingController.itemList!.length ~/
                          applicationCubit.pageSize) +
                      1;
              print('The next page is =>$nextPageKey');
              applicationCubit.pagingController
                  .appendPage(newItems, nextPageKey);
            }
          }
        },
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              applicationCubit.refreshData();
            },
            child: Statics.isPlatformDesktop
                ? Wrap(
                    children: List.generate(
                      boardCubit.currentBoard.allFiles.length,
                      (index) {
                        return boardCubit.currentBoard.allFiles[index]
                                .isFolder()
                            ? FolderWidget(
                                mediaQuery: mediaQuery,
                                allBoardsCubit: allBoardsCubit,
                                boardCubit: boardCubit,
                                index: index,
                                applicationCubit: applicationCubit)
                            : FileWidget(
                                mediaQuery: mediaQuery,
                                allBoardsCubit: allBoardsCubit,
                                boardCubit: boardCubit,
                                index: index,
                                applicationCubit: applicationCubit);
                      },
                    ),
                  )
                : ListView(
                    children: List.generate(
                      boardCubit.currentBoard.allFiles.length,
                      (index) {
                        return boardCubit.currentBoard.allFiles[index]
                                .isFolder()
                            ? FolderWidget(
                                mediaQuery: mediaQuery,
                                allBoardsCubit: allBoardsCubit,
                                boardCubit: boardCubit,
                                index: index,
                                applicationCubit: applicationCubit)
                            : FileWidget(
                                mediaQuery: mediaQuery,
                                allBoardsCubit: allBoardsCubit,
                                boardCubit: boardCubit,
                                index: index,
                                applicationCubit: applicationCubit);
                      },
                    ),
                  ),
          );
        },
      ),
    );
  }
}
