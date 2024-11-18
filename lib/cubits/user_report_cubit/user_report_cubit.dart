import 'package:bloc/bloc.dart';
import 'package:files_manager/models/file_model.dart';
import 'package:files_manager/models/user_report_model.dart';
import 'package:files_manager/models/Process.dart';

class UserReportCubit extends Cubit<UserReportModel> {
  UserReportCubit() : super(UserReportModel(files: [], processes: [], start: [], end: []));

  void loadUserReportData() {
    emit(UserReportModel(
      files: [
        FileModel(id: 1, boardId: 101, title: 'Report 1', mode: 'Read', createdAt: DateTime.now(), updatedAt: DateTime.now()),
        FileModel(id: 2, boardId: 102, title: 'Report 2', mode: 'Edit', createdAt: DateTime.now(), updatedAt: DateTime.now()),
        FileModel(id: 3, boardId: 103, title: 'Report 3', mode: 'Read-Only', createdAt: DateTime.now(), updatedAt: DateTime.now()),
      ],
      processes: [Process.DOWNLOAD, Process.EDIT, Process.DELETE],
      start: [
        DateTime.now().subtract(Duration(days: 1)),
        DateTime.now().subtract(Duration(days: 2)),
        DateTime.now().subtract(Duration(days: 3)),
      ],
      end: [
        DateTime.now(),
        DateTime.now().add(Duration(hours: 4)),
        DateTime.now().add(Duration(hours: 5)),
      ],
    ));
  }
}
