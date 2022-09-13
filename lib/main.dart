import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'noti.dart';
import 'NotificationService.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

Future alarmSensor() async {
  var url = Uri.http('192.168.21.34', '/espImport.php', {'DataPack': '1'});
  bool alarm = false;

  Timer.periodic(Duration(seconds: 1), (timer) async {
    var response = await http.get(url);
    print('Response body: ${response.body}');

    if (alarm == true) {
      NotificationService().showNotification(1, "cc", "嘻嘻");
      alarm = false;
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WebView',
      home: WebViewApp(),
    );
  }
}

class WebViewApp extends StatelessWidget {
  const WebViewApp({super.key});

  @override
  Widget build(BuildContext context) {
    alarmSensor();
    return Scaffold(
      body: WebView(
        initialUrl: 'http://192.168.21.34/index.php',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
