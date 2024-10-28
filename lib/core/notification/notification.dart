import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:files_manager/main.dart';

// import '../shared/local_network.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  await showNotification(message);
}

Future<void> showNotification(RemoteMessage message) async {
  print('Received message: ${message.toMap()}');

  final localNotification = FlutterLocalNotificationsPlugin();
  final notification = message.notification;
  // final data = message.data;

  if (notification == null) return;

  String? imageUrl = Platform.isAndroid
      ? message.notification!.android!.imageUrl
      : message.notification!.apple!.imageUrl;
  String? imagePath;

  if (imageUrl != null && imageUrl.isNotEmpty) {
    imagePath = await downloadAndSaveImage(imageUrl);
  }

  final androidNotificationDetails = AndroidNotificationDetails(
    androidChannel.id,
    androidChannel.name,
    channelDescription: androidChannel.description,
    icon: '@drawable/logo',
    importance: Importance.max,
    styleInformation: imagePath != null
        ? BigPictureStyleInformation(
            FilePathAndroidBitmap(imagePath),
            largeIcon: FilePathAndroidBitmap(imagePath),
            contentTitle: notification.title,
            summaryText: notification.body,
          )
        : null,
  );

  final iosNotificationDetails = imagePath != null
      ? DarwinNotificationDetails(
          attachments: [
            DarwinNotificationAttachment(imagePath),
          ],
        )
      : null;

  final notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
    iOS: iosNotificationDetails,
  );

  await localNotification.show(
    notification.hashCode,
    notification.title,
    notification.body,
    notificationDetails,
    payload: jsonEncode(message.toMap()),
  );
}

Future<String> downloadAndSaveImage(String url) async {
  final directory = await getApplicationDocumentsDirectory();

  String fileExtension = url.split('.').last.split('?').first;
  final fileName = 'notification_image.$fileExtension';

  final filePath = '${directory.path}/$fileName';
  final response = await http.get(Uri.parse(url));
  final file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);

  print('Image downloaded to: $filePath');
  return filePath;
}

Future<void> handleMessageOnOpen(RemoteMessage? message) async {
  if (message == null) return;

  // final screenKey = message.data['screen_key'];

  // Call navigateToScreen with the cubit
  // ScreenNavigator.navigateToScreen(
  //   screenKey,
  //   message,
  // );
  //TODO:  //Test Open Notification
  Navigator.of(navigatorKey.currentContext!).pushNamed('/navigation_screen');
}

const androidChannel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications',
  importance: Importance.max,
);

