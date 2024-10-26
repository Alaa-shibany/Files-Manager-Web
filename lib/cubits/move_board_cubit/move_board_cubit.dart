import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/core/server/dio_settings.dart';
import 'package:files_manager/core/shared/local_network.dart';

part 'move_board_state.dart';

class MoveBoardCubit extends Cubit<MoveBoardState> {
  MoveBoardCubit() : super(MoveBoardInitial());

  Future<void> moveBoard({
    required BuildContext context,
    required String boardId,
    required String movedBoardUuid,
  }) async {
    try {
      emit(MoveBoardLoadingState());
      String? token = CashNetwork.getCashData(key: 'token');

      final response = await dio().post(
        'boards/move-board/$movedBoardUuid',
        data: {
          'move_to_board_id': boardId,
        },
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 200) {
        emit(MoveBoardSuccessState());
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(MoveBoardExpiredState());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(MoveBoardFailedState(errorMessage: e.response!.data['message']));
    } catch (e) {
      Navigator.pop(context);
      print('================ catch exception =================');
      print(e);
      emit(MoveBoardFailedState(errorMessage: 'Catch exception'));
      print(e);
    }
  }
}
