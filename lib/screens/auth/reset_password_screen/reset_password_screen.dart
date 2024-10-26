import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:files_manager/core/animation/dialogs/dialogs.dart';
import 'package:files_manager/core/functions/validate_input.dart';
import 'package:files_manager/cubits/auth/reset_password_cubit/reset_password_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/theme/color.dart';
import 'package:files_manager/widgets/custom_text_fields/custom_button_widget.dart';
import 'package:files_manager/widgets/custom_text_fields/custom_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final validator = Validate(context: context);
    final cubit = context.read<ResetPasswordCubit>();
    final Map data = ModalRoute.of(context)!.settings.arguments as Map;
    print('Otp Code is ${data['otp_code']}');
    print('Email is is ${data['email']}');
    return Scaffold(
      backgroundColor: AppColors.dark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: Form(
        key: cubit.formKey,
        child: ListView(
          children: [
            Image(
              image: const AssetImage('assets/icons/logo.png'),
              height: mediaQuery.height / 8,
            ),
            SizedBox(height: mediaQuery.height / 20),
            Text(S.of(context).reset_password,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: mediaQuery.width / 16,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: mediaQuery.height / 40,
            ),
            BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
              listener: (context, state) {
                if (state is ResetPasswordLoading) {
                  loadingDialog(context: context, mediaQuery: mediaQuery);
                }
                if (state is ResetPasswordSuccess) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login_screen',
                    (Route<dynamic> route) => false,
                  );
                }
              },
              builder: (context, state) {
                bool showPassword = state is ShowPassword ? state.show : true;
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: mediaQuery.width / 20),
                  child: CustomFormTextField(
                    obscureText: showPassword,
                    hintText: '********',
                    nameLabel: S.of(context).newpassword,
                    keyboardType: TextInputType.text,
                    controller: cubit.newPasswordController,
                    icon:
                        showPassword ? Icons.visibility_off : Icons.visibility,
                    colorIcon: AppColors.primaryColor,
                    validator: validator.validatePassword,
                    onPressedIcon: () {
                      BlocProvider.of<ResetPasswordCubit>(context)
                          .toggleShowPassword(!showPassword);
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: mediaQuery.height / 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mediaQuery.width / 20),
              child: CustomFormTextField(
                obscureText: true,
                hintText: '********',
                nameLabel: S.of(context).re_password,
                keyboardType: TextInputType.text,
                controller: cubit.repeatPasswordController,
                validator: (
                  String? value,
                ) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).please_enter_the_password_again;
                  }
                  if (value != cubit.newPasswordController.text) {
                    return S.of(context).password_must_match;
                  }

                  return null;
                },
                onChanged: (
                  String? value,
                ) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).please_enter_the_password_again;
                  }
                  if (value != cubit.newPasswordController.text) {
                    return S.of(context).password_must_match;
                  }

                  return null;
                },
              ),
            ),
            SizedBox(height: mediaQuery.height / 10),
            CustomButtonWidget(
              mediaQuery: mediaQuery,
              title: S.of(context).reset_password,
              onPressed: () {
                if (cubit.formKey.currentState!.validate()) {
                  cubit.resetPasswordFun(
                      context: context,
                      email: data['email'],
                      otp_code: data['otp_code'],
                      password: cubit.newPasswordController.text,
                      password_confirmation:
                          cubit.repeatPasswordController.text);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
