import 'package:files_manager/screens/report_screen/file_report_screen.dart';
import 'package:files_manager/screens/report_screen/user_report_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/search_filter_cubit/filter_cubit.dart';

class AdminReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reports Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => FilterCubit(),
                      child: FileReportScreen(),
                    ),
                  ),
                );
              },
              child: Text('Go to File Report'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => FilterCubit(),
                      child: UserReportScreen(),
                    ),
                  ),
                );
              },
              child: Text('Go to User Report'),
            ),
          ],
        ),
      ),
    );
  }
}
