import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'dart:html' as html;

import '../shared/local_network.dart';

void showNotification(RemoteMessage message) {
  if (html.Notification.permission == "granted") {
    html.Notification(message.notification?.title ?? 'Notification',
        body: message.notification?.body ?? 'You have a new message.');
  } else {
    print("Browser notifications are not permitted");
  }
}

class FirebaseApi {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotification() async {
    try {
      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        carPlay: false,
        provisional: false,
        criticalAlert: false,
      );
      await getFcmToken();
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        showNotification(message);
      });
      FirebaseMessaging.onBackgroundMessage((message) async {
        print("Web doesn't support background notification in Dart");
      });
    } catch (e) {
      print(e);
    }
  }

  Future getFcmToken({int maxRetries = 3}) async {
    try {
      String? token;
      if (kIsWeb) {
        token = await _firebaseMessaging.getToken(
            vapidKey:
                "BPvlx9kzfsfifFOMLEgsqjuNffYkHfQwjPyWSAYgpOo9QDCH6Ybyz4ycIJOM9xSX6jF252gYTcLb8YDaDbByr4A");
        print('----------------------------------------------------');
        print('the fcm token is => $token');
        print('----------------------------------------------------');
        CashNetwork.insertToCash(key: 'fcm_token', value: token.toString());
        print('.................');
        print(CashNetwork.getCashData(key: 'fcm_token'));
      } else {
        print('you are not using web you will not get fcm token');
      }
      return token;
    } catch (e) {
      print(e);
      print('failed to get fcm token for this device');
      if (maxRetries > 0) {
        await Future.delayed(Duration(seconds: 1));
        return getFcmToken(maxRetries: maxRetries - 1);
      } else {
        return null;
      }
    }
  }
}
