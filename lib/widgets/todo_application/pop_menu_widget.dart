import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive/hive.dart';
import 'package:files_manager/core/animation/dialogs/dialogs.dart';
import 'package:files_manager/core/animation/dialogs/expired_dialog.dart';
import 'package:files_manager/cubits/all_boards_cubit/all_boards_cubit.dart';
import 'package:files_manager/cubits/application_cubit/application_cubit.dart';
import 'package:files_manager/cubits/board_cubit/board_cubit.dart';
import 'package:files_manager/cubits/chat_cubit/chat_cubit.dart';
import 'package:files_manager/cubits/delete_application_cubit/delete_application_cubit.dart';
import 'package:files_manager/cubits/move_application_cubit/move_application_cubit.dart';
import 'package:files_manager/cubits/todo_cubit/todo_cubit.dart';
import 'package:files_manager/cubits/update_application_cubit/update_application_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/interfaces/applications_abstract.dart';
import 'package:files_manager/models/folder_model.dart';
import 'package:files_manager/models/file_model.dart';
import 'package:files_manager/screens/move_application_screen/move_application_screen.dart';
import 'package:files_manager/screens/todo_application_screen/application_settings_screen.dart';
import 'package:files_manager/theme/color.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/shared/local_network.dart';

class PopMenuWidget extends StatelessWidget {
  const PopMenuWidget(
      {super.key,
      required this.mediaQuery,
      required this.application,
      required this.boardCubit,
      required this.todoCubit,
      required this.chatCubit,
      required this.path,
      required this.applicationCubit,
      required this.allBoardsCubit});
  final Size mediaQuery;
  final Application application;
  final BoardCubit boardCubit;
  final AllBoardsCubit allBoardsCubit;
  final TodoCubit? todoCubit;
  final ChatCubit? chatCubit;
  final ApplicationCubit applicationCubit;
  final String path;

  Future<void> share() async {
    Share.shareUri(Uri(path: path));
  }

  @override
  Widget build(BuildContext context) {
    final deleteApplicationCubit = context.read<DeleteApplicationCubit>();
    return BlocConsumer<DeleteApplicationCubit, DeleteApplicationState>(
      listener: (context, state) {
        if (state is DeleteApplicationLoadingState) {
          loadingDialog(
              context: context,
              mediaQuery: mediaQuery,
              title: state.loadingMessage);
        } else if (state is DeleteApplicationSuccessState) {
          boardCubit.allApplications.removeWhere(
            (element) =>
                element.getApplicationId() == application.getApplicationId(),
          );
          applicationCubit.pagingController.itemList!.removeWhere(
            (element) =>
                element.getApplicationId() == application.getApplicationId(),
          );
          Navigator.pop(context);
          Navigator.pop(context);
          boardCubit.refresh();
        } else if (state is DeleteApplicationFailedState) {
          errorDialog(context: context, text: state.errorMessage);
        } else if (state is DeleteApplicationExpiredState) {
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
        return PopupMenuButton<String>(
          iconColor: AppColors.white,
          onSelected: (value) async {
            if (value == 'settings') {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) =>
                      UpdateApplicationCubit(application: application)
                        ..initState(),
                  child: const ApplicationSettingsScreen(),
                ),
              ))
                  .then(
                (value) async {
                  if (application is FileModel) {
                    print('application is todo');
                    todoCubit!.refresh();
                  } else if (application is FolderModel) {
                    print('application is chat');
                    chatCubit!.refresh();
                  } else {
                    print('------------------------------not found');
                  }
                },
              );
            } else if (value == 'share') {
              print('sharing link');
              share();
            } else if (value == 'copy') {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) =>
                          MoveApplicationCubit(allBoardsCubit: allBoardsCubit)
                            ..initState(),
                    )
                  ],
                  child: MoveApplicationScreen(
                      applicationCubit: applicationCubit,
                      boardCubit: boardCubit,
                      allBoardsCubit: allBoardsCubit,
                      isCopy: true,
                      application: application),
                ),
              ));
            } else if (value == 'move') {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) =>
                          MoveApplicationCubit(allBoardsCubit: allBoardsCubit)
                            ..initState(),
                    )
                  ],
                  child: MoveApplicationScreen(
                      applicationCubit: applicationCubit,
                      boardCubit: boardCubit,
                      allBoardsCubit: allBoardsCubit,
                      isCopy: false,
                      application: application),
                ),
              ));
            } else if (value == 'delete') {
              await deleteApplicationCubit.deleteApplication(
                  context: context, application: application);
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'settings',
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: mediaQuery.width / 90,
                    ),
                    Text(
                      S.of(context).settings,
                      style: const TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              // PopupMenuItem<String>(
              //   value: 'share',
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       const Icon(
              //         Icons.share,
              //         color: Colors.white,
              //       ),
              //       SizedBox(
              //         width: mediaQuery.width / 90,
              //       ),
              //       const Text(
              //         'مشاركة الرابط',
              //         style: TextStyle(
              //           color: Colors.white,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              PopupMenuItem<String>(
                value: 'copy',
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.copy,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: mediaQuery.width / 90,
                    ),
                    Text(
                      S.of(context).copy,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'move',
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.move_down,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: mediaQuery.width / 90,
                    ),
                    Text(
                      S.of(context).move,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: mediaQuery.width / 90,
                    ),
                    Text(
                      S.of(context).delete,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
        );
      },
    );
  }
}
