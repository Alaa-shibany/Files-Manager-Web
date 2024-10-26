import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:files_manager/cubits/auth/forget_password_cubit/forget_password_cubit.dart';
import 'package:files_manager/cubits/auth/login/login_cubit.dart';
import 'package:files_manager/cubits/auth/otp_cubit/otp_cubit.dart';
import 'package:files_manager/cubits/auth/register_cubit/register_cubit.dart';
import 'package:files_manager/cubits/auth/reset_password_cubit/reset_password_cubit.dart';
import 'package:files_manager/cubits/change_password_cubit/change_password_cubit.dart';
import 'package:files_manager/cubits/navigation_cubit/navigation_cubit.dart';
import 'package:files_manager/cubits/policy_cubit/policy_cubit.dart';
import 'package:files_manager/cubits/profile_cubit/profile_cubit.dart';
import 'package:files_manager/cubits/report_cubit/report_cubit.dart';
import 'package:files_manager/cubits/splash/splash_cubit.dart';
import 'package:files_manager/screens/auth/forget_password_screen/forget_password_screen.dart';
import 'package:files_manager/screens/auth/login_screen/login_screen.dart';
import 'package:files_manager/screens/auth/otp_screen/otp_screen.dart';
import 'package:files_manager/screens/auth/register_screen/register_screen.dart';
import 'package:files_manager/screens/auth/reset_password_screen/reset_password_screen.dart';
import 'package:files_manager/screens/navigation_screen/navigation_screen.dart';
import 'package:files_manager/screens/privacy_and_policy/privacy_and_policy.dart';
import 'package:files_manager/screens/privacy_and_policy/terms_and_conditions.dart';
import 'package:files_manager/screens/profile_screen/profile_screen.dart';
import 'package:files_manager/screens/report_screen/report_screen.dart';
import 'package:files_manager/screens/settings/reset_password_screen/change_password_screen.dart';
import 'package:files_manager/screens/start/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  // ======splash Screen=====//
  '/': (context) => BlocProvider(
        create: (context) => SplashCubit()..checkConnection(context: context),
        child: const SplashScreen(),
      ),
  // ======Navigation Screen=====//
  '/navigation_screen': (context) => BlocProvider(
        create: (context) => NavigationCubit(),
        child: const NavigationScreen(),
      ),
  // ======Add Board screen=====//
  // '/add_board_screen': (context) => MultiBlocProvider(providers: [
  //       BlocProvider(
  //         create: (context) => BoardCubit(),
  //       ),
  //     ], child: const AddBoardScreen()),

  // ======Login Screen=====//
  '/login_screen': (context) => BlocProvider(
        create: (context) => LoginCubit(),
        child: LoginScreen(),
      ),
  // ======Register Screen=====//
  '/register_screen': (context) => BlocProvider(
        create: (context) => RegisterCubit()..fetchLanguageFunction(context),
        // ..fetchCountry(context)
        // ..fetchGenderFunction(context)

        child: const RegisterScreen(),
      ),
  // ======Forget Password Screen=====//
  '/forget_password': (context) => BlocProvider(
        create: (context) => ForgetPasswordCubit(),
        child: const ForgetPasswordScreen(),
      ),
  // ======Reset Password Screen=====//
  '/reset_password': (context) => BlocProvider(
        create: (context) => ResetPasswordCubit(),
        child: const ResetPasswordScreen(),
      ),
  // ======OTP Screen=====//
  '/otp_screen': (context) => BlocProvider(
        create: (context) => OtpCubit(),
        child: const OtpScreen(),
      ),
  // ======User Profile Screen=====//
  '/user_profile': (context) => BlocProvider(
        create: (context) => ProfileCubit()..init(context),
        child: const ProfileScreen(),
      ),
  // ======Change Password Screen=====//
  '/change_password': (context) => BlocProvider(
        create: (context) => ChangePasswordCubit(),
        child: const ChangePasswordScreen(),
      ),
  // ======Report Screen=====//
  '/report_screen': (context) => BlocProvider(
        create: (context) => ReportCubit(),
        child: const ReportScreen(),
      ),
  //===== privacy and policy Screen =====//
  '/privacy_and_policy': (context) => BlocProvider(
        create: (context) => PolicyCubit(),
        child: const PrivacyAndPolicy(),
      ),
  //===== Terms and Conditions Screen =====//
  '/terms_and_conditions': (context) => BlocProvider(
        create: (context) => PolicyCubit(),
        child: const TermsAndConditions(),
      ),
};
