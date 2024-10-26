import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:files_manager/core/functions/color_to_hex.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/interfaces/applications_abstract.dart';

import '../../core/functions/apis_error_handler.dart';
import '../../core/server/dio_settings.dart';

part 'update_application_state.dart';

class UpdateApplicationCubit extends Cubit<UpdateApplicationState> {
  UpdateApplicationCubit({required this.application})
      : super(UpdateApplicationInitial());
  final Application application;
  String selectedLanguage = 'en';
  TextEditingController applicationTitleController = TextEditingController();

  Future<void> initState() async {
    selectedLanguage = application.getLanguage();
    applicationTitleController =
        TextEditingController(text: application.getApplicationName());
    emit(UpdateApplicationInitial());
  }

  Future<void> refresh() async {
    emit(UpdateApplicationInitial());
  }

  Future<void> updateLanguage({required newLanguage}) async {
    application.updateApplicationLanguage(newLanguage);
    emit(UpdateApplicationInitial());
    await Future.delayed(const Duration(milliseconds: 5));
    emit(UpdateApplicationInitial());
  }

  Future<void> updateApplicationColor({required int colorIndex}) async {
    application.updateApplicationColor(
        colorIndex, colorToHex(allColors[colorIndex]['real']!));
    emit(UpdateApplicationInitial());
  }

  Future<void> changeApplicationTitle() async {
    if (applicationTitleController.text.isEmpty) {
      return;
    }
    application.updateApplicationTitle(applicationTitleController.text);
    emit(UpdateApplicationInitial());
  }

  Future<void> updateApplication({
    required BuildContext context,
  }) async {
    try {
      emit(UpdateApplicationLoadingState(loadingMessage: S.of(context).saving));
      String? token = CashNetwork.getCashData(key: 'token');

      final response = await dio().put(
        'board-applications/update-application-in-board/${application.getApplicationId()}',
        data: {
          'title': application.getApplicationName(),
          'color': colorToHex(
              allColors[application.getApplicationSelectedColor()]['real']!),
          'language_id': application.getLanguage() == 'en' ? 1 : 2,
        },
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 200) {
        emit(UpdateApplicationSuccessState());
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(UpdateApplicationExpiredState());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(UpdateApplicationFailedState(
          errorMessage: e.response!.data['message']));
    } catch (e) {
      Navigator.pop(context);
      print('================ catch exception =================');
      print(e);
      emit(UpdateApplicationFailedState(errorMessage: 'Catch exception'));
      print(e);
    }
  }
}
