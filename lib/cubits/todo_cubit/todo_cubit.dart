import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/models/task_model.dart';
import 'package:files_manager/models/file_model.dart';

import '../../core/server/dio_settings.dart';
import '../../core/shared/connect.dart';
import '../../core/shared/local_network.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit(this.todoModel) : super(TodoInitial());
  FileModel todoModel;

  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskController = TextEditingController();
  FocusNode newTaskFocusNode = FocusNode();
  final int pageSize = 10;
  PagingController<int, TaskModel> pagingController =
      PagingController(firstPageKey: 1);

  Future<void> initState({required BuildContext context}) async {
    taskTitleController = TextEditingController(text: todoModel.title);
    pagingController.addPageRequestListener((pageKey) {
      getAllTasks(
        context: context,
        pageKey: pageKey,
      );
    });
    emit(TodoInitial());
  }

  Future<void> refreshData() async {
    todoModel.tasks.clear();
    pagingController.itemList!.clear();
    pagingController.refresh();
  }

  Future<void> sortList({required BuildContext context}) async {
    pagingController.itemList!.sort((a, b) {
      DateTime updatedAtA = DateTime.parse(a.updatedAt);
      DateTime updatedAtB = DateTime.parse(b.updatedAt);
      return updatedAtB.compareTo(updatedAtA); // Sort descending
    });
    emit(TodoInitial());
  }

  Future<void> getAllTasks({
    required BuildContext context,
    required int pageKey,
  }) async {
    try {
      emit(TodoLoadingState());
      String? token = CashNetwork.getCashData(key: 'token');
      final response = await dio().get(
        'tasks/tasks-in-application/${todoModel.id}',
        queryParameters: {'page': pageKey},
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 200) {
        final List jsonData = await response.data['tasks']['data'] as List;
        final List<TaskModel> newTasks =
            jsonData.map((e) => TaskModel.fromJson(e)).toList();
        print('we will emit success');
        FileModel todoApp =
            FileModel.fromJson(response.data['board_application']);
        todoModel = todoApp;
        todoModel.tasks.addAll(newTasks);
        emit(TodoSuccessState(
            newTasks: newTasks,
            isReachMax: response.data['tasks']['links']['next'] == null));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        await checkInternet()
            ? emit(TodoServerState())
            : emit(TodoNoInternetState());
        print('Connection Error.');
        return;
      }
      errorHandlerWithoutInternet(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(TodoExpiredState());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(TodoFailedState(errorMessage: e.response!.data['message']));
    } catch (e) {
      print('================ catch exception =================');
      print(e);
      emit(TodoFailedState(errorMessage: 'Catch exception'));
      print(e);
    }
  }

  Future<void> editTaskName() async {
    todoModel.title = taskTitleController.text;
    print('new application name => ${todoModel.title}');
    emit(TodoEditData());
  }

  Future<void> refresh() async {
    taskTitleController = TextEditingController(text: todoModel.title);
    emit(TodoEditData());
  }

  Future<void> selectApplicationColor(int newColorIndex) async {
    todoModel.applicationColor = newColorIndex;
    print('new application name => ${todoModel.applicationColor}');
    emit(TodoEditData());
  }

  Future<void> changeTaskState(int taskIndex) async {
    if (todoModel.tasks[taskIndex].completed) {
      todoModel.tasks[taskIndex].completed = false;
    } else {
      todoModel.tasks[taskIndex].completed = true;
    }

    print('task state is  => ${todoModel.tasks[taskIndex].completed}');
    emit(TodoEditData());
  }

  int userInTaskIndex = -1;

  bool isUserInTask(TaskModel taskModel) {
    String? userId = CashNetwork.getCashData(key: 'id');
    userInTaskIndex = taskModel.users
        .indexWhere((element) => element.id.toString() == userId);
    return userInTaskIndex != -1;
  }

  Future<void> addTask() async {
    if (taskController.text.isEmpty) {
      print('empty field');
      return;
    }
    print('The tasks length before adding is  => ${todoModel.tasks.length}');
    // todoModel.tasks.add(TaskModel(
    //     taskName: taskController.text,
    //     createDate: DateTime.now().toString(),
    //     link: taskController.text));
    print('The tasks length after adding is  => ${todoModel.tasks.length}');
    taskController = TextEditingController();
    emit(TodoEditData());
  }
}
