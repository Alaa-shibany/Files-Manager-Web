import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quill_html_editor_v2/quill_html_editor_v2.dart';
import 'package:files_manager/cubits/todo_cubit/task_settings_cubit/task_settings_cubit.dart';
import 'package:files_manager/theme/color.dart';

class QuillWidget extends StatelessWidget {
  const QuillWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final taskSettingsCubit = context.read<TaskSettingsCubit>();
    return BlocConsumer<TaskSettingsCubit, TaskSettingsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            ToolBar(
              toolBarColor: taskSettingsCubit.toolbarColor,
              padding: const EdgeInsets.all(8),
              iconSize: 25,
              iconColor: taskSettingsCubit.toolbarIconColor,
              activeIconColor: AppColors.primaryColor,
              controller: taskSettingsCubit.quillController,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              toolBarConfig: const [
                ToolBarStyle.undo,
                ToolBarStyle.align,
                ToolBarStyle.background,
                ToolBarStyle.bold,
                ToolBarStyle.color,
                ToolBarStyle.directionLtr,
                ToolBarStyle.directionRtl,
                ToolBarStyle.editTable,
                ToolBarStyle.headerOne,
                ToolBarStyle.headerTwo,
                ToolBarStyle.italic,
                ToolBarStyle.listOrdered,
                ToolBarStyle.listBullet,
                ToolBarStyle.size,
                ToolBarStyle.separator,
                ToolBarStyle.underline,
                ToolBarStyle.strike,
              ],
            ),
            Expanded(
              child: QuillHtmlEditor(
                controller: taskSettingsCubit.quillController,
                isEnabled: true,
                ensureVisible: false,
                minHeight: 500,
                autoFocus: false,
                textStyle: taskSettingsCubit.editorTextStyle,
                hintTextStyle: taskSettingsCubit.hintTextStyle,
                hintTextAlign: TextAlign.start,
                padding: const EdgeInsets.only(left: 10, top: 10),
                hintTextPadding: const EdgeInsets.only(left: 20),
                backgroundColor: taskSettingsCubit.backgroundColor,
                inputAction: InputAction.newline,
                loadingBuilder: (context) {
                  return const Center(
                      child: CircularProgressIndicator(
                    strokeWidth: 1,
                    color: AppColors.primaryColor,
                  ));
                },
                onEditorCreated: () async {
                  print('we will insert here');
                  await taskSettingsCubit.setHtmlText();
                },
                onTextChanged: (p0) {
                  print('00000000000000000000$p0');
                  if (p0.isNotEmpty) {
                    taskSettingsCubit.saveDocumentation();
                  }
                },
                onEditorResized: (height) =>
                    debugPrint('Editor resized $height'),
                onSelectionChanged: (sel) =>
                    debugPrint('index ${sel.index}, range ${sel.length}'),
              ),
            ),
          ],
        );
      },
    );
  }
}
