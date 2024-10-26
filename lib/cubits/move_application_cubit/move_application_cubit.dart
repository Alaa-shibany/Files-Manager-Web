import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/core/server/dio_settings.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/cubits/all_boards_cubit/all_boards_cubit.dart';

part 'move_application_state.dart';

class MoveApplicationCubit extends Cubit<MoveApplicationState> {
  MoveApplicationCubit({required this.allBoardsCubit})
      : super(MoveApplicationInitial());
  AllBoardsCubit allBoardsCubit;
  late int selectedBoard;
  bool moveWithContent = false;

  Future<void> initState() async {
    selectedBoard = allBoardsCubit.pagingController.itemList!.first.id;
    emit(MoveApplicationInitial());
  }

  Future<void> changeContentState() async {
    moveWithContent = !moveWithContent;
    emit(MoveApplicationInitial());
  }

  Future<void> selectBoard(int boardId) async {
    selectedBoard = boardId;
    emit(MoveApplicationInitial());
  }

  Future<void> moveApplication(
      {required BuildContext context, required String applicationId}) async {
    try {
      emit(MoveApplicationLoadingState(loadingMessage: 'جاري الحفظ'));
      String? token = CashNetwork.getCashData(key: 'token');

      final response = await dio().post(
        'board-applications/move-application-to-board/$applicationId',
        data: {
          'move_to_board_id': selectedBoard,
        },
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 200) {
        emit(MoveApplicationSuccessState());
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(MoveApplicationExpiredState());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(MoveApplicationFailedState(
          errorMessage: e.response!.data['message']));
    } catch (e) {
      Navigator.pop(context);
      print('================ catch exception =================');
      print(e);
      emit(MoveApplicationFailedState(errorMessage: 'Catch exception'));
      print(e);
    }
  }

  Future<void> copyApplication(
      {required BuildContext context, required String applicationId}) async {
    try {
      emit(MoveApplicationLoadingState(loadingMessage: 'جاري الحفظ'));
      String? token = CashNetwork.getCashData(key: 'token');

      final response = await dio().post(
        'board-applications/copy-application-to-board/$applicationId',
        data: {
          'copy_to_board_id': selectedBoard,
          'content': moveWithContent ? 1 : 0,
        },
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 201) {
        emit(CopyApplicationSuccessState());
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(MoveApplicationExpiredState());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(MoveApplicationFailedState(
          errorMessage: e.response!.data['message']));
    } catch (e) {
      Navigator.pop(context);
      print('================ catch exception =================');
      print(e);
      emit(MoveApplicationFailedState(errorMessage: 'Catch exception'));
      print(e);
    }
  }
}
