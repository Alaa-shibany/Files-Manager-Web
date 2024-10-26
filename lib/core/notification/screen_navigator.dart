import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:files_manager/interfaces/applications_abstract.dart';
import 'package:files_manager/models/board_model.dart';

import '../../cubits/add_board_cubit/add_board_cubit.dart';
import '../../cubits/all_boards_cubit/all_boards_cubit.dart';
import '../../cubits/application_cubit/application_cubit.dart';
import '../../cubits/board_cubit/board_cubit.dart';
import '../../cubits/delete_application_cubit/delete_application_cubit.dart';
import '../../cubits/leave_from_board_cubit/leave_from_board_cubit.dart';
import '../../cubits/todo_cubit/create_task_cubit/create_task_cubit.dart';
import '../../cubits/todo_cubit/todo_cubit.dart';
import '../../main.dart';
import '../../models/todo_model.dart';
import '../../screens/add_board_screen/add_board_screen.dart';
import '../../screens/todo_application_screen/todo_application_screen.dart';

typedef ScreenBuilder = MaterialPageRoute Function(
  RemoteMessage message,
);

class ScreenNavigator {
  static final Map<String, ScreenBuilder> _screenMap = {
    '1': (
      message,
    ) =>
        MaterialPageRoute(builder: (context) {
          final currentBoard = Board.fromJson(message.data['currentBoard']);
          final allBoardsCubit =
              BlocProvider.of<AllBoardsCubit>(navigatorKey.currentContext!);
          return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => LeaveFromBoardCubit(),
                ),
                BlocProvider(
                  create: (context) => AddBoardCubit(),
                ),
                BlocProvider(
                  create: (context) => BoardCubit(currentBoard: currentBoard)
                    ..initState(
                      context: context,
                      uuid: currentBoard.uuid,
                    ),
                ),
                BlocProvider(
                  create: (context) => ApplicationCubit()
                    ..initState(
                      context: context,
                      uuid: currentBoard.uuid,
                    ),
                ),
              ],
              child: AddBoardScreen(
                allBoardsCubit: allBoardsCubit, // Injected Cubit
                uuid: currentBoard.uuid,
              ));
        }),

    // Add more screen mappings as needed
    '2': (
      message,
    ) =>
        MaterialPageRoute(
          builder: (context) {
            late Application currentApplication;
            TodoModel todoModel =
                TodoModel.fromJson(message.data['application']);
            currentApplication = todoModel;
            final currentBoard = Board.fromJson(message.data['currentBoard']);
            final allBoardsCubit =
                BlocProvider.of<AllBoardsCubit>(navigatorKey.currentContext!);
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      TodoCubit(currentApplication as TodoModel)
                        ..initState(context: context),
                ),
                BlocProvider(
                  create: (context) => CreateTaskCubit(),
                ),
                BlocProvider(
                  create: (context) => DeleteApplicationCubit(),
                ),
                BlocProvider(
                  create: (context) => ApplicationCubit()
                    ..initState(context: context, uuid: currentBoard.uuid),
                ),
                BlocProvider(
                  create: (context) => BoardCubit(currentBoard: currentBoard)
                    ..initState(
                      context: context,
                      uuid: currentBoard.uuid,
                    ),
                ),
              ],
              child: TodoApplicationScreen(
                applicationCubit: context.read<ApplicationCubit>(),
                allBoardsCubit: allBoardsCubit,
                boardCubit: context.read<BoardCubit>(),
              ),
            );
          },
        ),
  };

  static void navigateToScreen(
    String key,
    RemoteMessage message,
  ) {
    final routeBuilder = _screenMap[key];
    if (routeBuilder != null) {
      navigatorKey.currentState!.push(routeBuilder(
        message,
      ));
    } else {
      print('Unknown screen key: $key');
    }
  }

  // Dynamically register screens
  static void registerScreen(String key, ScreenBuilder screenBuilder) {
    _screenMap[key] = screenBuilder;
  }
}
