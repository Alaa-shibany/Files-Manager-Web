import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:dio/dio.dart' as Dio;
import 'package:files_manager/models/file_model.dart';
import 'package:flutter/material.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/core/server/dio_settings.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/interfaces/applications_abstract.dart';

import '../../models/folder_model.dart';

part 'board_add_application_state.dart';

class BoardAddApplicationCubit extends Cubit<BoardAddApplicationState> {
  BoardAddApplicationCubit() : super(BoardAddApplicationInitial());

  Future<void> addApplicationFunction({
    required BuildContext context,
    required String uuid,
    required int appId,
  }) async {
    emit(BoardAddApplicationLoading());
    try {
      String? token = CashNetwork.getCashData(key: 'token');

      final response = await dio().post(
        'board-applications/add-application-in-board/$uuid',
        data: {
          'application_id': appId,
        },
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 200) {
        Application createdApplication;
        if (appId == 1) {
          FileModel todo =
              FileModel.fromJson(response.data['board_application']);
          createdApplication = todo;
        } else {
          FolderModel chat =
              FolderModel.fromJson(response.data['board_application']);
          createdApplication = chat;
        }
        emit(BoardAddApplicationSuccess(addedApplication: createdApplication));
      } else if (response.statusCode == 206) {
        Navigator.pop(context);
        emit(
            BoardAddApplicationFailure(errorMessage: response.data['message']));
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(BoardAddApplicationExpiredToken());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(BoardAddApplicationFailure(
          errorMessage: e.response!.data['message']));
    } catch (e) {
      Navigator.pop(context);
      print('================ catch exception =================');
      print(e);
      emit(BoardAddApplicationFailure(errorMessage: 'Catch exception'));
      print(e);
    }
  }
}
