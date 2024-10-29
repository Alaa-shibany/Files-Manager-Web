import 'package:flutter/material.dart';
import 'package:files_manager/cubits/all_boards_cubit/all_boards_cubit.dart';
import 'package:files_manager/cubits/application_cubit/application_cubit.dart';
import 'package:files_manager/cubits/board_cubit/board_cubit.dart';

import '../models/member_model.dart';

abstract class Application {
  IconData getIcon() {
    return Icons.category;
  }

  String getApplicationName() {
    return 'application';
  }

  DateTime getApplicationCreateDate() {
    return DateTime.now();
  }

  int getApplicationFilesCount() {
    return 0;
  }

  Member? getApplicationOwner() {
    return null;
  }

  bool isFolder() {
    return false;
  }

  String getLanguage() {
    return 'en';
  }

  int getApplicationId() {
    return 1;
  }

  void updateApplicationLanguage(String language) {
    print('the selected language is => $language');
    return;
  }

  void updateApplicationTitle(String title) {
    print('the new title is => $title');
    return;
  }

  void updateApplicationColor(int colorIndex, String hex) {
    print('the new hex is => $hex');
    return;
  }

  String getApplicationAbout() {
    return 'about';
  }

  int getApplicationSelectedColor() {
    return 0;
  }

  void pushToScreen({
    required BuildContext context,
    Application? application,
    required BoardCubit boardCubit,
    required AllBoardsCubit allBoardCubit,
    required ApplicationCubit applicationCubit,
  }) {
    print('default navigation');
  }
}
