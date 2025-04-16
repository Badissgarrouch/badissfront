import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:credit_app/core/class/statusrequest.dart';
import 'package:credit_app/core/function/checkinternet.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http show get, post;


class Crud {
  Future<Either<StatusRequest, Map>> postData(String linkurl, Map data, {
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.parse(linkurl);
      print('🌐 Connecting to: ${uri.toString()}');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          ...?headers,
        },
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 15));

      print('🔧 Response status: ${response.statusCode}');
      print('📦 Response body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right(jsonDecode(response.body));
      } else {
        throw Exception('HTTP ${response.statusCode}');
      }
    } on SocketException {
      print('🚨 Network error - Server unreachable');
      return Left(StatusRequest.offlinefailure);
    } on TimeoutException {
      print('⏱️ Timeout - Server too slow');
      return Left(StatusRequest.serverfailure);
    } catch (e) {
      print('💥 Unexpected error: $e');
      return Left(StatusRequest.serverexception);
    }
  }

  Future<Either<StatusRequest, Map>> getData(String url,
      {Map<String, String>? headers}) async {
    try {
      if (!await checkInternet()) return Left(StatusRequest.offlinefailure);

      print('🌐 GET Request to: $url');
      final uri = Uri.parse(url);
      final response = await http.get(
        uri,
        headers: headers,
      ).timeout(const Duration(seconds: 15));

      print('🔧 Response status: ${response.statusCode}');
      print('📦 Response body: ${response.body}');

      if (response.statusCode == 200) {
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
      print('💥 GET Error: $e');
      return Left(StatusRequest.serverexception);
    }
  }
}