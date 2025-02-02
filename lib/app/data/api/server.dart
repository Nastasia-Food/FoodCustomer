// ignore_for_file: depend_on_referenced_packages, prefer_collection_literals, prefer_typing_uninitialized_variables, avoid_print

import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../util/api-list.dart';

class Server {
  static String? bearerToken;

  static initClass({String? token}) {
    final box = GetStorage();
    return bearerToken = box.read('token');
  }

  getRequest({String? endPoint}) async {
    HttpClient client = HttpClient();
    try {
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return await http.get(Uri.parse(endPoint!), headers: _getHttpHeaders());
    } catch (error) {
      return null;
    } finally {
      client.close();
    }
  }

  getRequestWithoutToken({String? endPoint}) async {
    HttpClient client = HttpClient();
    try {
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return await http.get(Uri.parse(endPoint!),
          headers: _getHttpHeadersNotToken());
    } catch (error) {
      return null;
    } finally {
      client.close();
    }
  }

  getRequestSettings(endPoint) async {
    HttpClient client = HttpClient();
    try {
      return await http.get(Uri.parse(APIList.baseUrl! + endPoint!),
          headers: getAuthHeaders());
    } catch (error) {
      return null;
    } finally {
      client.close();
    }
  }

  postRequest({String? endPoint, String? body}) async {
    HttpClient client = HttpClient();
    try {
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return await http.post(Uri.parse(endPoint!),
          headers: getAuthHeaders(), body: body);
    } catch (error) {
      //  return null;
    } finally {
      client.close();
    }
  }

  postRequestWithToken({String? endPoint, String? body}) async {
    HttpClient client = HttpClient();
    try {
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return await http.post(Uri.parse(endPoint!),
          headers: _getHttpHeaders(), body: body);
    } catch (error) {
      return null;
    } finally {
      client.close();
    }
  }

  putRequest({String? endPoint, String? body}) async {
    HttpClient client = HttpClient();
    try {
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return await http.put(Uri.parse(endPoint!),
          headers: _getHttpHeaders(), body: body);
    } catch (error) {
      return null;
    } finally {
      client.close();
    }
  }

  multipartRequest(endPoint, String? filepath) async {
    Map<String, String> headers = {
      'Authorization': initClass(),
      'x-api-key': APIList.licenseCode.toString(),
      'Content-Type': 'multipart/form-data',
    };

    HttpClient client = HttpClient();
    try {
      var request;
      request = http.MultipartRequest('POST', Uri.parse(endPoint!))
        ..headers.addAll(headers)
        ..files.add(await http.MultipartFile.fromPath('image', filepath!));
      return await request.send();
    } catch (error) {
      print(error);
      return null;
    } finally {
      client.close();
    }
  }

  deleteRequest({String? endPoint}) async {
    HttpClient client = HttpClient();
    try {
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return await http.delete(Uri.parse(endPoint!),
          headers: _getHttpHeaders());
    } catch (error) {
      return null;
    } finally {
      client.close();
    }
  }

  static Map<String, String> _getHttpHeaders() {
    Map<String, String> headers = Map<String, String>();
    headers['Authorization'] = initClass();
    headers['x-api-key'] = APIList.licenseCode.toString();
    headers['content-type'] = 'application/json';
    return headers;
  }

  static Map<String, String> _getHttpHeadersNotToken() {
    Map<String, String> headers = Map<String, String>();
    headers['x-api-key'] = APIList.licenseCode.toString();
    headers['content-type'] = 'application/json';
    return headers;
  }

  static Map<String, String> getAuthHeaders() {
    Map<String, String> headers = Map<String, String>();
    headers['x-api-key'] = APIList.licenseCode.toString();
    headers['content-type'] = 'application/json';

    return headers;
  }
}
