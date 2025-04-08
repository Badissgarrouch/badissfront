import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:credit_app/core/class/statusrequest.dart';
import 'package:credit_app/core/function/checkinternet.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http show post;


class Crud {
Future<Either<StatusRequest, Map>> postData(String linkurl, Map data) async {
  try {
    final uri = Uri.parse(linkurl);
    print('🌐 Connecting to: ${uri.toString()}');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
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
}