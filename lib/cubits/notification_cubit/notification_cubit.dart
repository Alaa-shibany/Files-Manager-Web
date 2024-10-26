import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:files_manager/core/server/dio_settings.dart';
import 'package:files_manager/models/notification_model.dart';

import '../../core/functions/apis_error_handler.dart';
import '../../core/shared/local_network.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  List<NotificationModel> allUnReadNotification = [];
  bool markNotifications = false;
  final box = Hive.box('main');

  Future<void> getData({required BuildContext context}) async {
    emit(NotificationLoadingState());
    try {
      String? token = CashNetwork.getCashData(key: 'token');
      print('The token is => $token');
      final response = await dio().get(
        'users/get-unread-notifications',
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('---------------get profile data response ${response.statusCode}');
      print(response.data);
      await box.put(
          'all_notifications_response', response.statusCode.toString());

      if (response.statusCode == 200) {
        allUnReadNotification = (response.data['notifications']['data'] as List)
            .map((notification) => NotificationModel.fromJson(notification))
            .toList();

        emit(
            NotificationSuccessState(isFromHive: false, isServerBroken: false));
      } else if (response.statusCode == 204) {
        allUnReadNotification = [];
        await box.put('all_notifications', []);
        emit(NotificationNoDataState(isFromHive: false, isServerBroken: false));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.unknown) {
        print('Connection Error.');
        return;
      }
      errorHandlerWithoutInternet(e: e, context: context);
      print(e.response!.statusCode);

      if (e.response!.statusCode == 401) {
        emit(NotificationExpiredState());
      } else {
        emit(NotificationFaildState(errorMessage: e.toString()));
      }
    } catch (e) {
      print('====================catch exception ====================');
      print('General Error is : $e');
      emit(NotificationFaildState(errorMessage: e.toString()));
    }
  }

  // Future<void> getDataFromLocal() async {
  //   if (box.get('all_notifications_response') != null) {
  //     if (box.get('all_notifications_response') == '204') {
  //       emit(NotificationNoDataState(
  //           isFromHive: true, isServerBroken: await checkInternet()));
  //     } else if (box.get('all_notifications') != null) {
  //       print('found the box');
  //       allUnReadNotification = (box.get('all_notifications') as List)
  //           .map((notification) => NotificationModel.fromJson(notification))
  //           .toList();
  //       emit(
  //         NotificationSuccessState(
  //           isFromHive: true,
  //           isServerBroken: await checkInternet(),
  //         ),
  //       );
  //     } else {
  //       if (await checkInternet()) {
  //         emit(NotificationServerBrokenState());
  //       } else {
  //         emit(NotificationNoInternetState());
  //       }
  //     }
  //   } else {
  //     emit(NotificationNoInternetState());
  //   }
  // }

  Future<void> markAllNotificationsAsRead(
      {required BuildContext context}) async {
    emit(NotificationLoadingState());
    try {
      String? token = CashNetwork.getCashData(key: 'token');
      print('The token is => $token');
      final response = await dio().put(
        'users/read-notifications',
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print(
          '--------------------------mark all notifications response ${response.statusCode}');
      print(response.data);
      print(
          '----------------------------------------------------------------------------');

      if (response.statusCode == 200) {
        allUnReadNotification = (response.data['notifications'] as List)
            .map((notification) => NotificationModel.fromJson(notification))
            .toList();
        await box.put('all_notifications', response.data['notifications']);
        emit(NotificationNoDataState(isFromHive: false, isServerBroken: false));
      } else if (response.statusCode == 204) {
        allUnReadNotification = [];
        await box.put('all_notifications', []);
        emit(NotificationNoDataState(isFromHive: false, isServerBroken: false));
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      print(e.response!.statusCode);
      if (e.response!.statusCode == 401) {
        emit(NotificationExpiredState());
      } else {
        emit(NotificationFaildState(errorMessage: e.toString()));
      }
    } catch (e) {
      print(
          '=============================catch exception ===============================');
      emit(NotificationFaildState(errorMessage: e.toString()));
    }
  }
}
