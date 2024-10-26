import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/core/functions/color_to_hex.dart';
import 'package:files_manager/core/server/dio_settings.dart';
import 'package:files_manager/cubits/locale_cubit/locale_cubit.dart';
import 'package:files_manager/models/board_model.dart';

import '../../core/shared/local_network.dart';

part 'board_settings_state.dart';

class BoardSettingsCubit extends Cubit<BoardSettingsState> {
  BoardSettingsCubit({required this.currentBoard})
      : super(BoardSettingsInitial());
  final Board currentBoard;
  TextEditingController boardTitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  bool emojiKeyboard = false;

  List<dynamic> searchMembers = [];

  Future<void> initState() async {
    boardTitleController = TextEditingController(text: currentBoard.title);
    descriptionController =
        TextEditingController(text: currentBoard.description);
    await resetSearch();
    emit(BoardSettingsInitial());
  }

  Future<void> resetSearch() async {
    searchMembers.clear();
    print('all members in original list is => ${currentBoard.members}');
    searchMembers = [...currentBoard.members, ...currentBoard.invitedUsers];
    print('all members in search list is => $searchMembers');

    emit(BoardSettingsInitial());
  }

  Future<void> search() async {
    searchMembers.clear();
    if (searchController.text.isEmpty) {
      await resetSearch();
      return;
    }
    searchMembers = currentBoard.members
        .where(
          (element) => '${element.firstName} ${element.lastName}'
              .toLowerCase()
              .contains(searchController.text.toLowerCase()),
        )
        .toList();

    // searchMembers.addAll(invitations);
    emit(BoardSettingsInitial());
  }

  Future<void> selectLanguage(String newValue, LocaleCubit localCubit) async {
    if (newValue == 'default') {
      currentBoard.language.code = localCubit.locale.languageCode;
    } else {
      currentBoard.language.code = newValue;
    }
    emit(BoardSettingsInitial());
    await Future.delayed(const Duration(milliseconds: 5));
    emit(BoardSettingsInitial());
  }

  Future<void> refresh() async {
    emit(BoardSettingsInitial());
  }

  Future<void> showEmojiKeyboard() async {
    emojiKeyboard = !emojiKeyboard;
    emit(BoardSettingsInitial());
  }

  Future<void> selectEmoji(String newIcon) async {
    currentBoard.icon = newIcon;
    emit(BoardSettingsInitial());
  }

  Future<void> changeDescription() async {
    currentBoard.description = descriptionController.text;
    emit(BoardSettingsInitial());
  }

  Future<void> selectColor(int index) async {
    currentBoard.boardColorIndex = index;
    currentBoard.color = colorToHex(allColors[index]['real']!);
    emit(BoardSettingsInitial());
  }

  Future<void> changeTitle() async {
    currentBoard.title = boardTitleController.text;
    emit(BoardSettingsInitial());
  }

  Future<void> changePrivacy({required String value}) async {
    currentBoard.visibility = value;
    emit(BoardSettingsInitial());
  }

  Future<void> pickBoardImage({required CroppedFile? file}) async {
    currentBoard.imageFile = File(file!.path);
    currentBoard.hasImage = true;
    emit(BoardSettingsInitial());
  }

  Future<void> deleteBoardImage() async {
    currentBoard.imageFile = null;
    currentBoard.hasImage = false;
    emit(BoardSettingsInitial());
  }

  Future<void> updateBoard({
    required BuildContext context,
  }) async {
    try {
      emit(BoardSettingsLoadingState());
      String? token = CashNetwork.getCashData(key: 'token');
      String fileName1 = currentBoard.imageFile == null
          ? ''
          : currentBoard.imageFile!.path.split('/').last;
      print('the icon is => ${currentBoard.icon}');
      print('the description is => ${currentBoard.description}');
      print(
          'the color is => ${colorToHex(allColors[currentBoard.getApplicationSelectedColor()]['real']!)}');
      print('the title is => ${currentBoard.title}');

      FormData formData = FormData.fromMap({
        'icon': currentBoard.icon,
        'language_id': currentBoard.language.id,
        'description': currentBoard.description,
        'color': colorToHex(
            allColors[currentBoard.getApplicationSelectedColor()]['real']!),
        'visibility': currentBoard.visibility,
        'has_image': currentBoard.hasImage ? 1 : 0,
        'title': currentBoard.title,
        "image": currentBoard.imageFile == null
            ? null
            : MultipartFile.fromFileSync(
                currentBoard.imageFile!.path,
                filename: fileName1,
              ),
      });
      final response = await dio().post(
        'boards/update-board/${currentBoard.uuid}',
        data: formData,
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 200) {
        emit(BoardSettingsSuccessState());
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(BoardSettingsExpiredState());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(BoardSettingsFailedState(errorMessage: e.response!.data['message']));
    } catch (e) {
      Navigator.pop(context);
      print('================ catch exception =================');
      print(e);
      emit(BoardSettingsFailedState(errorMessage: 'Catch exception'));
      print(e);
    }
  }
}
