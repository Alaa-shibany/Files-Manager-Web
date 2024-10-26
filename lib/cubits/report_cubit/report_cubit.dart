import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/core/server/dio_settings.dart';
import 'package:files_manager/core/shared/local_network.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitial());
  TextEditingController reportText = TextEditingController();

  Future<void> sendReportFunction({
    required BuildContext context,
  }) async {
    emit(ReportLoading());
    try {
      String? token = CashNetwork.getCashData(key: 'token');

      final response = await dio().post(
        'reports/save-daily-task',
        data: {'report': reportText.text},
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      print('The status code is => ${response.statusCode}');
      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(ReportSuccess());
      }
    } on DioException catch (e) {
      print('Dio Error is ${e.message}');
      errorHandler(e: e, context: context);
      print(e.response!.data);
      emit(ReportFailure(errorMessage: e.toString()));
      if (e.response!.statusCode == 401) {
        emit(ReportExpiredToken());
        return;
      }
    } catch (e) {
      print('General Error is ${e.toString()}');

      emit(ReportFailure(errorMessage: e.toString()));
    }
  }
}
