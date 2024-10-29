import 'package:files_manager/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/functions/validate_input.dart';
import '../../cubits/add_board_cubit/add_board_cubit.dart';
import '../../cubits/all_boards_cubit/all_boards_cubit.dart';
import '../../cubits/auth/login/login_cubit.dart';
import '../../cubits/leave_from_board_cubit/leave_from_board_cubit.dart';
import '../../cubits/locale_cubit/locale_cubit.dart';
import '../../generated/l10n.dart';
import '../../screens/home/board_screen.dart';
import '../custom_text_fields/custom_text_field.dart';

class LoginWebWidget extends StatelessWidget {
  const LoginWebWidget(
      {super.key,
      required this.localeCubit,
      required this.loginCubit,
      required this.validator,
      required this.showPassword});
  final LoginCubit loginCubit;
  final Validate validator;
  final bool showPassword;
  final LocaleCubit localeCubit;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: mediaQuery.height,
      ),
      child: IntrinsicHeight(
        child: Form(
          key: loginCubit.formKey,
          child: SizedBox(
            width: mediaQuery.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: mediaQuery.height / 90),
                Container(
                  // height: mediaQuery.height / 1.3,
                  width: mediaQuery.width / 3,
                  padding: EdgeInsets.symmetric(
                    horizontal: mediaQuery.width / 50,
                    vertical: mediaQuery.height / 90,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 44, 51, 55),
                    border: Border.all(color: AppColors.primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(children: [
                    SizedBox(height: mediaQuery.height / 90),
                    // Logo
                    SizedBox(
                      child: Image.asset(
                        'assets/icons/logo.png',
                        height: mediaQuery.height / 6,
                        // width: mediaQuery.width / 1.5,
                        // fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: mediaQuery.width / 3,
                      child: CustomFormTextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: loginCubit.emailController,
                        colorIcon: Colors.grey,
                        hintText: 'email@example.com',
                        nameLabel: S.of(context).email,
                        validator: validator.validateEmail,
                      ),
                    ),
                    SizedBox(height: mediaQuery.height / 50),
                    // Password Field
                    SizedBox(
                      width: mediaQuery.width / 3,
                      child: CustomFormTextField(
                        obscureText: showPassword,
                        keyboardType: TextInputType.text,
                        controller: loginCubit.passwordController,
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
                      width: mediaQuery.width / 3,
                      height: mediaQuery.height / 15,
                      child: ElevatedButton(
                        onPressed: () {
                          if (loginCubit.formKey.currentState!.validate()) {
                            // BlocProvider.of<LoginCubit>(context).login(
                            //   context: context,
                            //   email: emailController.text.toString(),
                            //   password: passwordController.text.toString(),
                            // );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider(
                                        create: (context) => AllBoardsCubit()
                                          ..initState(context: context),
                                      ),
                                      BlocProvider(
                                        create: (context) =>
                                            LeaveFromBoardCubit(),
                                      ),
                                      BlocProvider(
                                        create: (context) => AddBoardCubit(),
                                      ),
                                    ],
                                    child: const BoardScreen(),
                                  ),
                                ));

                            print(loginCubit.emailController.text.toString());
                            print(
                                loginCubit.passwordController.text.toString());
                          }
                        },
                        child: Text(
                          S.of(context).login,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: mediaQuery.width / 80,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: mediaQuery.height / 60),
                    // /Register Btn ///
                    SizedBox(
                      width: mediaQuery.width / 3,
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
                            fontSize: mediaQuery.width / 80,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mediaQuery.height / 40,
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
                      height: mediaQuery.height / 40,
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
