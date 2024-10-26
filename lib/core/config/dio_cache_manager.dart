// import 'package:dio/dio.dart';
// import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
// import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';

// class DioCacheManager {
//   DioCacheManager._privateConstructor();
//   static final DioCacheManager instance = DioCacheManager._privateConstructor();
//   Dio? _dio;

//   // تحديث الدالة لتقبل إعدادات Dio الخارجية
//   Future<Dio> getDio(Dio dioInstance) async {
//     if (_dio != null) return _dio!;

//     // تحديد المسار لتخزين الكاش على الجهاز
//     Directory appDocDir = await getApplicationDocumentsDirectory();
//     String cachePath = '${appDocDir.path}/dio_cache';

//     // إعدادات الكاش
//     final cacheOptions = CacheOptions(
//       store: HiveCacheStore(cachePath),
//       policy: CachePolicy
//           .forceCache, // البحث في الكاش أولاً، ثم الاتصال بالإنترنت إذا لم تكن البيانات مخزنة
//       hitCacheOnErrorExcept: [
//         401,
//         403
//       ], // استرجاع البيانات من الكاش في حال كان هناك خطأ في الاتصال
//       priority: CachePriority.normal,
//       maxStale: Duration(days: 7), // مدة صلاحية الكاش
//     );

//     // إضافة الكاش إلى Dio المقدم كوسيط
//     dioInstance.interceptors.add(DioCacheInterceptor(options: cacheOptions));

//     _dio = dioInstance;
//     return _dio!;
//   }
// }
