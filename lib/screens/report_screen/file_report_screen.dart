import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:files_manager/cubits/file_report_cubit/file_report_cubit.dart';
import 'package:files_manager/models/file_report_model.dart';

class FileReportScreen extends StatefulWidget {
  @override
  _FileReportScreenState createState() => _FileReportScreenState();
}

class _FileReportScreenState extends State<FileReportScreen> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('File Report')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Search by File Name",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<FileReportCubit, FileReportModel>(
              builder: (context, report) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black,
                    ),
                    child: DataTable(
                      headingRowColor:
                      MaterialStateColor.resolveWith((states) => Colors.orange[500]!),
                      columns: [
                        DataColumn(label: Text('File Name', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Process', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Start Time', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('End Time', style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                      rows: report.users
                          .where((user) =>
                          '${user.firstName} ${user.lastName}'.toLowerCase().contains(searchQuery))
                          .map((user) {
                        final index = report.users.indexOf(user);
                        return DataRow(cells: [
                          DataCell(Text('${user.firstName} ${user.lastName}')),
                          DataCell(Text(report.processes[index].toString())),
                          DataCell(Text(report.start[index].toString())),
                          DataCell(Text(report.end[index].toString())),
                        ]);
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