//the new version of firebase
// Future<String> getAccessToken() async {
//   // Your client ID and client secret obtained from Google Cloud Console
//   final serviceAccountJson = {
//     "type": "service_account",
//     "project_id": "projects2022-cf398",
//     "private_key_id": "4fe533a30af2c0f9a5a6c0f57a3c08cc31b86868",
//     "private_key":
//         "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC1ZT8nhLcPhzdl\nhN56Uhyc2/yT06Or1e422NRmQ5EsohhL2bjf+GHREdG4q0G0Rwn9xYv/5bBxXw6t\nFALa6gk66pdV43NpcloJs2xRFuYXTomYmTWMnZI5PCGMbk4GxIyS0ihJRKnK2x1v\nRKNJdZHxVGblZleIhE+7IG1lU/qoro3FxcqgAsQ+U8KG0HFfKLaEUPAdDudxDHxp\nK1WBlYggf+ghyhGDmw4uQhNrWlhZRVQD6Yc+OWRxCry1QkGfzwH85Sd6BqRkCoT7\naidjYlStbRjSsFil7tOhArGRaA/iwPFixAJtLFy+5xyuOtnaYS11RZwxJzj51MMW\nRGGrBe/RAgMBAAECggEAAP7Y6uGak5Y9YpbpFajFCW4CToQMfjvtU8BljK4gP4DK\n5gJVi70e5E6Bunljd0F7N45Rp1+I/rDz2//5HV8db9pWZvKZm+GJxvXaHqkj2CA7\n4b+C1g5jUrcWxAuIQsHqDOrkV7VDF/Q95BzEp07i3yfZwgvevRwPcp/J7z1tFGc7\nzb7ta8ivQTGq4srIWrf6RHMtdw2KXPav/ZbXMd2QBiHi+rl9lU8CHcKr1R66zcZh\nxUKL3VhXv3jmsIjKumZRY43jXw2JJMlqIzeniC+58JGNHVus4z0aHCVdH9UPejUj\n5Yzkz2VzVo6P6+tKLmGTMpVjwcKVNx9EJutqX1ifMQKBgQDZa3vant1fdkd1+ut8\n1TeURaVADZJIfnR2tOXGwX5HRtYTopEtLub4azm5YbEKa1I1po5sq37ZR+aHCR5Z\nrpcn4mH1snlzRazZGA0C5qSOyRZzTlvkG6/XbQVeQP6VWf4yGJHKZE38eoP81tBP\nrJ+4AIkymYtRGGDk70HtE44NLQKBgQDVlVHir7EcRG0K+USz4q1JzLU9EG6QWnns\nW6ho/5xu26AF4sXXL/tvIo+j+SCy4QFwtd1E4dMm7snv2KOZv5lHGGrPXCPyfZU+\nTNqXq4jGZNHFX7ReiU3r5KVZGyKOReOm1dotY41sXKiJjXqaEmhQGAZud8/h7AYP\nXpkkkYp7tQKBgQClUy/ou6iFsIECW3y5fcA3hQX1QNydN1sD8OZQTk3hkSGz6IgQ\nHXwQJijMqFZhH95xYWcnhvh77EqFIA/uDe5uq5vlooLrfm3C3qD2Nb+nu4zQvSLu\nv4bkfsf4Nd/gXYAHQ9uIVOFgPSEkH4xjKVaCKhYpXcwsLCdxreUpixcXOQKBgQCf\n1u2/LijntLW+XqnxzZROBKsmFeQImA1iu32fhpv1wttRTFMvJbOPilfhKRI1jHpd\ndV0wraguHMp3erOE3oTBVh6pLJWiZiWIyE9W7oKfptfuVB9SGIN+JFEyDEKiIt+p\n/aUYDsbJ79YZiw3TvC7gsfouNfAXbWFjozIM0fbHeQKBgHkqJwKdOWCP9LeMiu+Q\ni44zKAcNEzeAoWgYnab56WVzsd8UT2vZFmJz2Ksl1mGtzhHOTu6PMdmboRISBHiN\nftb/qmR32VBZ54IpXGJt5c3fee74PNzLMIK+BrGh/vkssN29u+dSl/KQVKw5jCN8\nBCKJjhwN9+qZ/pHHxw4qpLUR\n-----END PRIVATE KEY-----\n",
//     "client_email":
//         "firebase-adminsdk-kmpf7@projects2022-cf398.iam.gserviceaccount.com",
//     "client_id": "114884151991803860097",
//     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//     "token_uri": "https://oauth2.googleapis.com/token",
//     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
//     "client_x509_cert_url":
//         "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-kmpf7%40projects2022-cf398.iam.gserviceaccount.com",
//     "universe_domain": "googleapis.com"
//   };

//   List<String> scopes = [
//     "https://www.googleapis.com/auth/userinfo.email",
//     "https://www.googleapis.com/auth/firebase.database",
//     "https://www.googleapis.com/auth/firebase.messaging"
//   ];

//   http.Client client = await auth.clientViaServiceAccount(
//     auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
//     scopes,
//   );

//   // Obtain the access token
//   auth.AccessCredentials credentials =
//       await auth.obtainAccessCredentialsViaServiceAccount(
//           auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
//           scopes,
//           client);

//   // Close the HTTP client
//   client.close();

//   // Return the access token
//   return credentials.accessToken.data;
// }

class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;
  final localNotification = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    try {
      // FirebaseMessaging.instance.setAutoInitEnabled(true);
      await firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        carPlay: false,
        provisional: false,
        criticalAlert: false,
      );
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        showNotification(message);
      });

      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        handleMessageOnOpen(message);
      });

      var initializationSettingsAndroid =
          const AndroidInitializationSettings('@drawable/logo');

      var initializationSettingsIOS = const DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );
      await localNotification.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (details) {
          handleMessageOnOpen(
              RemoteMessage.fromMap(jsonDecode(details.payload!)));
        },
      );

      // print('The fcm token is => $fcmToken');
      // CashNetwork.insertToCash(key: 'fcm_token', value: fcmToken.toString());
      // print('.................');
      // print(CashNetwork.getCashData(key: 'fcm_token'));
    } catch (e) {
      print(e);
    }
  }
}
