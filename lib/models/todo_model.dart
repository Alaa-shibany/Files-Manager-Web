import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:files_manager/core/functions/color_to_hex.dart';
import 'package:files_manager/cubits/all_boards_cubit/all_boards_cubit.dart';
import 'package:files_manager/cubits/application_cubit/application_cubit.dart';
import 'package:files_manager/cubits/board_cubit/board_cubit.dart';
import 'package:files_manager/cubits/delete_application_cubit/delete_application_cubit.dart';
import 'package:files_manager/cubits/todo_cubit/create_task_cubit/create_task_cubit.dart';
import 'package:files_manager/interfaces/applications_abstract.dart';
import 'package:files_manager/models/application_board.dart';
import 'package:files_manager/models/language_model.dart';
import 'package:files_manager/models/task_model.dart';
import 'package:files_manager/screens/todo_application_screen/todo_application_screen.dart';

import '../cubits/todo_cubit/todo_cubit.dart';

class TodoModel extends Application {
  BoardCubit? boardCubit;

  String langChatApp = 'default';
  List<TaskModel> tasks = [];
  int? applicationColor;
  TodoModel({
    required this.id,
    required this.boardId,
    required this.application,
    required this.color,
    required this.language,
    required this.firstDay,
    required this.title,
    required this.mode,
    required this.showIcon,
    required this.showTitle,
    required this.showDescription,
    required this.createdAt,
    required this.updatedAt,
    // required this.applicationName,
    // required this.boardCubit,
  });

  // String applicationName;
  // final BoardCubit boardCubit;

  int id;
  int boardId;
  ApplicationBoard application;
  String color;
  Language language;
  String? firstDay;
  String title;
  String mode;
  bool showIcon;
  bool showTitle;
  bool showDescription;
  DateTime createdAt;
  DateTime updatedAt;

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      boardId: json['board_id'],
      application: ApplicationBoard.fromJson(json['application']),
      color: json['color'],
      language: Language.fromJson(json['language']),
      firstDay: json['first_day'] ?? '',
      title: json['title'],
      mode: json['mode'],
      showIcon: json['show_icon'],
      showTitle: json['show_title'],
      showDescription: json['show_description'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  @override
  IconData getIcon() {
    return Icons.check_box_outlined;
  }

  @override
  String getApplicationName() {
    return title;
  }

  @override
  String getApplicationAbout() {
    return application.about;
  }

  @override
  int getApplicationSelectedColor() {
    if (applicationColor == null) {
      int index = allColors.indexWhere(
        (element) {
          return colorToHex(element['real']!) == color;
        },
      );
      if (index == -1) {
        allColors.last['real'] = hexToColor(color);
        allColors.last['show'] = hexToColor(color);
        return allColors.length - 1;
      }
      return index;
    }
    return applicationColor!;
  }

  @override
  void updateApplicationTitle(String title) {
    this.title = title;
  }

  @override
  void updateApplicationColor(int colorIndex, String hex) {
    color = hex;
    applicationColor = colorIndex;
  }

  @override
  int getApplicationId() {
    return id;
  }

  @override
  void updateApplicationLanguage(String language) {
    this.language.code = language;
  }

  @override
  String getLanguage() {
    return language.code;
  }

  @override
  void pushToScreen({
    required BuildContext context,
    Application? application,
    required BoardCubit boardCubit,
    required AllBoardsCubit allBoardCubit,
    required ApplicationCubit applicationCubit,
  }) {
    print('todo navigation');
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => TodoCubit(application! as TodoModel)
                ..initState(context: context),
            ),
            BlocProvider(
              create: (context) => CreateTaskCubit(),
            ),
            BlocProvider(
              create: (context) => DeleteApplicationCubit(),
            ),
          ],
          child: TodoApplicationScreen(
            applicationCubit: applicationCubit,
            allBoardsCubit: allBoardCubit,
            boardCubit: boardCubit,
          )),
    ))
        .then(
      (value) async {
        await boardCubit.refresh();
        await allBoardCubit.refresh();
      },
    );
  }
}
