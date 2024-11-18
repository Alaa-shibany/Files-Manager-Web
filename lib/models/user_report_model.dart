import 'package:files_manager/models/Process.dart';
import 'file_model.dart';

class UserReportModel {
  final List<FileModel> files;
  final List<Process> processes;
  final List<DateTime> start;
  final List<DateTime> end;

  UserReportModel({
    required this.files,
    required this.processes,
    required this.start,
    required this.end,
  });
}
