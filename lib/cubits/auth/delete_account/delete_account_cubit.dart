import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive/hive.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/core/server/dio_settings.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/theme/color.dart';
part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit() : super(DeleteAccountInitial());

  logoutFun(BuildContext context) async {
    emit(LogoutLoading());
    String? token = CashNetwork.getCashData(key: 'token');
    print('The  token is => $token');
    try {
      final response = await dio().delete(
        'auth/logout',
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        print('Logout successfully');
        // CashNetwork.clearCash();
        // Hive.box('main').clear();
        // Navigator.of(context).pushReplacementNamed('/login_screen');
        print(response.data);
        emit(LogoutSuccess());
      }
    } on DioException catch (e) {
      Navigator.of(context);
      errorHandler(e: e, context: context);
      print('===============dio exception ===============');
      print('The error response code is => ${e.response!.statusCode!}');

      print(e.response);
      emit(LogoutFailure(errorMessage: e.response!.data['message'].toString()));
    } catch (e) {
      print('=============catch exception ================');
      emit(LogoutFailure(errorMessage: e.toString()));
    }
  }

  Future<void> removeAccount({required BuildContext context}) async {
    emit(DeleteAccountLoading());
    try {
      String? token = CashNetwork.getCashData(key: 'token');
      print('The  token is => $token');
      final response = await dio().delete(
        'users/delete-account',
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('---------------delete account response ${response.statusCode}');
      await CashNetwork.clearCash();
      await Hive.box('main').clear();
      print(response.data);
      emit(DeleteAccountSuccess());
    } on DioException catch (e) {
      print(e.response!.statusCode);
      Navigator.pop(context);
      errorHandler(e: e, context: context);
      print('==============dio exception =================');
    } catch (e) {
      print('===========catch exception ====================');
      emit(DeleteAccountFailure(errorMessage: e.toString()));
    }
  }

  void showDialogLogout(BuildContext context) {
    const textStyle =
        TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w600);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.dark,
        title: Text(S.of(context).logout),
        content: Text(S.of(context).do_you_really_want_to_log_out),
        actions: [
          TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                AppColors.primaryColor.withOpacity(0.1),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed('/login_screen');
              CashNetwork.clearCash();
              Hive.box('main').clear();
              Phoenix.rebirth(context);
            },
            child: Text(S.of(context).no, style: textStyle),
          ),
          TextButton(
            onPressed: () => logoutFun(context),
            child: Text(S.of(context).yes, style: textStyle),
          ),
        ],
      ),
    );
  }

  void showDialogRemoveAccount(BuildContext context) {
    const textStyle =
        TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w600);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.dark,
        title: Text(S.of(context).remove_account),
        content: Text(S.of(context).doYouWantToRemoveAccount),
        actions: [
          TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                AppColors.primaryColor.withOpacity(0.1),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(S.of(context).no, style: textStyle),
          ),
          TextButton(
            onPressed: () => removeAccount(context: context),
            child: Text(S.of(context).yes, style: textStyle),
          ),
        ],
      ),
    );
  }
}
