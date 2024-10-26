import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/core/server/dio_settings.dart';
import 'package:files_manager/core/shared/local_network.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final GlobalKey formKey = GlobalKey<FormState>();

  void toggleShowPassword(bool show) {
    emit(ShowPassword(show: show));
  }

  Future<void> changPassword({
    required BuildContext context,
  }) async {
    try {
      emit(ChangePasswordLoading());
      String? token = CashNetwork.getCashData(key: 'token');

      final response = await dio().put(
        'users/update-password',
        data: {
          'password': password.text,
          'password_confirmation': confirmPassword.text,
        },
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 200) {
        emit(ChangePasswordSuccess());
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(ChangePasswordExpiredToken());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(ChangePasswordFailure(errorMessage: e.response!.data['message']));
    } catch (e) {
      Navigator.pop(context);
      print('================ catch exception =================');
      print(e);
      emit(ChangePasswordFailure(errorMessage: 'Catch exception'));
      print(e);
    }
  }
}
