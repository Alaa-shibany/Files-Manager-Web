import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:files_manager/core/server/dio_settings.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/models/task_model.dart';

import '../../core/functions/apis_error_handler.dart';

part 'user_complete_task_state.dart';

class UserCompleteTaskCubit extends Cubit<UserCompleteTaskState> {
  UserCompleteTaskCubit() : super(UserCompleteTaskInitial());

  Future<void> userUserCompleteTask(
      {required BuildContext context,
      required UserTaskModel userTaskModel,
      required bool value,
      required String taskId}) async {
    try {
      emit(UserCompleteTaskLoadingState());
      String? token = CashNetwork.getCashData(key: 'token');

      final response = await dio().put(
        'tasks/change-complete-specific-user-task/$taskId',
        data: {'user_id': userTaskModel.id, 'completed': value ? 1 : 0},
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 200) {
        userTaskModel.completed = value;
        emit(UserCompleteTaskSuccessState());
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(UserCompleteTaskExpiredState());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(UserCompleteTaskFailedState(
          errorMessage: e.response!.data['message']));
    } catch (e) {
      Navigator.pop(context);
      print('================ catch exception =================');
      print(e);
      emit(UserCompleteTaskFailedState(errorMessage: 'Catch exception'));
      print(e);
    }
  }

  Future<void> userReadStateTask(
      {required BuildContext context,
      required UserTaskModel userTaskModel,
      required bool value,
      required String taskId}) async {
    try {
      emit(UserCompleteTaskLoadingState());
      String? token = CashNetwork.getCashData(key: 'token');

      final response = await dio().put(
        'tasks/change-read-specific-user/$taskId',
        data: {'user_id': userTaskModel.id, 'read': value},
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 200) {
        userTaskModel.read = value;
        emit(UserCompleteTaskSuccessState());
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(UserCompleteTaskExpiredState());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(UserCompleteTaskFailedState(
          errorMessage: e.response!.data['message']));
    } catch (e) {
      Navigator.pop(context);
      print('================ catch exception =================');
      print(e);
      emit(UserCompleteTaskFailedState(errorMessage: 'Catch exception'));
      print(e);
    }
  }
}
