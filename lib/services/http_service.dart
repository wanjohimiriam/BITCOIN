import 'package:dio/dio.dart';
import '../models/app_config.dart';
import 'package:get_it/get_it.dart';

class HttpService{
  final Dio dio = Dio();
}

AppConfig? appConfig;