import 'dart:async'; //異步處理
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import 'backgroundService.dart';

String url =
    'http://192.168.100.217/'; //TODO: IP, 192.168.100.217(cc123), 192.168.21.25()

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService(); //背景執行服務初始化
  runApp(const MyApp());
  FlutterBackgroundService().invoke("setAsbackground"); //設定背景執行
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

//連結主網頁
class WebViewApp extends StatelessWidget {
  const WebViewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: url + 'index.php',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
