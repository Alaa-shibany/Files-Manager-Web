import 'package:flutter/material.dart';
import 'package:files_manager/cubits/all_boards_cubit/all_boards_cubit.dart';
import 'package:files_manager/cubits/application_cubit/application_cubit.dart';
import 'package:files_manager/cubits/board_cubit/board_cubit.dart';
import 'package:files_manager/interfaces/applications_abstract.dart';

class NotesModel extends Application {
  String applicationName;
  final BoardCubit boardCubit;

  NotesModel({required this.applicationName, required this.boardCubit});
  @override
  IconData getIcon() {
    return Icons.note_alt_rounded;
  }

  @override
  String getApplicationName() {
    return applicationName;
  }

  @override
  void pushToScreen({
    required BuildContext context,
    Application? application,
    required BoardCubit boardCubit,
    required AllBoardsCubit allBoardCubit,
    required ApplicationCubit applicationCubit,
  }) {
    print('Notes navigation');
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => MultiBlocProvider(
    //       providers: [
    //         BlocProvider(
    //           create: (context) =>
    //               NotesCubit(application! as NotesModel)..initState(),
    //         ),
    //       ],
    //       child: NotesApplicationScreen(
    //         boardCubit: boardCubit,
    //       )),
    // ));
  }
}
