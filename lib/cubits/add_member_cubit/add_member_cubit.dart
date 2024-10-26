import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/core/server/dio_settings.dart';
import 'package:files_manager/core/shared/local_network.dart';

part 'add_member_state.dart';

class AddMemberCubit extends Cubit<AddMemberState> {
  AddMemberCubit() : super(AddMemberInitial());

  TextEditingController memberEmailController = TextEditingController();
  String currentRole = 'user';
  final formKey = GlobalKey<FormState>();

  Future<void> initState(String role) async {
    currentRole = role;
    emit(AddMemberInitial());
  }

  Future<void> changePermission(String value) async {
    currentRole = value;
    emit(AddMemberInitial());
  }

  Future<void> addMember({
    required BuildContext context,
    required String uuid,
  }) async {
    try {
      emit(AddMemberLoadingState());
      String? token = CashNetwork.getCashData(key: 'token');

      final response = await dio().post(
        'boards/add-user-in-board/$uuid',
        data: {
          'email': memberEmailController.text,
          'role': currentRole,
        },
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 200) {
        emit(AddMemberSuccessState());
      } else if (response.statusCode == 206) {
        Navigator.pop(context);
        emit(AddMemberFailedState(errorMessage: response.data['message']));
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(AddMemberExpiredState());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(AddMemberFailedState(errorMessage: e.response!.data['message']));
    } catch (e) {
      Navigator.pop(context);
      print('================ catch exception =================');
      print(e);
      emit(AddMemberFailedState(errorMessage: 'Catch exception'));
      print(e);
    }
  }

  Future<void> updateMember(
      {required BuildContext context,
      required String memberId,
      required String uuid}) async {
    try {
      emit(AddMemberLoadingState());
      String? token = CashNetwork.getCashData(key: 'token');

      final response = await dio().post(
        'boards/edit-user-role-in-board/$uuid',
        data: {
          'user_id': memberId,
          'role': currentRole,
        },
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 200) {
        emit(AddMemberSuccessState());
      } else if (response.statusCode == 206) {
        Navigator.pop(context);
        emit(AddMemberFailedState(errorMessage: response.data['message']));
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(AddMemberExpiredState());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(AddMemberFailedState(errorMessage: e.response!.data['message']));
    } catch (e) {
      Navigator.pop(context);
      print('================ catch exception =================');
      print(e);
      emit(AddMemberFailedState(errorMessage: 'Catch exception'));
      print(e);
    }
  }
}
