import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:pruebaTest/app/app_constants.dart';

import 'package:http/http.dart' as http;
import 'package:pruebaTest/utils/alert.dart';

class API {
  API();

  static const String SEARCH_PRODUCT = "search?q=";

  static const String URL = "https://us-central1-cm-challenges-api.cloudfunctions.net/api";

  Future<MyHttpResponse> getNys(String guia, String client) async {
    var url = Uri.parse("https://us-central1-cm-challenges-api.cloudfunctions.net/nys/?id=" + guia + "_" + client);
    print(url.toString());
    MyHttpResponse response = await getRequest(url);
    try {
      if (response.statusCode == 200) {
        response.message = "exito";
      } else {
        response.message = "Error";
        response.data = null;
      }
    } catch (e) {
      response.message = e.toString();
      response.data = null;
    }
    return response;
  }

  Future<MyHttpResponse> getSend() async {
    var url = Uri.parse(URL);
    print(url.toString());
    MyHttpResponse response = await getRequest(url);
    try {
      if (response.statusCode == 200) {
        response.message = "exito";
      } else {
        response.message = "Error";
        response.data = null;
      }
    } catch (e) {
      response.message = e.toString();
      response.data = null;
    }
    return response;
  }

  Future<MyHttpResponse> sendNyS(BuildContext context, String message, String dateReport, String dateExecute, String messageSolutions,
      String guia, String cliente) async {
    var url = Uri.parse("https://us-central1-cm-challenges-api.cloudfunctions.net/nys");
    print(url.toString());
    Map params;

    params = {
      "data": {
        "novedad": "No hay dirección",
        "fecha_reporte": "2023-01-20",
        "fecha_solucion": "2023-01-23",
        "solucion": "entrega",
        "guia": "3093934",
        "cliente": "30934309"
      }
    };
    MyHttpResponse response = await postRequest(url, jsonMap: params);

    try {
      if (response.statusCode == 200) {
        AlertWidget().message(context, response.message);
      } else {
        response.message = "Error";
        response.data = null;
      }
    } catch (e) {
      response.message = e.toString();
      response.data = null;
    }
    return response;
  }
}

Future<MyHttpResponse> postRequest(Uri uri, {bool shouldRetry = true, Map jsonMap, Map additionalHeaders, bool mntFlag = true}) async {
  Map<String, String> headers = {
    //'Authorization':
    //"Bearer ${ReduxLogin.store.state.postsState.userModel.token.toString() ?? ''}",
    'Content-Type': "application/json",
  };
  if (additionalHeaders != null) headers.addEntries(additionalHeaders.entries);
  final ioc = new HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http2 = new IOClient(ioc);
  var response = await http2.post(uri, body: json.encode(jsonMap), headers: headers);
  print("prueba2:" + response.body.toString() + response.statusCode.toString());
  //print("prueba3:" + json.encode(jsonMap).toString());
  // if (response.statusCode == 505 && shouldRetry) {
  // } else if (response.statusCode == 511) {}

  var data = json.decode(utf8.decode(response.bodyBytes));
  return MyHttpResponse(response.statusCode, data, message: response.statusCode != 200 ? data["message"].toString() : 'error');
}

Future<MyHttpResponse> getRequest(Uri uri) async {
  var response = await http.get(uri);

  print(response.body);

  var data = json.decode(utf8.decode(response.bodyBytes));

  return MyHttpResponse(response.statusCode, response.body);
}

class MyHttpResponse {
  int statusCode;
  String message;
  dynamic data;

  MyHttpResponse(this.statusCode, this.data, {this.message});

  @override
  String toString() {
    return 'MyHttpResponse{statusCode: $statusCode, message: $message, data: $data}';
  }
}
