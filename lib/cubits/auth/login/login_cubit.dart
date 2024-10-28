import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/core/server/dio_settings.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/models/user_model.dart';
import '../../../core/animation/dialogs/dialogs.dart';
import '../../../core/shared/connect.dart';
import '../../../generated/l10n.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  bool showPassword = false;
  // final firebaseMessaging = FirebaseMessaging.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      String? fcmToken;
      if (!await checkInternet()) {
        internetToast(context: context);
        Navigator.of(context);
        return;
      }
      emit(LoginLoading());
      print('The fcm token we will send to back => ${fcmToken.toString()}');
      // await FirebaseMessaging.instance.deleteToken().then(
      //   (value) async {
      //     firebaseMessaging.subscribeToTopic('mosh_task_topic');
      //     fcmToken = await firebaseMessaging.getToken();
      //     await CashNetwork.insertToCash(
      //         key: 'fcm_token', value: fcmToken.toString());
      //   },
      // );
      print('The fcm token is => $fcmToken');
      final response = await dio().post('auth/login', data: {
        'email': email,
        'password': password,
        'fcm_token': fcmToken,
      });
      if (response.statusCode == 200) {
        print('success');
        String token = response.data['access_token'];

        await CashNetwork.insertToCash(key: 'token', value: token);
        // await CashNetwork.insertToCash(key: 'fcm_token', value: fcmToken!);
        await CashNetwork.insertToCash(
            key: 'id', value: response.data['user']['id'].toString());
        await CashNetwork.insertToCash(
            key: 'email', value: response.data['user']['email'].toString());
        await CashNetwork.insertToCash(
            key: 'first_name',
            value: response.data['user']['first_name'].toString());
        await CashNetwork.insertToCash(
            key: 'last_name',
            value: response.data['user']['last_name'].toString());
        await CashNetwork.insertToCash(
            key: 'role', value: response.data['user']['role']);
        if (response.data['user']['role'] == null ||
            response.data['user']['role'].isEmpty) {
          print('the role is empty no subscribe');
        } else if (response.data['user']['role'] == 'admin') {
          // firebaseMessaging.subscribeToTopic('mosh_admins_topic');
          // firebaseMessaging.unsubscribeFromTopic('mosh_users_topic');
          print('admin subscribe');
        } else if (response.data['user']['role'] == 'user') {
          // firebaseMessaging.subscribeToTopic('mosh_users_topic');
          // firebaseMessaging.unsubscribeFromTopic('mosh_admins_topic');
          print('user subscribe');
        }
        await CashNetwork.insertToCash(
            key: 'country', value: response.data['user']['country']['name']);
        await CashNetwork.insertToCash(
            key: 'country_id',
            value: response.data['user']['country']['id'].toString());
        await CashNetwork.insertToCash(
            key: 'gender', value: response.data['user']['gender']['type']);
        await CashNetwork.insertToCash(
            key: 'gender_id',
            value: response.data['user']['gender']['id'].toString());
        await CashNetwork.insertToCash(
            key: 'image', value: response.data['user']['image']);
        await CashNetwork.insertToCash(
            key: 'date_of_birth',
            value: response.data['user']['date_of_birth']);
        await CashNetwork.insertToCash(
            key: 'phone', value: response.data['user']['phone']);
        await CashNetwork.insertToCash(
            key: 'country_code', value: response.data['user']['country_code']);
        await CashNetwork.insertToCash(
            key: 'language_code',
            value: response.data['user']['language']['code']);
        await CashNetwork.insertToCash(
            key: 'language_id',
            value: response.data['user']['language']['id'].toString());
        await CashNetwork.insertToCash(
            key: 'language_name',
            value: response.data['user']['language']['name']);
        final User userData = User.fromJson(response.data['user']);
        print(userData);

        print('------login response');
        print(response.data);
        print('------------------------------------------------');
        emit(LoginSuccess());
      }
    } on DioException catch (e) {
      print('Dio Error is ${e.message}');
      print('Type Dio Error is ${e.type}');
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      print('==============dio exception ====================');
      if (e.response!.statusCode! > 400) {
        print('The response code is => ${e.response!.statusCode!}');
        emit(LoginFailure(errorMessage: S.of(context).login_faild));
        return;
      }
      print('The response code is => ${e.response!.statusCode!}');
      print(e.response);
      emit(LoginFailure(errorMessage: e.response!.data.toString()));
    } catch (e) {
      print('General Error is $e');

      print('================catch exception ======================');
      emit(LoginFailure(errorMessage: e.toString()));
    }
  }

  void toggleShowPassword(bool show) {
    emit(ShowPassword(show: show));
  }
}
