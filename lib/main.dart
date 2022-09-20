import 'dart:async'; //異步處理
import 'dart:convert'; //json 轉換
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

import 'NotificationService.dart';

String url = 'http://192.168.21.34/'; //TODO: IP
int periodTime = 1; //TODO: 週期時間

void main() {
  runApp(const MyApp());
}

//json 解析 & 警報
Future jsonDecode_and_alarm() async {
  var decode; //json 解析後的資料
  int value; //是否起火或有煙霧
  String warningText; // 警告字樣

  //週期執行
  Timer.periodic(Duration(seconds: periodTime), (timer) async {
    final response = await http.get(Uri.parse(url + 'alarm.json')); //http 請求

    //如果 Server 回應 200(接受)，則解析 json 檔
    if (response.statusCode == 200) {
      decode = jsonDecode(response.body);
      value = decode['alarm'];
    } else {
      throw Exception('no data ;(');
    }

    //若起火或有煙霧，則發出警報
    if (value == 1) {
      warningText = decode['warningText'];
      //通知(ID, 標題, 內容)
      NotificationService().showNotification(1, "居家防災警報", warningText);
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

//連結主網頁
class WebViewApp extends StatelessWidget {
  const WebViewApp({super.key});

  @override
  Widget build(BuildContext context) {
    jsonDecode_and_alarm(); //TODO: 拉走
    return Scaffold(
      body: WebView(
        initialUrl: url + 'index.php',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
