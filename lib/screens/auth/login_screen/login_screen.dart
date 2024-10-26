import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:files_manager/core/animation/dialogs/dialogs.dart';
import 'package:files_manager/core/functions/validate_input.dart';
import 'package:files_manager/cubits/auth/login/login_cubit.dart';
import 'package:files_manager/cubits/locale_cubit/locale_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/theme/color.dart';
import 'package:files_manager/widgets/custom_text_fields/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void _closeLoadingDialog(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final validator = Validate(context: context);
    final localeCubit = context.read<LocaleCubit>();

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          _closeLoadingDialog(context);
          Navigator.pushReplacementNamed(context, '/navigation_screen');
        } else if (state is LoginFailure) {
          _closeLoadingDialog(context);
          errorDialog(context: context, text: state.errorMessage);
        } else if (state is LoginLoading) {
          loadingDialog(context: context, mediaQuery: mediaQuery);
        }
      },
      builder: (context, state) {
        bool showPassword = state is ShowPassword ? state.show : true;
        return Scaffold(
          backgroundColor: AppColors.dark,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.dark,
            toolbarHeight: 1,
          ),
          body: GestureDetector(
            onTap: () {
              // FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: mediaQuery.height / 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: mediaQuery.height,
                ),
                child: IntrinsicHeight(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: mediaQuery.height / 9),
                        // Logo
                        SizedBox(
                          child: Image.asset(
                            'assets/icons/logo.png',
                            height: mediaQuery.height / 5,
                            // width: mediaQuery.width / 1.5,
                            // fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: mediaQuery.height / 50),
                        CustomFormTextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          colorIcon: Colors.grey,
                          hintText: 'email@example.com',
                          nameLabel: S.of(context).email,
                          validator: validator.validateEmail,
                        ),
                        SizedBox(height: mediaQuery.height / 50),
                        // Password Field
                        CustomFormTextField(
                          obscureText: showPassword,
                          keyboardType: TextInputType.text,
                          controller: passwordController,
                          icon: showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          colorIcon: Colors.grey,
                          hintText: '******',
                          nameLabel: S.of(context).password,
                          onPressedIcon: () {
                            BlocProvider.of<LoginCubit>(context)
                                .toggleShowPassword(!showPassword);
                          },
                          validator: validator.validatePassword,
                        ),
                        // Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/forget_password');
                            },
                            child: Text(
                              S.of(context).forget_password,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        SizedBox(height: mediaQuery.height / 40),
                        // Login Button
                        SizedBox(
                          width: mediaQuery.width,
                          height: mediaQuery.height / 15,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                // BlocProvider.of<LoginCubit>(context).login(
                                //   context: context,
                                //   email: emailController.text.toString(),
                                //   password: passwordController.text.toString(),
                                // );
                                Navigator.pushReplacementNamed(
                                    context, '/navigation_screen');

                                print(emailController.text.toString());
                                print(passwordController.text.toString());
                              }
                            },
                            child: Text(
                              S.of(context).login,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: mediaQuery.width / 25,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: mediaQuery.height / 60),

                        // /Register Btn ///
                        SizedBox(
                          width: mediaQuery.width,
                          height: mediaQuery.height / 15,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/register_screen');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade500,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              S.of(context).sign_up,
                              style: GoogleFonts.tajawal(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: mediaQuery.width / 25,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mediaQuery.height / 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            localeCubit.showLanguageDialog(context);
                          },
                          child: Text(
                            S.of(context).change_language,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: mediaQuery.height / 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ).animate().fade(
                duration: const Duration(milliseconds: 500),
              ),
        );
      },
    );
  }
}
