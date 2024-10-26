import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> requestContactsPermission() async {
    final status = await Permission.contacts.request();
    print('Permission Status is => ${status.isGranted}');
    return status.isGranted;
  }
}
