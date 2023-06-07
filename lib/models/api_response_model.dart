import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;

class ApiResponseModel {
  int? _code;
  http.Response? _data;
  dio.Response? _dynamicData;
  String? _stringData;

  int? get statusCode => _code;

  http.Response? get data => _data;

  dio.Response? get dynamicData => _dynamicData;

  String? get stringData => _stringData;

  ApiResponseModel({int? code, http.Response? data, dio.Response? dynamicData, String? stringData}) {
    _code = code;
    _data = data;
    _dynamicData = dynamicData;
    _stringData = stringData;
  }
}
