import 'package:internet_connection_checker/internet_connection_checker.dart';

bool? connectionResult;
Future<bool> checkInternet() async {
  return await InternetConnectionChecker().hasConnection;
}
