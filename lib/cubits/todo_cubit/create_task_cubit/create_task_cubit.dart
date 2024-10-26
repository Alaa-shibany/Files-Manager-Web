import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/core/server/dio_settings.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/models/task_model.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit() : super(CreateTaskInitial());

  Future<void> createTask({
    required BuildContext context,
    required String todoApplicationId,
    required String taskTitle,
  }) async {
    try {
      emit(CreateTaskLoadingState());
      String? token = CashNetwork.getCashData(key: 'token');

      final response = await dio().post(
        'tasks/create-task-in-application/$todoApplicationId',
        data: {'title': taskTitle},
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 201) {
        TaskModel taskModel = TaskModel.fromJson(response.data['task']);
        emit(CreateTaskSuccessState(newTaskModel: taskModel));
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(CreateTaskExpiredState());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(CreateTaskFailedState(errorMessage: e.response!.data['message']));
    } catch (e) {
      Navigator.pop(context);
      print('================ catch exception =================');
      print(e);
      emit(CreateTaskFailedState(errorMessage: 'Catch exception'));
      print(e);
    }
  }

  Future<void> changeTaskState({
    required BuildContext context,
    required bool taskStatus,
    required String taskId,
  }) async {
    try {
      emit(CreateTaskUpdateLoadingState());
      String? token = CashNetwork.getCashData(key: 'token');

      final response = await dio().put(
        'tasks/update-task/$taskId',
        data: {'completed': taskStatus},
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 200) {
        TaskModel taskModel = TaskModel.fromJson(response.data['task']);
        emit(CreateTaskUpdateSuccessState(taskModel: taskModel));
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(CreateTaskExpiredState());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(CreateTaskFailedState(errorMessage: e.response!.data['message']));
    } catch (e) {
      Navigator.pop(context);
      print('================ catch exception =================');
      print(e);
      emit(CreateTaskFailedState(errorMessage: 'Catch exception'));
      print(e);
    }
  }
}
