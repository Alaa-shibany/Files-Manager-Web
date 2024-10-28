import 'package:files_manager/core/functions/statics.dart';
import 'package:files_manager/widgets/auth/login_mobile_widget.dart';
import 'package:files_manager/widgets/auth/login_web_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:files_manager/core/animation/dialogs/dialogs.dart';
import 'package:files_manager/core/functions/validate_input.dart';
import 'package:files_manager/cubits/auth/login/login_cubit.dart';
import 'package:files_manager/cubits/locale_cubit/locale_cubit.dart';
import 'package:files_manager/theme/color.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

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
    final loginCubit = context.read<LoginCubit>();
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
          body: Stack(
            children: [
              Positioned(
                right: mediaQuery.width / 30,
                top: 3,
                child: Opacity(
                  opacity: 0.08,
                  child: const Image(
                    image: AssetImage('assets/images/circles.png'),
                  ),
                ),
              ),
              Positioned(
                left: mediaQuery.width / 30,
                bottom: mediaQuery.height / 20,
                child: Opacity(
                  opacity: 0.08,
                  child: const Image(
                    image: AssetImage('assets/images/circles.png'),
                  ),
                ),
              ),
              SingleChildScrollView(
                padding:
                    EdgeInsets.symmetric(horizontal: mediaQuery.height / 20),
                child: Statics.isPlatformDesktop
                    ? LoginWebWidget(
                        localeCubit: localeCubit,
                        loginCubit: loginCubit,
                        validator: validator,
                        showPassword: showPassword)
                    : LoginMobileWidget(
                        localeCubit: localeCubit,
                        loginCubit: loginCubit,
                        validator: validator,
                        showPassword: showPassword),
              ).animate().fade(
                    duration: const Duration(milliseconds: 500),
                  ),
            ],
          ),
        );
      },
    );
  }
}
