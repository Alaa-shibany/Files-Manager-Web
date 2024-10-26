import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/core/server/dio_settings.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());
  final newPasswordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void toggleShowPassword(bool show) {
    emit(ShowPassword(show: show));
  }

  Future<void> resetPasswordFun({
    required BuildContext context,
    required String email,
    required String otp_code,
    required String password,
    required String password_confirmation,
  }) async {
    emit(ResetPasswordLoading());
    try {
      final response = await dio().put(
        'auth/reset-password',
        data: json.encode(
          {
            'email': email,
            'otp_code': otp_code,
            'password': password,
            'password_confirmation': password_confirmation,
          },
        ),
      );

      print('The status code is ${response.statusCode}');
      if (response.statusCode == 200) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/login_screen',
          (Route<dynamic> route) => false,
        );
      }
    } on DioException catch (e) {
      Navigator.of(context);
      errorHandler(e: e, context: context);
      print('=========dio exception ============');
      print('The error response code is => ${e.response!.statusCode!}');

      print(e.response);
      emit(ResetPasswordFailure(
          errorMessage: e.response!.data['message'].toString()));
    } catch (e) {
      print(
          '=============================catch exception ===============================');
      emit(ResetPasswordFailure(errorMessage: e.toString()));
    }
  }
}
