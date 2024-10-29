import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:dio/dio.dart' as Dio;
import 'package:files_manager/models/folder_model.dart';
import 'package:files_manager/models/file_model.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/core/server/dio_settings.dart';
import 'package:files_manager/core/shared/connect.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/interfaces/applications_abstract.dart';

part 'application_state.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit() : super(ApplicationInitial());
  final int pageSize = 10;
  PagingController<int, Application> pagingController =
      PagingController(firstPageKey: 1);
  final List<Application> newBoardsApp = [];
  Future<void> initState({
    required BuildContext context,
    required String uuid,
  }) async {
    pagingController.addPageRequestListener(
      (pageKey) async {
        getApplicationsInBoards(context: context, uuid: uuid, pageKey: pageKey);
      },
    );
    emit(ApplicationInitial());
  }

  Future<void> refresh() async {
    emit(ApplicationInitial());
  }

  Future<void> refreshData() async {
    newBoardsApp.clear();
    pagingController.itemList!.clear();
    pagingController.refresh();
  }

  Future<void> getApplicationsInBoards({
    required BuildContext context,
    required String uuid,
    required int pageKey,
  }) async {
    try {
      emit(GetAllApplicationsInBoardLoading());
      if (pageKey == 1) {
        newBoardsApp.clear();
      }
      String? token = CashNetwork.getCashData(key: 'token');
      print('The page we will get is => $pageKey');
      final response = await dio().get(
        'board-applications/get-applications-in-board/$uuid',
        queryParameters: {'page': pageKey},
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 200) {
        final List jsonData =
            await response.data['board_applications']['data'] as List;

        for (var i = 0; i < jsonData.length; i++) {
          if (jsonData[i]['application']['id'] == 1) {
            FileModel todoModel = FileModel.fromJson(jsonData[i]);
            newBoardsApp.add(todoModel);
          } else if (jsonData[i]['application']['id'] == 2) {
            FolderModel chatModel = FolderModel.fromJson(jsonData[i]);
            newBoardsApp.add(chatModel);
          }
        }

        print('we will emit success');
        emit(GetAllApplicationsInBoardSuccess(
            newBoardsApp: newBoardsApp,
            isReachMax:
                response.data['board_applications']['links']['next'] == null));
      }
      if (response.statusCode == 204) {
        emit(GetAllApplicationsInBoardSuccess(
            newBoardsApp: const [], isReachMax: false));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        await checkInternet()
            ? emit(GetAllApplicationsInBoardServerError())
            : emit(GetAllApplicationsInBoardNoInternet());
        print('Connection Error.');
        return;
      }
      errorHandlerWithoutInternet(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(GetAllApplicationsInBoardExpiredToken());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(GetAllApplicationsInBoardFailure(
          errorMessage: e.response!.data['message']));
    } catch (e) {
      print('================ catch exception =================');
      print(e);
      emit(GetAllApplicationsInBoardFailure(errorMessage: 'Catch exception'));
      print(e);
    }
  }
}
