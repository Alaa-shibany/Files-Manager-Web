import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:files_manager/models/member_model.dart';
import 'package:flutter/material.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/core/server/dio_settings.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/interfaces/applications_abstract.dart';
import 'package:files_manager/models/board_model.dart';

import '../../models/file_model.dart';
import '../../models/user_model.dart';

part 'board_state.dart';

class BoardCubit extends Cubit<BoardState> {
  BoardCubit({
    required this.currentBoard,
  }) : super(BoardInitial());
  final Board currentBoard;
  int selectedTap = 0;
  TextEditingController boardTitleController = TextEditingController();

  Future<void> initState({
    required BuildContext context,
    required String uuid,
  }) async {
    boardTitleController.text = currentBoard.title;

    emit(BoardInitial());
  }

  List<Application> allApplications = [];
  // List<BoardApplicationsModel> allBoards = [];

  // Future<void> addApplication({required Application newApp}) async {
  //   pagingController.itemList!.add(newApp);
  //   allApplications.add(newApp);
  //   emit(BoardAddApplication());
  // }

  Future<void> refresh() async {
    emit(BoardInitial());
  }

  Future<void> checkIn({required FileModel file}) async {
    file.member = Member(
        id: 1,
        country: Country(id: 1, name: 'damascus', iso3: '+963', code: '123'),
        language: Language(id: 1, name: 'english', code: 'en', direction: 'lr'),
        gender: Gender(id: 1, type: 'male'),
        firstName: 'Alaa',
        lastName: 'Shibany',
        mainRole: 'admin',
        role: 'admin',
        dateOfBirth: '2002-11-28',
        countryCode: '+963',
        phone: '981233473',
        email: 'alaashibany@gmail.com',
        image: '');
    emit(BoardInitial());
  }

  Future<void> checkOut({required FileModel file}) async {
    file.member = null;
    emit(BoardInitial());
  }

  void changeSelectedTap(int newTap) {
    selectedTap = newTap;
    print('The selected tap is => $selectedTap');
  }

  Future<void> deleteApplicationFun(
      {required BuildContext context, required int applicationId}) async {
    emit(DeleteApplicationsInBoardLoading());
    try {
      String? token = CashNetwork.getCashData(key: 'token');
      print('The  token is => $token');
      final response = await dio().delete(
        'board-applications/delete-application-in-board/$applicationId',
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print(response.data);
      emit(DeleteApplicationsInBoardSuccess());
    } on DioException catch (e) {
      print(e.response!.statusCode);
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      print('==============dio exception =================');
    } catch (e) {
      print('===========catch exception ====================');
      emit(DeleteApplicationsInBoardFailure(errorMessage: e.toString()));
    }
  }

  Future<void> moveApplicationToBoard({
    required BuildContext context,
    required int boardId,
  }) async {
    emit(MoveApplicationsToBoardLoading());
    try {
      String? token = CashNetwork.getCashData(key: 'token');

      final response = await dio().post(
        'board-applications/move-application-to-board/$boardId',
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
        emit(MoveApplicationsToBoardSuccess());
      } else if (response.statusCode == 206) {
        Navigator.pop(context);
        emit(MoveApplicationsToBoardFailure(
            errorMessage: response.data['message']));
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(MoveApplicationsToBoardExpiredToken());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(MoveApplicationsToBoardFailure(
          errorMessage: e.response!.data['message']));
    } catch (e) {
      Navigator.pop(context);
      print('================ catch exception =================');
      print(e);
      emit(MoveApplicationsToBoardFailure(errorMessage: 'Catch exception'));
      print(e);
    }
  }

  Future<void> copyApplicationToBoard({
    required BuildContext context,
    required int boardId,
    required bool withContent,
  }) async {
    emit(CopyApplicationsToBoardLoading());
    try {
      String? token = CashNetwork.getCashData(key: 'token');

      final response = await dio().post(
        'board-applications/copy-application-to-board/$boardId',
        data: {
          'move_to_board_id': boardId,
          'content': withContent,
        },
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 200) {
        emit(CopyApplicationsToBoardSuccess());
      } else if (response.statusCode == 206) {
        Navigator.pop(context);
        emit(CopyApplicationsToBoardFailure(
            errorMessage: response.data['message']));
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(CopyApplicationsToBoardExpiredToken());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(CopyApplicationsToBoardFailure(
          errorMessage: e.response!.data['message']));
    } catch (e) {
      Navigator.pop(context);
      print('================ catch exception =================');
      print(e);
      emit(CopyApplicationsToBoardFailure(errorMessage: 'Catch exception'));
      print(e);
    }
  }
}
