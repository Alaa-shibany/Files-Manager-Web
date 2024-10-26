import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:files_manager/models/notes_model.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit(this.notesModel) : super(NotesInitial());
  final NotesModel notesModel;

  TextEditingController taskTitleController = TextEditingController();

  Future<void> initState() async {
    taskTitleController =
        TextEditingController(text: notesModel.applicationName);
    emit(NotesInitial());
  }

  Future<void> editTaskName() async {
    notesModel.applicationName = taskTitleController.text;
    print('new notes name => ${notesModel.applicationName}');
    emit(NotesEditData());
  }
}
