import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:files_manager/cubits/all_boards_cubit/all_boards_cubit.dart';
import 'package:files_manager/cubits/application_cubit/application_cubit.dart';
import 'package:files_manager/cubits/board_add_application_cubit/board_add_application_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/models/board_model.dart';
import 'package:files_manager/screens/all_applications_screen/all_applications_screen.dart';
import 'package:files_manager/screens/home/board_settings_screen.dart';

import '../../core/functions/color_to_hex.dart';
import '../../cubits/board_cubit/board_cubit.dart';
import '../../cubits/board_settings_cubit/board_settings_cubit.dart';
import '../../widgets/applications_widgets/show_applications_data.dart';

class SubBoardScreen extends StatelessWidget {
  const SubBoardScreen(
      {super.key, required this.allBoardsCubit, required this.board});
  final Board board;
  final AllBoardsCubit allBoardsCubit;

  @override
  Widget build(BuildContext context) {
    final boardCubit = context.read<BoardCubit>();
    final applicationCubit = context.read<ApplicationCubit>();

    // final mediaQuery = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 1,
      child: Scaffold(
        backgroundColor: hexToColor(board.color),
        appBar: AppBar(
          title: Text(
            board.title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => BoardAddApplicationCubit(),
                        ),
                      ],
                      child: AllApplicationsScreen(
                        applicationCubit: applicationCubit,
                        boardCubit: boardCubit,
                        allBoardsCubit: allBoardsCubit,
                        uuid: boardCubit.currentBoard.uuid,
                      ),
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.sort),
              onPressed: () {
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) =>
                              BoardSettingsCubit(currentBoard: board)
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
                  (d) async {
                    boardCubit.refresh();
                  },
                );
              },
            ),
          ],
          bottom: TabBar(
            onTap: (int index) async {},
            tabs: [
              Tab(text: S.of(context).applications),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            //Applications Data
            ShowApplicationsData(
              allBoardsCubit: allBoardsCubit,
            ),
            //Subpanels Data
          ],
        ),
      ),
    );
  }
}
