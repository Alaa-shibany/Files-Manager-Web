import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:files_manager/core/animation/dialogs/dialogs.dart';
import 'package:files_manager/core/animation/dialogs/expired_dialog.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/cubits/report_cubit/report_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/theme/color.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat.yMMMMd().format(DateTime.now());
    final mediaQuery = MediaQuery.of(context).size;
    final reportCubit = context.read<ReportCubit>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.dark,
      appBar: AppBar(
        title: Text(S.of(context).daily_report),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: BlocConsumer<ReportCubit, ReportState>(
        listener: (context, state) {
          if (state is ReportLoading) {
            loadingDialog(context: context, mediaQuery: mediaQuery);
          }
          if (state is ReportFailure) {
            infoDialog(
                context: context,
                text: state.errorMessage,
                onConfirmBtnTap: () {});
          }
          if (state is ReportExpiredToken) {
            showExpiredDialog(
              context: context,
              onConfirmBtnTap: () async {
                await CashNetwork.clearCash();
                await Hive.box('main').clear();
                Phoenix.rebirth(context);
              },
            );
          }
          if (state is ReportSuccess) {
            Navigator.of(context).pop();
            successDialog(context: context, text: S.of(context).success);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(mediaQuery.width / 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${S.of(context).date}: $currentDate",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: mediaQuery.height / 40),
                  Text(
                    S.of(context).write_your_report,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: mediaQuery.height / 40),
                  TextField(
                    controller: reportCubit.reportText,
                    maxLines: 10,
                    keyboardType: TextInputType.multiline,
                    style: const TextStyle(color: AppColors.dark),
                    decoration: InputDecoration(
                      hintText: S.of(context).enter_report_here,
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: AppColors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: mediaQuery.height / 10),
                  SizedBox(
                    width: mediaQuery.width,
                    child: ElevatedButton(
                      onPressed: () {
                        reportCubit.sendReportFunction(context: context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        S.of(context).submit_report,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fade(
                duration: const Duration(milliseconds: 500),
              );
        },
      ),
    );
  }
}
