import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/core/server/dio_settings.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/models/board_model.dart';

part 'leave_from_board_state.dart';

class LeaveFromBoardCubit extends Cubit<LeaveFromBoardState> {
  LeaveFromBoardCubit() : super(LeaveFromBoardInitial());

  Future<void> leaveBoard(
      {required BuildContext context,
      required Board currentBoard,
      required int index}) async {
    try {
      emit(LeaveFromBoardLoadingState());
      String? token = CashNetwork.getCashData(key: 'token');
      final response = await dio().delete(
        'boards/leave-board/${currentBoard.uuid}',
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 200) {
        emit(LeaveFromBoardSuccessState(index: index));
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(LeaveFromBoardExpiredState());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(
          LeaveFromBoardFailedState(errorMessage: e.response!.data['message']));
    } catch (e) {
      Navigator.pop(context);
      print('================ catch exception =================');
      print(e);
      emit(LeaveFromBoardFailedState(errorMessage: 'Catch exception'));
      print(e);
    }
  }
}
