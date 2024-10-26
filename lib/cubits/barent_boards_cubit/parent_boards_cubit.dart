import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/core/server/dio_settings.dart';
import 'package:files_manager/core/shared/connect.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/models/board_model.dart';

part 'parent_boards_state.dart';

class ParentBoardsCubit extends Cubit<ParentBoardsState> {
  ParentBoardsCubit() : super(ParentBoardsInitial());

  List<Board> allParentBoards = [];

  late int selectedBoard;

  final int pageSize = 10;
  PagingController<int, Board> pagingController =
      PagingController(firstPageKey: 1);

  Future<void> initState({
    required BuildContext context,
  }) async {
    pagingController.addPageRequestListener((pageKey) {
      getAllParentBoards(
        context: context,
        pageKey: pageKey,
      );
    });
  }

  Future<void> selectBoard(int newId) async {
    selectedBoard = newId;
    emit(ParentBoardsInitial());
  }

  Future<void> getAllParentBoards({
    required BuildContext context,
    required int pageKey,
  }) async {
    try {
      emit(ParentBoardsLoadingState());
      String? token = CashNetwork.getCashData(key: 'token');
      print('The page we will get is => $pageKey');
      final response = await dio().get(
        'boards/get-parent-boards',
        queryParameters: {'page': pageKey},
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 200) {
        final List jsonData = await response.data['boards']['data'] as List;
        final List<Board> newBoards =
            jsonData.map((e) => Board.fromJson(e)).toList();
        print('we will emit success');
        allParentBoards.addAll(newBoards);
        if (pageKey == 1) {
          selectedBoard = allParentBoards.first.id;
        }
        emit(ParentBoardsSuccessState(
            newBoards: newBoards,
            isReachMax: response.data['boards']['links']['next'] == null));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        await checkInternet()
            ? emit(ParentBoardsServerState())
            : emit(ParentBoardsNoInternetState());
        print('Connection Error.');
        return;
      }
      errorHandlerWithoutInternet(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(ParentBoardsExpiredState());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(ParentBoardsFailedState(errorMessage: e.response!.data['message']));
    } catch (e) {
      print('================ catch exception =================');
      print(e);
      emit(ParentBoardsFailedState(errorMessage: 'Catch exception'));
      print(e);
    }
  }
}
