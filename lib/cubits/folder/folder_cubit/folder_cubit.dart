import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../interfaces/applications_abstract.dart';

part 'folder_state.dart';

class FolderCubit extends Cubit<FolderState> {
  FolderCubit() : super(FolderInitial());
  List<Application> allFiles = [];
}
