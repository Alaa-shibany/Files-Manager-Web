import 'package:files_manager/models/Process.dart';
import 'package:files_manager/models/user_model.dart';

class FileReportModel {
  final List<User> users;
  final List<Process> processes;
  final List<DateTime> start;
  final List<DateTime> end;

  FileReportModel({
    required this.users,
    required this.processes,
    required this.start,
    required this.end,
  });
}
