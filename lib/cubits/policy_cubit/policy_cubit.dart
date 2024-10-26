import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/core/server/dio_settings.dart';
import 'package:files_manager/core/shared/connect.dart';
import 'package:files_manager/core/shared/local_network.dart';

part 'policy_state.dart';

class PolicyCubit extends Cubit<PolicyState> {
  PolicyCubit() : super(PolicyInitial());

  String? privacyPolicyContent;
  String? termsContent;
  String? contactEmail;
  String? address;

  Future<void> fetchPolicy(BuildContext context) async {
    emit(PolicyLoading());
    try {
      String? token = CashNetwork.getCashData(key: 'token');
      final response = await dio().get(
        'settings/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        privacyPolicyContent = response.data['privacy_policy'];
        termsContent = response.data['terms'];
        contactEmail = response.data['contact_email'];
        address = response.data['address'];
        emit(PolicySuccess());
      } else if (response.statusCode.toString() == '204') {
        emit(PolicySuccess());
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        await checkInternet()
            ? emit(PolicyServerError())
            : emit(PolicyNoInternet());
        print('Connection Error.');
        return;
      } else if (e.response!.statusCode.toString() == '401') {
        emit(PolicyExpiredToken());
      } else {
        errorHandlerWithoutInternet(e: e, context: context);
        emit(
          PolicyFailure(
              errorMessage:
                  e.response?.data?.toString() ?? 'Error fetching policies'),
        );
      }
    } catch (e) {
      emit(PolicyFailure(errorMessage: e.toString()));
    }
  }
}
