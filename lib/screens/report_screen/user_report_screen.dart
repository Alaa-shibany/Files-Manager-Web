import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/search_filter_cubit/filter_cubit.dart';
import '../../cubits/user_report_cubit/user_report_cubit.dart';
import '../../models/user_report_model.dart';

class UserReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Report')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Search by User Name",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => context.read<FilterCubit>().updateSearchQuery(value),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<Process?>(
                    hint: Text("Filter by Process"),
                    value: context.select<FilterCubit, Process?>((cubit) => cubit.state.selectedProcess),
                    isExpanded: true,
                    items: [null, ...Process.values].map((process) {
                      return DropdownMenuItem<Process?>(
                        value: process,
                        child: Text(process == null ? "All" : process.toString().split('.').last),
                      );
                    }).toList(),
                    onChanged: (value) => context.read<FilterCubit>().updateProcessFilter(value),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) context.read<FilterCubit>().updateStartDate(picked);
                    },
                    child: Text("Select Start Date"),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) context.read<FilterCubit>().updateEndDate(picked);
                    },
                    child: Text("Select End Date"),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<UserReportCubit, UserReportModel>(
              builder: (context, report) {
                return BlocBuilder<FilterCubit, FilterState>(
                  builder: (context, filterState) {
                    final filteredFiles = report.files.where((file) {
                      final matchesSearch = file.title.toLowerCase().contains(filterState.searchQuery);
                      final matchesProcess = filterState.selectedProcess == null ||
                          report.processes[report.files.indexOf(file)] == filterState.selectedProcess;

                      final fileStartDate = report.start[report.files.indexOf(file)];
                      final fileEndDate = report.end[report.files.indexOf(file)];

                      final matchesStartDate = filterState.startDate == null ||
                          (fileStartDate != null && fileStartDate.isAfter(filterState.startDate!));
                      final matchesEndDate = filterState.endDate == null ||
                          (fileEndDate != null && fileEndDate.isBefore(filterState.endDate!));

                      return matchesSearch && matchesProcess && matchesStartDate && matchesEndDate;
                    }).toList();

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
                        child: DataTable(
                          headingRowColor:
                          MaterialStateColor.resolveWith((states) => Colors.orange[500]!),
                          columns: [
                            DataColumn(label: Text('User Name', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Process', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Start Time', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('End Time', style: TextStyle(fontWeight: FontWeight.bold))),
                          ],
                          rows: filteredFiles.map((file) {
                            final index = report.files.indexOf(file);
                            return DataRow(cells: [
                              DataCell(Text(file.title)),
                              DataCell(Text(report.processes[index].toString().split('.').last)),
                              DataCell(Text(report.start[index].toString())),
                              DataCell(Text(report.end[index].toString())),
                            ]);
                          }).toList(),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
