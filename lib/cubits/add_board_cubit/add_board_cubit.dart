import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/core/server/dio_settings.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/models/board_model.dart';

part 'add_board_state.dart';

class AddBoardCubit extends Cubit<AddBoardState> {
  AddBoardCubit() : super(AddBoardInitial());
  late Board createdBoard;
  Future<void> addBoard({
    required BuildContext context,
  }) async {
    try {
      emit(AddBoardLoadingState());
      String? token = CashNetwork.getCashData(key: 'token');

      final response = await dio().post(
        'boards/create-new-board',
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 201) {
        createdBoard = Board.fromJson(response.data['board']);
        emit(AddBoardSuccessState(
            isSubBoard: false, createdBoard: createdBoard));
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(AddBoardExpiredState());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(AddBoardFailedState(errorMessage: e.response!.data['message']));
    } catch (e) {
      Navigator.pop(context);
      print('================ catch exception =================');
      print(e);
      emit(AddBoardFailedState(errorMessage: 'Catch exception'));
      print(e);
    }
  }

  Future<void> addSubBoard(
      {required BuildContext context,
      required String parentId,
      required Board parentBoard}) async {
    try {
      print('Loading is in progress');
      emit(AddBoardLoadingState());
      String? token = CashNetwork.getCashData(key: 'token');

      final response = await dio().post(
        'boards/create-new-board',
        data: {'parent_id': parentId},
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 201) {
        createdBoard = Board.fromJson(response.data['board']);
        parentBoard.children.add(createdBoard);
        emit(
            AddBoardSuccessState(isSubBoard: true, createdBoard: createdBoard));
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(AddBoardExpiredState());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(AddBoardFailedState(errorMessage: e.response!.data['message']));
    } catch (e) {
      Navigator.pop(context);
      print('================ catch exception =================');
      print(e);
      emit(AddBoardFailedState(errorMessage: 'Catch exception'));
      print(e);
    }
  }
}
