import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:files_manager/core/functions/snackbar_function.dart';
import 'package:files_manager/cubits/auth/otp_cubit/otp_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/theme/color.dart';
import 'package:files_manager/widgets/otp_screen/button__widget.dart';

class OtpMainData extends StatelessWidget {
  const OtpMainData({
    super.key,
    required this.cubit,
    required this.email,
    required this.mediaQuery,
    required this.otpCodeFromForgetis,
  });
  final Size mediaQuery;
  final String email;
  final OtpCubit cubit;
  final int otpCodeFromForgetis;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: mediaQuery.width / 7,
      height: mediaQuery.height / 15,
      textStyle: TextStyle(
        fontSize: mediaQuery.width / 30,
        color: AppColors.primaryColor,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.primaryColor),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Pinput(
          controller: cubit.pinController,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          showCursor: true,
          closeKeyboardWhenCompleted: true,
          keyboardType: TextInputType.number,
          length: 6, // Number of digits
          onCompleted: (pin) async {
            print('The entered pin is => $pin');
            // await BlocProvider.of<OtpValidationCubit>(context)
            //     .otpValidationFun(
            //   email,
            //   pin,
            //   context,
            // );
          },
        ),
        SizedBox(height: mediaQuery.height / 50),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(S.of(context).not_received),
            const SizedBox(child: Text(' ')),
            GestureDetector(
              onTap: () {},
              child: Text(
                S.of(context).resend_OTP,
                style: const TextStyle(color: Color.fromARGB(255, 255, 102, 0)),
              ),
            )
          ],
        ),
        SizedBox(height: mediaQuery.height / 50),
        ButtonWidget(
            mediaQuery: mediaQuery,
            title: S.of(context).verify,
            onPressed: () {
              if (cubit.pinController.text.isEmpty) {
                showLightSnackBar(context, 'Please enter the OTP code');
              } else {
                cubit.verifyAccount(
                  context: context,
                  email: email,
                  otpCode: cubit.pinController.text,
                  adminOtpCode: otpCodeFromForgetis.toString(),
                );
              }
            }),
      ],
    );
  }
}
