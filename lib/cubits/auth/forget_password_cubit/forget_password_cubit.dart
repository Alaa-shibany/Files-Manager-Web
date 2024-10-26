import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/core/server/dio_settings.dart';
part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int? otpCode;
  Future<void> checkEmail(
      {required BuildContext context, required String email}) async {
    try {
      emit(ForgetPasswordLoadingState());
      final response = await dio().post('auth/forget-password', data: {
        'email': emailController.text,
      });
      if (response.statusCode == 200) {
        print('success');
        otpCode = response.data['code'];
        emit(ForgetPasswordSuccessState());
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      print('================dio exception ====================');
      print('Dio Error is : ${e.message}');

      print('The response code is => ${e.response!.statusCode!}');
      print(e.response);
      emit(
          ForgetPasswordFailedState(errorMessage: e.response!.data.toString()));
    } catch (e) {
      print('=============catch exception =================');
      print('General Error is : $e');
      emit(ForgetPasswordFailedState(errorMessage: e.toString()));
    }
  }
}
