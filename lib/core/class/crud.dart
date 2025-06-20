

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:credit_app/core/class/statusrequest.dart';
import 'package:credit_app/core/constant/methodhttp.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../function/checkinternet.dart';

class Crud {
  Future<Either<StatusRequest, Map>> postData(String url, Map data,
      {Map<String, String>? headers}) async {
    return await sendRequest('POST', url, headers: headers, body: data);
  }

  Future<Either<StatusRequest, Map>> post2Data(
      String url, Map data, File file,
      {Map<String, String>? headers}) async {
    return await sendMultipartRequest(url, data, file, headers: headers);
  }


  Future<Either<StatusRequest, Map>> patchData(String url, Map data,
      {Map<String, String>? headers}) async {
    return await sendRequest('PATCH', url, headers: headers, body: data);
  }

  Future<Either<StatusRequest, Map>> putData(String url, Map data,
      {Map<String, String>? headers}) async {
    return await sendRequest('PUT', url, headers: headers, body: data);
  }

  Future<Either<StatusRequest, Map>> deleteData(String url,
      {Map<String, String>? headers}) async {
    return await sendRequest('DELETE', url, headers: headers);
  }

  Future<Either<StatusRequest, Map>> getData(String url,
      {Map<String, String>? headers}) async {
    if (!await checkInternet()) return Left(StatusRequest.offlinefailure);
    return await sendRequest('GET', url, headers: headers);
  }

  Future<Either<StatusRequest, Map>> sendMultipartRequest(String url, Map data,
      File file,
      {Map<String, String>? headers}) async {
    try {
      if (!await checkInternet()) return Left(StatusRequest.offlinefailure);

      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Ajoute les headers
      if (headers != null) {
        request.headers.addAll(headers);
      }

      // Ajoute le fichier
      request.files.add(await http.MultipartFile.fromPath(
        'receiptImage', // Nom du champ dans le formulaire
        file.path,
        filename: 'receipt_${DateTime
            .now()
            .millisecondsSinceEpoch}.jpg',
      ));

      // Ajoute les autres champs
      data.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      print('🔧 Multipart Response status: ${response.statusCode}');
      print('📦 Multipart Response body: $responseData');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right(jsonDecode(responseData));
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
      print('💥 Multipart error: $e');
      return Left(StatusRequest.serverexception);
    }
  }
}
