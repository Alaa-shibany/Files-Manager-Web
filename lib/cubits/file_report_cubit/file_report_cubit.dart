import 'package:bloc/bloc.dart';
import 'package:files_manager/models/Process.dart';
import 'package:files_manager/models/file_report_model.dart';
import 'package:meta/meta.dart';

import '../../models/user_model.dart';

part 'file_report_state.dart';

class FileReportCubit extends Cubit<FileReportModel> {
  FileReportCubit() : super(FileReportModel(users: [],processes: [], start: [], end: [],));

  void loadFileReportData() {
    emit(FileReportModel(
      users: [
        User(
          id: 1,
          country: Country(id: 1, name: 'USA', iso3: 'USA', code: 'US'),
          language: Language(id: 1, name: 'English', code: 'EN', direction: 'LTR'),
          gender: Gender(id: 1, type: 'Male'),
          firstName: 'John',
          lastName: 'Doe',
          role: 'Admin',
          dateOfBirth: '1990-01-01',
          countryCode: '+1',
          phone: '1234567890',
          email: 'john.doe@example.com',
          image: 'https://example.com/john.jpg',
        ),
        User(
          id: 2,
          country: Country(id: 2, name: 'Canada', iso3: 'CAN', code: 'CA'),
          language: Language(id: 2, name: 'French', code: 'FR', direction: 'LTR'),
          gender: Gender(id: 2, type: 'Female'),
          firstName: 'Jane',
          lastName: 'Smith',
          role: 'User',
          dateOfBirth: '1985-05-15',
          countryCode: '+1',
          phone: '0987654321',
          email: 'jane.smith@example.com',
          image: 'https://example.com/jane.jpg',
        ),
        User(
          id: 3,
          country: Country(id: 3, name: 'UK', iso3: 'GBR', code: 'GB'),
          language: Language(id: 3, name: 'English', code: 'EN', direction: 'LTR'),
          gender: Gender(id: 3, type: 'Male'),
          firstName: 'George',
          lastName: 'Williams',
          role: 'Editor',
          dateOfBirth: '1992-07-23',
          countryCode: '+44',
          phone: '1122334455',
          email: 'george.williams@example.com',
          image: 'https://example.com/george.jpg',
        ),
      ],
      processes: [Process.CHECKIN, Process.CHECKOUT, Process.EDIT],
      start: [
        DateTime.now().subtract(Duration(hours: 2)),
        DateTime.now().subtract(Duration(hours: 1)),
        DateTime.now(),
      ],
      end: [
        DateTime.now(),
        DateTime.now().add(Duration(hours: 1)),
        DateTime.now().add(Duration(hours: 2)),
      ],
    ));
  }
}
