import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:files_manager/core/animation/dialogs/dialogs.dart';
import 'package:files_manager/cubits/auth/otp_cubit/otp_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/theme/color.dart';
import 'package:files_manager/widgets/otp_screen/background_widget.dart';
import 'package:files_manager/widgets/otp_screen/header_text.dart';
import 'package:files_manager/widgets/otp_screen/otp_main_data.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final Map data = ModalRoute.of(context)!.settings.arguments as Map;
    final cubit = context.read<OtpCubit>();
    print('Email is : ${data['email']}');
    print('OTP code is : ${data['otp_code']}');
    final int otpCodeFromForgetis = data['otp_code'];
    print('Value is :$otpCodeFromForgetis');
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocConsumer<OtpCubit, OtpState>(
        listener: (context, state) {
          if (state is OtpLoadingState) {
            loadingDialog(context: context, mediaQuery: mediaQuery);
          } else if (state is OtpSuccessState) {
            Navigator.pop(context);

            Navigator.pushReplacementNamed(
              context,
              '/reset_password',
              arguments: {
                'email': data['email'],
                'otp_code': cubit.pinController.text
              },
            );
          } else if (state is OtpFailedState) {
            errorDialog(context: context, text: state.errorMessage);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                BackgroundWidget(
                  backgroundColor: AppColors.primaryColor,
                  mediaQuery: mediaQuery,
                  child: HeaderText(
                    mediaQuery: mediaQuery,
                    generalText: S.of(context).enter_code_digit,
                    mainText: S.of(context).send_code_success_email,
                  ),
                ),
                SizedBox(
                  height: mediaQuery.height / 10,
                ),
                OtpMainData(
                  mediaQuery: mediaQuery,
                  cubit: cubit,
                  email: data['email'],
                  otpCodeFromForgetis: otpCodeFromForgetis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
