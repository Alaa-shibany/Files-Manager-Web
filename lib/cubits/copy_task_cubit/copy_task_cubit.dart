import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dio;

import 'package:flutter/material.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/models/task_model.dart';

import '../../core/server/dio_settings.dart';
import '../../core/shared/local_network.dart';

part 'copy_task_state.dart';

class CopyTaskCubit extends Cubit<CopyTaskState> {
  CopyTaskCubit() : super(CopyTaskInitial());

  Future<void> copyTask(
      {required BuildContext context,
      required String taskId,
      required String applicationId}) async {
    try {
      emit(CopyTaskLoadingState());
      String? token = CashNetwork.getCashData(key: 'token');

      final response = await dio().post(
        'tasks/copy-task-in-application/$taskId',
        data: {
          'board_application_id': applicationId,
        },
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 201) {
        TaskModel copiesTask = TaskModel.fromJson(response.data['task']);
        emit(CopyTaskSuccessState(copiesTasks: copiesTask));
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(CopyTaskExpiredState());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(CopyTaskFailedState(errorMessage: e.response!.data['message']));
    } catch (e) {
      Navigator.pop(context);
      print('================ catch exception =================');
      print(e);
      emit(CopyTaskFailedState(errorMessage: 'Catch exception'));
      print(e);
    }
  }
}
