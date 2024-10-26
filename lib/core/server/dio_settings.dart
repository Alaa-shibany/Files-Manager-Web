import 'package:dio/dio.dart';
import 'package:files_manager/core/functions/language.dart';

Dio dio() {
  Dio dio = Dio();
  dio.options.baseUrl = 'https://tasks.mosh-group.com/api/v1/';
  dio.options.headers['Accept'] = 'application/json';
  dio.options.headers['Accept-Language'] = isArabic() ? 'ar' : 'en';
  return dio;
}
