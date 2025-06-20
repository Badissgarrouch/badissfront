

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:credit_app/core/class/statusrequest.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

Future<Either<StatusRequest, Map>> sendRequest(
    String method,
    String url, {
      Map<String, String>? headers,
      Map? body,
    }) async {
  try {
    final uri = Uri.parse(url);
    http.Response response;

    final requestHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      ...?headers,
    };

    final encodedBody = body != null ? jsonEncode(body) : null;

    switch (method.toUpperCase()) {
      case 'POST':
        response = await http
            .post(uri, headers: requestHeaders, body: encodedBody)
            .timeout(const Duration(seconds: 15));
        break;
      case 'PATCH':
        response = await http
            .patch(uri, headers: requestHeaders, body: encodedBody)
            .timeout(const Duration(seconds: 15));
        break;
      case 'PUT':
        response = await http
            .put(uri, headers: requestHeaders, body: encodedBody)
            .timeout(const Duration(seconds: 15));
        break;
      case 'DELETE':
        response = await http
            .delete(uri, headers: requestHeaders)
            .timeout(const Duration(seconds: 15));
        break;
      case 'GET':
      default:
        response = await http
            .get(uri, headers: requestHeaders)
            .timeout(const Duration(seconds: 15));
        break;
    }

    print('🔧 $method Response status: ${response.statusCode}');
    print('📦 $method Response body: ${response.body}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Right(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      return Left(StatusRequest.authfailure);
    } else {
      return Left(StatusRequest.serverfailure);
    }
  } on SocketException {
    return Left(StatusRequest.offlinefailure);
  } on TimeoutException {
    return Left(StatusRequest.serverfailure);
  } catch (e) {
    print('💥 $method error: $e');
    return Left(StatusRequest.serverexception);
  }
}
