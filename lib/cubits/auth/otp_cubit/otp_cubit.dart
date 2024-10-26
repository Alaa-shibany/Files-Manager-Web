import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:files_manager/core/functions/snackbar_function.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());
  TextEditingController pinController = TextEditingController();

  Future<void> verifyAccount({
    required BuildContext context,
    required String email,
    required String otpCode,
    required String adminOtpCode,
  }) async {
    try {
      if (adminOtpCode == otpCode) {
        print('OTP Code Matched');
        emit(OtpSuccessState());
      } else {
        showLightSnackBar(context, 'Please Check your OTP Code in your Email');
        emit(OtpFailedState(
            errorMessage: 'Please Check your OTP Code in your Email'));
      }
    } catch (e) {
      print('==============catch exception ===============================');
      emit(OtpFailedState(errorMessage: e.toString()));
    }
  }
}
