// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:bitcoin/models/app_config.dart';
import 'package:bitcoin/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await loadConfig();
  runApp(const MyApp());
}
Future<void> loadConfig() async {
  String _configContent = 
        await rootBundle.loadString("assests\config\main.json");

  Map _configData= jsonDecode(_configContent);
    // print(_configData);
    GetIt.instance.registerSingleton<AppConfig>(
      AppConfig(COIN_API_BASE_URL: _configData["COIN_API_BASE_URL"]),
    );
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
