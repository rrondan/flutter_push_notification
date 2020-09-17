import 'package:flutter/material.dart';
import 'package:push_notifications_app/src/pages/home_page.dart';
import 'package:push_notifications_app/src/pages/message_page.dart';
import 'package:push_notifications_app/src/providers/push_notification_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> _navigatorKey = new GlobalKey<NavigatorState>();

  PushNotificationProvider _pushNotificationProvider;

  @override
  void initState() {
    super.initState();
    _pushNotificationProvider = new PushNotificationProvider();
    _pushNotificationProvider.initNotifications();
    _pushNotificationProvider.messageStream.listen((data) {
      //print("Argument from main: $data");
      _navigatorKey.currentState.pushNamed("message", arguments: data);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pushNotificationProvider?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Push Notifications App',
      navigatorKey: _navigatorKey,
      initialRoute: "home",
      routes: {
        "home"    : (BuildContext c) => HomePage(),
        "message" : (BuildContext c) => MessagePage(),
      },
    );
  }
}
