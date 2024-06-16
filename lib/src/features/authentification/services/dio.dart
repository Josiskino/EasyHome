import 'package:dio/dio.dart';
import 'package:easyhome/src/constants/constants.dart';

Dio dio() {
  Dio dio = new Dio();

  // dio.options.baseUrl = "http://192.168.1.64:8000/api";
  dio.options.baseUrl = '$baseUrl/api';

  dio.options.headers['accept'] = 'Application/Json';
  //dio.options.['accept'] = 'Application/Json';

  //dio.options.connectTimeout = Duration(seconds: 25);

  //dio.options.receiveTimeout = Duration(seconds: 45);

  return dio;
}
