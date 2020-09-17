
import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationProvider {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _messageStreamController = StreamController<String>.broadcast();

  Stream<String> get messageStream => _messageStreamController.stream;

  void dispose(){
    _messageStreamController?.close();
  }

  static Future<dynamic> onBackgroundMessage(Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  initNotifications() async{

    await _firebaseMessaging.requestNotificationPermissions();
    final _token = await _firebaseMessaging.getToken();

    print("===== FCM Token =====");
    print( _token );

    _firebaseMessaging.configure(
      onMessage: onMessage,
      onBackgroundMessage: Platform.isAndroid ?
            PushNotificationProvider.onBackgroundMessage : null,
      onLaunch: onLaunch,
      onResume: onResume,
    );
  }

  Future<dynamic> onMessage(Map<String, dynamic> message) async {
    print("========= onMessage =========");
    print("message: $message");
    final argument = message["data"]["postre"] ?? "";
    _messageStreamController.sink.add(argument);
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    print("========= onLaunch =========");
    print("message: $message");
    final argument = message["data"]["postre"] ?? "";
    _messageStreamController.sink.add(argument);
  }

  Future<dynamic> onResume(Map<String, dynamic> message) async {
    print("========= onResume =========");
    print("message: $message");
    final argument = message["data"]["postre"] ?? "";
    _messageStreamController.sink.add(argument);
  }

}