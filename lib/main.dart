import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'noti.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

void alarmSensor() async {
  var url = Uri.http('192.168.21.34', 'index.php', {'alarm': '1'});
  var response = await http.get(url);
  if (response.statusCode == 200) {
    print('cc');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WebView',
      home: MainScreen(),
    );
  }
}

class WebViewApp extends StatelessWidget {
  const WebViewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: 'http://192.168.21.34/index.php',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
