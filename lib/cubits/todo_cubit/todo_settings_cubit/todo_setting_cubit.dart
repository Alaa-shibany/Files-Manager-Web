import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'todo_setting_state.dart';

class TodoSettingCubit extends Cubit<TodoSettingState> {
  TodoSettingCubit() : super(TodoSettingInitial());

  Future<void> refresh() async {
    emit(TodoSettingInitial());
  }
}
