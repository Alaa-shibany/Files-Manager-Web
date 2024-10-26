import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:files_manager/core/animation/dialogs/dialogs.dart';
import 'package:files_manager/core/functions/snackbar_function.dart';
import 'package:files_manager/core/functions/validate_input.dart';
import 'package:files_manager/cubits/auth/forget_password_cubit/forget_password_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/theme/color.dart';
import 'package:files_manager/widgets/custom_text_fields/custom_button_widget.dart';
import 'package:files_manager/widgets/custom_text_fields/custom_text_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final validator = Validate(context: context);
    final cubit = context.read<ForgetPasswordCubit>();
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
      body: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state is ForgetPasswordLoadingState) {
            loadingDialog(context: context, mediaQuery: mediaQuery);
          }
          if (state is ForgetPasswordSuccessState) {
            Navigator.of(context)
                .pushReplacementNamed('/otp_screen', arguments: {
              'email': cubit.emailController.text,
              'isForget': true,
              'otp_code': cubit.otpCode,
            });
            showLightSnackBar(context, S.of(context).send_code_success_email);
          }
        },
        child: Form(
          key: cubit.formKey,
          child: ListView(
            children: [
              Image(
                image: const AssetImage('assets/icons/logo.png'),
                height: mediaQuery.height / 8,
              ),
              SizedBox(height: mediaQuery.height / 20),
              Text(S.of(context).forget_password,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: mediaQuery.width / 16,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                height: mediaQuery.height / 40,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: mediaQuery.width / 10),
                child: Text(
                  S
                      .of(context)
                      .please_enter_your_email_so_you_can_continue_resetting_your_password,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: mediaQuery.height / 13,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: mediaQuery.width / 15),
                child: CustomFormTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: cubit.emailController,
                  colorIcon: Colors.grey,
                  hintText: 'email@example.com',
                  nameLabel: S.of(context).email,
                  validator: validator.validateEmail,
                ),
              ),
              SizedBox(
                height: mediaQuery.height / 10,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: mediaQuery.width / 10),
                child: CustomButtonWidget(
                  mediaQuery: mediaQuery,
                  title: S.of(context).conti,
                  onPressed: () {
                    if (cubit.formKey.currentState!.validate()) {
                      print(cubit.emailController.text.toString());
                      cubit.checkEmail(
                          context: context, email: cubit.emailController.text);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
