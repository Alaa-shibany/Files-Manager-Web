import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quill_html_editor_v2/quill_html_editor_v2.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/core/server/dio_settings.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/models/member_model.dart';
import 'package:files_manager/models/task_model.dart';
import 'package:files_manager/theme/color.dart';

part 'task_settings_state.dart';

class TaskSettingsCubit extends Cubit<TaskSettingsState> {
  TaskSettingsCubit({required this.taskModel}) : super(TaskSettingsInitial());
  final TaskModel taskModel;

  late QuillEditorController quillController;
  // quill.QuillController quillCon = QuillController();
  TextEditingController taskNameController = TextEditingController();

  bool showMembers = false;

  Future<void> showAllMembers() async {
    showMembers = !showMembers;
    emit(TaskSettingsInitial());
  }

  Future<void> addMemberToTask(Member member, BuildContext context) async {
    member.status = 'loading';
    emit(TaskSettingsInitial());
    print('add member');
    try {
      String? token = CashNetwork.getCashData(key: 'token');

      final response = await dio().post(
        'tasks/assign-user-in-task/${taskModel.id}',
        data: {
          'user_id': member.id,
        },
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 200) {
        taskModel.users.add(UserTaskModel(
            id: member.id,
            completed: false,
            read: true,
            name: '${member.firstName} ${member.lastName}',
            image: member.image));
        member.status = 'true';
        emit(TaskSettingsInitial());
      }
    } on DioException catch (e) {
      errorHandler(e: e, context: context);
      print(e.response!.data);
      member.status = 'false';
      emit(TaskSettingsInitial());
    } catch (e) {
      print('================ catch exception =================');
      print(e);
      member.status = 'false';
      emit(TaskSettingsInitial());
      print(e);
    }
  }

  Future<void> removeMemberFromTask(Member member, BuildContext context) async {
    member.status = 'loading';
    emit(TaskSettingsInitial());
    try {
      String? token = CashNetwork.getCashData(key: 'token');

      final response = await dio().delete(
        'tasks/remove-user-in-task/${taskModel.id}',
        data: {
          'user_id': member.id,
        },
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 200) {
        taskModel.users.removeWhere(
          (element) => element.id == member.id,
        );
        member.status = 'false';
        emit(TaskSettingsInitial());
      }
    } on DioException catch (e) {
      errorHandler(e: e, context: context);
      member.status = 'true';
      emit(TaskSettingsInitial());
    } catch (e) {
      print('================ catch exception =================');
      print(e);
      member.status = 'true';
      emit(TaskSettingsInitial());
      print(e);
    }
  }

  final customToolBarList = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.align,
    ToolBarStyle.color,
    ToolBarStyle.background,
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.clean,
    ToolBarStyle.addTable,
    ToolBarStyle.editTable,
  ];

  final toolbarColor = Colors.grey;
  final backgroundColor = AppColors.dark;
  final toolbarIconColor = Colors.black87;
  final editorTextStyle = const TextStyle(
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontFamily: 'Roboto');
  final hintTextStyle = const TextStyle(
      fontSize: 18, color: Colors.black38, fontWeight: FontWeight.normal);

  bool hasFocus = false;
  Future<void> initState() async {
    taskNameController = TextEditingController(text: taskModel.title);
    quillController = QuillEditorController();

    quillController.onEditorLoaded(() {
      print('quill loaded');
    });
    emit(TaskSettingsInitial());
  }

  ///[getHtmlText] to get the html text from editor
  void getHtmlText() async {
    String? htmlText = await quillController.getText();
    debugPrint(htmlText);
    emit(TaskSettingsInitial());
  }

  ///[setHtmlText] to set the html text to editor
  Future<void> setHtmlText() async {
    print('eeeee${taskModel.description!}');
    await quillController.setText(taskModel.description!);
  }

  Future<void> saveDocumentation() async {
    taskModel.description = await quillController.getText();
    print('after adding => ${taskModel.description}');
    emit(TaskSettingsInitial());
  }

  /// to clear the editor
  void clearEditor() {
    quillController.clear();
    emit(TaskSettingsInitial());
  }

  /// to enable/disable the editor
  void enableEditor(bool enable) {
    quillController.enableEditor(enable);
    emit(TaskSettingsInitial());
  }

  /// method to un focus editor
  void unFocusEditor() {
    quillController.unFocus();
    emit(TaskSettingsInitial());
  }

  // Initial values: current date and time
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool showTimeDatePicker = false;

  Future<void> showTimeDate(bool value) async {
    print('tap');
    showTimeDatePicker = value;
    emit(TaskSettingsInitial());
  }

  Future<void> saveTimeDate(BuildContext context) async {
    taskModel.date = DateFormat('yyyy-MM-dd').format(selectedDate);
    taskModel.time = DateFormat('HH:mm').format(DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute));
    showTimeDatePicker = false;
    emit(TaskSettingsInitial());
  }

  Future<void> removeTimeDate(BuildContext context) async {
    taskModel.date = null;
    taskModel.time = null;
    showTimeDatePicker = false;
    emit(TaskSettingsInitial());
  }

  // Function to pick a date
  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Current date
      firstDate: DateTime(2000), // Earliest date selectable
      lastDate: DateTime(2100), // Latest date selectable
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate; // Update selected date
      emit(TaskSettingsInitial());
    }
  }

  // Function to pick a time
  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime, // Current time
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      selectedTime = pickedTime; // Update selected time
      emit(TaskSettingsInitial());
    }
  }

  String formatDateTime(String apiDateTime) {
    // Parse the API date string to a DateTime object
    DateTime dateTime = DateTime.parse(apiDateTime);

    // Format the date and time
    String formattedDateTime =
        DateFormat('h:mm a EEEE dd MMM yyyy', 'ar').format(dateTime);

    return formattedDateTime;
  }

  Future<void> editTaskName() async {
    if (taskNameController.text.isEmpty) {
      print('task name is empty');
      return;
    }
    taskModel.title = taskNameController.text;
    emit(TaskSettingsInitial());
  }

  int userInTaskIndex = -1;

  bool isUserInTask() {
    String? userId = CashNetwork.getCashData(key: 'id');
    userInTaskIndex = taskModel.users
        .indexWhere((element) => element.id.toString() == userId);
    return userInTaskIndex != -1;
  }

  Future<void> changeTaskStatus() async {
    taskModel.completed = !taskModel.completed;
    emit(TaskSettingsInitial());
  }

  Future<void> refreshScreen() async {
    emit(TaskSettingsInitial());
  }
}
