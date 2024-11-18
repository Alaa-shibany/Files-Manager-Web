import 'package:flutter_bloc/flutter_bloc.dart';

enum Process { CHECKIN, CHECKOUT, EDIT, DELETE, DOWNLOAD }

class FilterState {
  final String searchQuery;
  final Process? selectedProcess;
  final DateTime? startDate;
  final DateTime? endDate;

  FilterState({
    this.searchQuery = "",
    this.selectedProcess,
    this.startDate,
    this.endDate,
  });

  FilterState copyWith({
    String? searchQuery,
    Process? selectedProcess,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return FilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedProcess: selectedProcess ?? this.selectedProcess,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterState());

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query.toLowerCase()));
  }

  void updateProcessFilter(Process? process) {
    emit(state.copyWith(selectedProcess: process));
  }

  void updateStartDate(DateTime? date) {
    emit(state.copyWith(startDate: date));
  }

  void updateEndDate(DateTime? date) {
    emit(state.copyWith(endDate: date));
  }
}
