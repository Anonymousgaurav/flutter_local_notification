import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() => runApp(new MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin!.initialize(initSetttings);
  }

  Future? onSelectNotification(String payload) {
    debugPrint("payload : $payload");
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title:  Text('Notification'),
        content: Text('$payload'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Flutter Local Notification'),
      ),
      body: new Center(
        child:  RaisedButton(
          onPressed: showNotification,
          child:  Text(
            'Demo'),
        ),
      ),
    );
  }

  showNotification() async {
    var android =  AndroidNotificationDetails(
        'channel id', 'channel NAME', priority: Priority.max,importance: Importance.max
    );
    var iOS =  IOSNotificationDetails();
    var platform =  NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin!.show(
        0, 'New Video is out', 'Flutter Local Notification', platform,
        payload: 'Nitish Kumar Singh is part time Youtuber');
  }
}
