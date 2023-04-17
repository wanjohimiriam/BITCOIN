// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:bitcoin/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await loadConfig();
  runApp(const MyApp());
}
Future<void> loadConfig() async {
  String _configContent = 
        await rootBundle.loadString("assests\config\main.json");

  Map _configData= jsonDecode(_configContent);
    print(_configData);
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coin App',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(88, 60, 197, 1.0)),
      home: MyHomePage(),
    );
  }
}
