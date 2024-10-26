import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:files_manager/core/animation/dialogs/expired_dialog.dart';
import 'package:files_manager/core/functions/validate_input.dart';
import 'package:files_manager/cubits/add_member_cubit/add_member_cubit.dart';
import 'package:files_manager/cubits/board_settings_cubit/board_settings_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/models/member_model.dart';
import 'package:files_manager/widgets/custom_text_fields/custom_text_field.dart';

import '../../core/animation/dialogs/dialogs.dart';
import '../../core/shared/local_network.dart';
import '../../theme/color.dart';

class UpdateMemberScreen extends StatelessWidget {
  const UpdateMemberScreen(
      {super.key,
      required this.boardSettingsCubit,
      required this.currentMember});
  final BoardSettingsCubit boardSettingsCubit;
  final Member currentMember;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final addMemberCubit = context.read<AddMemberCubit>();
    final validator = Validate(context: context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkGray,
        flexibleSpace: SizedBox(
          height: mediaQuery.height / 3,
        ),
        toolbarHeight: mediaQuery.height / 12,
        title: SizedBox(
          width: mediaQuery.width / 1.3,
          child: Text(
            S.of(context).edit_user,
            textAlign: TextAlign.end,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: mediaQuery.width / 15,
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.cancel_outlined,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocConsumer<AddMemberCubit, AddMemberState>(
        listener: (context, state) {
          if (state is AddMemberLoadingState) {
            loadingDialog(
                context: context,
                mediaQuery: mediaQuery,
                title: S.of(context).editing_in_progress);
          } else if (state is AddMemberSuccessState) {
            Navigator.pop(context);
            currentMember.role = addMemberCubit.currentRole;
            Navigator.pop(context);
            boardSettingsCubit.refresh();
            boardSettingsCubit.resetSearch();
          } else if (state is AddMemberFailedState) {
            errorDialog(context: context, text: state.errorMessage);
          } else if (state is AddMemberExpiredState) {
            showExpiredDialog(
              context: context,
              onConfirmBtnTap: () async {
                await CashNetwork.clearCash();
                await Hive.box('main').clear();
                await Phoenix.rebirth(context);
              },
            );
          }
        },
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: mediaQuery.width / 30,
              vertical: mediaQuery.height / 90,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: addMemberCubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: mediaQuery.height / 50,
                    ),
                    Text(
                      S.of(context).name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomFormTextField(
                      nameLabel: '',
                      enabled: false,
                      hintText:
                          '${currentMember.firstName} ${currentMember.lastName}',
                      borderRadius: 5,
                      styleInput: const TextStyle(color: Colors.white),
                      controller: addMemberCubit.memberEmailController,
                      borderColor: Colors.white54,
                      fillColor: Colors.white10,
                      validator: validator.validateEmail,
                    ),
                    Text(
                      S.of(context).email,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomFormTextField(
                      nameLabel: '',
                      enabled: false,
                      hintText: currentMember.email,
                      borderRadius: 5,
                      styleInput: const TextStyle(color: Colors.white),
                      controller: addMemberCubit.memberEmailController,
                      borderColor: Colors.white54,
                      fillColor: Colors.white10,
                      validator: validator.validateEmail,
                    ),
                    SizedBox(
                      height: mediaQuery.height / 40,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () async {
                        await addMemberCubit.changePermission('admin');
                      },
                      leading: Radio(
                          activeColor: Colors.white,
                          value: 'admin',
                          groupValue: addMemberCubit.currentRole,
                          onChanged: (value) async {
                            await addMemberCubit.changePermission(value!);
                          }),
                      title: Text(S.of(context).admin,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        S.of(context).admin_desc,
                        style: const TextStyle(color: Colors.white54),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () async {
                        await addMemberCubit.changePermission('user');
                      },
                      leading: Radio(
                          activeColor: Colors.white,
                          value: 'user',
                          groupValue: addMemberCubit.currentRole,
                          onChanged: (value) async {
                            await addMemberCubit.changePermission(value!);
                          }),
                      title: Text(S.of(context).user,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        S.of(context).user_desc,
                        style: const TextStyle(color: Colors.white54),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () async {
                        await addMemberCubit.changePermission('guest');
                      },
                      leading: Radio(
                          activeColor: Colors.white,
                          value: 'guest',
                          groupValue: addMemberCubit.currentRole,
                          onChanged: (value) async {
                            await addMemberCubit.changePermission(value!);
                          }),
                      title: Text(S.of(context).guest,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        S.of(context).guest_desc,
                        style: const TextStyle(color: Colors.white54),
                      ),
                    ),
                    SizedBox(
                      height: mediaQuery.height / 15,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () async {
                          await addMemberCubit.updateMember(
                              context: context,
                              memberId: currentMember.id.toString(),
                              uuid: boardSettingsCubit.currentBoard.uuid);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                        ),
                        child: Text(
                          S.of(context).edit_user,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
