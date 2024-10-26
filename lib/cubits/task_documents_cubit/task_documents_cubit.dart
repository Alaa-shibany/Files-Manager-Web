import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/core/server/dio_settings.dart';
import 'package:files_manager/core/shared/connect.dart';
import 'package:files_manager/models/document_model.dart';

import '../../core/shared/local_network.dart';

part 'task_documents_state.dart';

class TaskDocumentsCubit extends Cubit<TaskDocumentsState> {
  TaskDocumentsCubit() : super(TaskDocumentsInitial());
  List<DocumentModel> allDocuments = [];

  Future<void> refresh() async {
    emit(TaskDocumentsSuccessState());
  }

  Future<void> getAllDocuments(
      {required BuildContext context, required String taskId}) async {
    try {
      emit(TaskDocumentsLoadingState());
      String? token = CashNetwork.getCashData(key: 'token');
      final response = await dio().get(
        'tasks/get-task-attachments/$taskId',
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 200) {
        final List jsonData = await response.data['media'] as List;
        allDocuments = jsonData.map((e) => DocumentModel.fromJson(e)).toList();
        print('we will emit success');
        emit(TaskDocumentsSuccessState());
      }
      if (response.statusCode == 204) {
        emit(TaskDocumentsSuccessState());
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        await checkInternet()
            ? emit(TaskDocumentsServerState())
            : emit(TaskDocumentsInternetState());
        print('Connection Error.');
        return;
      }
      errorHandlerWithoutInternet(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(TaskDocumentsExpiredState());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(TaskDocumentsFailedState(errorMessage: e.response!.data['message']));
    } catch (e) {
      print('================ catch exception =================');
      print(e);
      emit(TaskDocumentsFailedState(errorMessage: 'Catch exception'));
      print(e);
    }
  }
}
