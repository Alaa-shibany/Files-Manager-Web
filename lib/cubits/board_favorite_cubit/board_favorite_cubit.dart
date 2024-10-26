import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/core/server/dio_settings.dart';
import 'package:files_manager/core/shared/connect.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/models/board_model.dart';

part 'board_favorite_state.dart';

class BoardFavoriteCubit extends Cubit<BoardFavoriteState> {
  BoardFavoriteCubit() : super(BoardFavoriteInitial());
  List<Board> favBoards = [];
  PagingController<int, Board> pagingController =
      PagingController(firstPageKey: 1);
  final int pageSize = 10;
  int? hoveredIndex;
  bool isMove = false;
  int? indexMoveTo;
  List<Board>? _originalItemList; // Backup of the original item list

  Future<void> initState({
    required BuildContext context,
  }) async {
    pagingController.addPageRequestListener((pageKey) {
      getAllFavoriteBoards(
        context: context,
        pageKey: pageKey,
      );
    });
  }

  Future<void> updateItemOrder(int index) async {
    isMove = false;
    hoveredIndex = null;
    emit(BoardFavoriteInitial());
  }

  Future<void> startDragMode(int index) async {
    isMove = true;
    hoveredIndex = index;
    emit(BoardFavoriteInitial());
  }

  Future<void> updateOnHoverItemOrder(
      {required int index,
      required int data,
      required BuildContext context,
      required Board movedBoard}) async {
    // hoveredIndex = data;
    print('hover index => $hoveredIndex');
    print('the index is => $index');
    print('the data is => $data');
    Board tempBoard = pagingController.itemList![index];
    pagingController.itemList![index] = pagingController.itemList![data];
    pagingController.itemList![data] = tempBoard;
    isMove = false;
    emit(BoardFavoriteInitial());
    await dataToSend(context);
  }

  void resetItemOrder() {
    // Restore the original list if drag is canceled
    if (_originalItemList != null) {
      pagingController.itemList = List<Board>.from(_originalItemList!);
      _originalItemList = null;
      emit(BoardFavoriteInitial());
    }
  }

  Future<void> dataToSend(BuildContext context) async {
    DateTime currentTime = DateTime.now();
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss', 'en');
    final List<Map<String, dynamic>> listToSend = [];
    for (int i = 0; i < pagingController.itemList!.length; i++) {
      listToSend.add({
        'board_id': pagingController.itemList![i].id,
        'created_at':
            dateFormat.format(currentTime.subtract(Duration(seconds: i))),
      });
    }
    print('the data to send is =>$listToSend');
    await changeListFavOrder(context: context, data: listToSend);
  }

  Future<void> changeListFavOrder({
    required List<Map<String, dynamic>> data,
    required BuildContext context,
  }) async {
    emit(ChangeOrderFavoriteLoading());
    try {
      String? token = CashNetwork.getCashData(key: 'token');

      final response = await dio().get(
        'favorites/get-favorite-boards',
        data: {
          'favorite_boards': data,
        },
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        emit(ChangeOrderFavoriteSuccess());
      }
    } on Dio.DioException catch (e) {
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(AddBoardFavoriteExpiredToken());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(
          ChangeOrderFavoriteFailed(errorMessage: e.response!.data['message']));
    } catch (e) {
      Navigator.pop(context);
      print('================ catch exception =================');
      print(e);
      emit(ChangeOrderFavoriteFailed(errorMessage: 'Catch exception'));
      print(e);
    }
  }

  //Add Favorite Function
  Future<void> addBoardToFavorite({
    required BuildContext context,
    required int boardId,
  }) async {
    emit(AddBoardFavoriteLoading());
    try {
      String? token = CashNetwork.getCashData(key: 'token');

      final response = await dio().post(
        'favorites/add-to-favorite',
        data: {
          'board_id': boardId,
        },
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        emit(AddBoardFavoriteSuccess());
      }
    } on Dio.DioException catch (e) {
      errorHandler(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(AddBoardFavoriteExpiredToken());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(AddBoardFavoriteFailure(errorMessage: e.response!.data['message']));
    } catch (e) {
      print('================ catch exception =================');
      print(e);
      emit(AddBoardFavoriteFailure(errorMessage: 'Catch exception'));
      print(e);
    }
  }

  //Remove From Favorite
  Future<void> removeBoardFavorite({
    required BuildContext context,
    required int boardId,
  }) async {
    emit(RemoveBoardFavoriteLoading());
    try {
      String? token = CashNetwork.getCashData(key: 'token');
      print('The  token is => $token');
      final response = await dio().delete(
        'favorites/remove-from-favorite',
        data: {'board_id': boardId},
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print(response.data);
      favBoards.removeWhere((board) => board.id == boardId);
      pagingController.itemList?.removeWhere((board) => board.id == boardId);
      pagingController.notifyListeners();
      emit(RemoveBoardFavoriteSuccess());
    } on DioException catch (e) {
      print(e.response!.statusCode);
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      print('==============dio exception =================');
    } catch (e) {
      print('===========catch exception ====================');
      emit(RemoveBoardFavoriteFailure(errorMessage: e.toString()));
    }
  }

//Get Favorite Items Function

  Future<void> getAllFavoriteBoards({
    required BuildContext context,
    required int pageKey,
  }) async {
    try {
      emit(GetBoardFavoriteLoading());
      String? token = CashNetwork.getCashData(key: 'token');
      print('The page we will get is => $pageKey');
      final response = await dio().get(
        'favorites/get-favorite-boards',
        queryParameters: {'page': pageKey},
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 200) {
        final List jsonData =
            await response.data['favorite_boards']['data'] as List;
        final List<Board> newFavoriteBoards =
            jsonData.map((e) => Board.fromJson(e)).toList();

        if (pageKey == 1) {
          favBoards.clear();
        }
        print('Length is');
        print(newFavoriteBoards.length);
        favBoards.addAll(newFavoriteBoards);

        print('we will emit success');
        emit(GetBoardFavoriteSuccess(
          newBoards: newFavoriteBoards,
          isReachMax: response.data['favorite_boards']['links']['next'] == null,
        ));
      }
      if (response.statusCode == 204) {
        emit(GetBoardFavoriteSuccess(newBoards: favBoards, isReachMax: false));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        await checkInternet()
            ? emit(GetBoardFavoriteServerError())
            : emit(GetBoardFavoriteNoInternet());
        print('Connection Error.');
        return;
      }
      errorHandlerWithoutInternet(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(GetBoardFavoriteExpiredToken());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(GetBoardFavoriteFailure(errorMessage: e.response!.data['message']));
    } catch (e) {
      print('================ catch exception =================');
      print(e);
      emit(GetBoardFavoriteFailure(errorMessage: 'Catch exception'));
      print(e);
    }
  }
}
