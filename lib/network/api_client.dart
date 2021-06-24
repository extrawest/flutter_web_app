import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutterwebapp/network/exception.dart';
import 'package:http/http.dart' as http;

const String headerAppId = 'app-id';

class ApiClient {
  ApiClient({required this.baseApiUrl, required this.appId});

  final String baseApiUrl;
  final String appId;

  var headers = <String, String>{'Content-type': 'application/json'};

  Future<dynamic> get(
    String url, {
    Map<String, String>? addHeaders,
    Map<String, String>? params,
  }) async {
    dynamic responseJson;
    final updatedHeaders = await _setupHeaders(headers);

    try {
      final uri = _buildUrl(url, params: params);
      final response = await http.get(uri, headers: updatedHeaders);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Uri _buildUrl(String url, {Map<String, String>? params}) {
    Uri uri;
    if (params != null) {
      uri = Uri.parse(baseApiUrl + url).replace(queryParameters: params);
    } else {
      uri = Uri.parse(baseApiUrl + url);
    }
    print('uri $uri');
    return uri;
  }

  Future<Map<String, String>> _setupHeaders(Map<String, String> newHeaders) async {
    final updatedHeaders = <String, String>{};

    updatedHeaders.addAll(headers);
    updatedHeaders.addAll(newHeaders);

    updatedHeaders.addAll({headerAppId: appId});
    return updatedHeaders;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
