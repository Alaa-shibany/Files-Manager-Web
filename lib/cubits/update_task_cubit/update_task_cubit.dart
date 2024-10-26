import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/core/server/dio_settings.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/models/task_model.dart';

part 'update_task_state.dart';

class UpdateTaskCubit extends Cubit<UpdateTaskState> {
  UpdateTaskCubit() : super(UpdateTaskInitial());

  Future<void> refreshScreen() async {
    emit(UpdateTaskInitial());
  }

  Future<void> updateTask({
    required BuildContext context,
    required TaskModel taskModel,
  }) async {
    try {
      emit(UpdateTaskLoadingState(loadingMessage: S.of(context).saving));
      String? token = CashNetwork.getCashData(key: 'token');

      final response = await dio().put(
        'tasks/update-task/${taskModel.id}',
        data: {
          'title': taskModel.title,
          'description': taskModel.description,
          'date': taskModel.date,
          'time': taskModel.time,
          'complete': taskModel.completed
        },
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 200) {
        TaskModel newTaskModel = TaskModel.fromJson(response.data['task']);
        taskModel.updatedAt = newTaskModel.updatedAt;
        emit(UpdateTaskSuccessState());
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(UpdateTaskExpiredState());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(UpdateTaskFailedState(errorMessage: e.response!.data['message']));
    } catch (e) {
      Navigator.pop(context);
      print('================ catch exception =================');
      print(e);
      emit(UpdateTaskFailedState(errorMessage: 'Catch exception'));
      print(e);
    }
  }

  Future<void> deleteTask({
    required BuildContext context,
    required TaskModel taskModel,
  }) async {
    try {
      emit(UpdateTaskLoadingState(loadingMessage: S.of(context).delete));
      String? token = CashNetwork.getCashData(key: 'token');

      final response = await dio().delete(
        'tasks/delete-task/${taskModel.id}',
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 200) {
        emit(DeleteTaskSuccessState());
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(UpdateTaskExpiredState());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(UpdateTaskFailedState(errorMessage: e.response!.data['message']));
    } catch (e) {
      Navigator.pop(context);
      print('================ catch exception =================');
      print(e);
      emit(UpdateTaskFailedState(errorMessage: 'Catch exception'));
      print(e);
    }
  }
}
