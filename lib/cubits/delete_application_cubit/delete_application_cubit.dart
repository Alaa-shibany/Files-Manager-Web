import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/core/server/dio_settings.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/interfaces/applications_abstract.dart';

part 'delete_application_state.dart';

class DeleteApplicationCubit extends Cubit<DeleteApplicationState> {
  DeleteApplicationCubit() : super(DeleteApplicationInitial());

  Future<void> deleteApplication(
      {required BuildContext context, required Application application}) async {
    try {
      emit(DeleteApplicationLoadingState(loadingMessage: 'جاري الحذف'));
      String? token = CashNetwork.getCashData(key: 'token');

      final response = await dio().delete(
        'board-applications/delete-application-in-board/${application.getApplicationId()}',
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 200) {
        emit(DeleteApplicationSuccessState());
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(DeleteApplicationExpiredState());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(DeleteApplicationFailedState(
          errorMessage: e.response!.data['message']));
    } catch (e) {
      Navigator.pop(context);
      print('================ catch exception =================');
      print(e);
      emit(DeleteApplicationFailedState(errorMessage: 'Catch exception'));
      print(e);
    }
  }
}
