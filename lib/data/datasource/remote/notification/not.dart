import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:credit_app/core/class/statusrequest.dart';

class Crud {
  Future<Either<StatusRequest, Map>> postData(String linkurl, Map data, {Map<String, String>? headers}) async {
    try {
      var response = await http.post(
        Uri.parse(linkurl),
        body: jsonEncode(data),
        headers: headers ?? {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responseBody = jsonDecode(response.body);
        return Right(responseBody);
      } else {
        return Left(StatusRequest.serverfailure);
      }
    } catch (_) {
      return Left(StatusRequest.serverexception);
    }
  }

  Future<Either<StatusRequest, Map>> patchData(String linkurl, Map data, {Map<String, String>? headers}) async {
    try {
      var response = await http.patch(
        Uri.parse(linkurl),
        body: jsonEncode(data),
        headers: headers ?? {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responseBody = jsonDecode(response.body);
        return Right(responseBody);
      } else {
        return Left(StatusRequest.serverfailure);
      }
    } catch (_) {
      return Left(StatusRequest.serverexception);
    }
  }

  Future<Either<StatusRequest, Map>> getData(String linkurl, {Map<String, String>? headers}) async {
    try {
      var response = await http.get(
        Uri.parse(linkurl),
        headers: headers ?? {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        Map responseBody = jsonDecode(response.body);
        return Right(responseBody);
      } else {
        return Left(StatusRequest.serverfailure);
      }
    } catch (_) {
      return Left(StatusRequest.serverexception);
    }
  }
}