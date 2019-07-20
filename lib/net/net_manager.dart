import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:http/http.dart' as http;
import 'package:sagrado_flutter/model/model.dart';
import 'package:sagrado_flutter/net/constants.dart';

class NetManager {
  static final NetManager shared = NetManager._internal();
  factory NetManager() {
    return shared;
  }
  NetManager._internal();

  _NetManagerParse parser = _NetManagerParse();

  final String baseUrl = API_LINK_OLD;
  static Future<String> get token async => FlutterKeychain.get(key: 'token');

  static Future<Map<String, String>> get headers async => {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ${await token ?? ''}',
      };

  Future<PhoneAuthResponse> signInPhone({phone: String}) async {
    await FlutterKeychain.clear();
    String formattedPhone = _formatPhone(phone);
    Map<String, String> queryParameters = {
      'username': formattedPhone,
      'os_type': 'ios',
    };
    Uri uri = Uri.http(baseUrl, '/reg', queryParameters);
    final response = await http.post(
      uri,
      headers: await headers,
      body: json.encode(queryParameters),
      encoding: utf8,
    );

    _printData(
      url: baseUrl + '/reg',
      body: response.body,
      headers: headers,
      statusCode: response.statusCode,
    );

    if (response.statusCode == 200) {
      return parser.parseReg(response.body);
    } else {
      throw Exception('try later');
    }
  }

  Future<PhoneCodeResponse> codeConfirmPhone(
      {phone: String, code: String}) async {
    Map<String, String> queryParameters = {
      'username': phone,
      'code': code,
    };
    Uri uri = Uri.http(baseUrl, '/confirm', queryParameters);
    final response = await http.post(
      uri,
      headers: await headers,
      body: json.encode(queryParameters),
      encoding: utf8,
    );

    _printData(
      url: baseUrl + '/confirm',
      body: response.body,
      statusCode: response.statusCode,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return parser.parseConfirm(response.body);
    } else {
      throw Exception('Failed to post code');
    }
  }

  Future<User> saveSettings({Map<String, dynamic> params}) async {
    Uri uri = Uri.http(baseUrl, '/user/settings', params);
    final response = await http.post(
      uri,
      headers: await headers,
      body: json.encode(params),
      encoding: utf8,
    );

    _printData(
      url: baseUrl + '/reg',
      body: response.body,
      headers: headers,
      statusCode: response.statusCode,
    );

    if (response.statusCode == 200) {
      return parser.parseSaveSettings(response.body);
    } else {
      throw Exception('try later');
    }

    var user = User();
    return user;
  }
}

class _NetManagerParse {
  PhoneAuthResponse parseReg(String responseBody) {
    return PhoneAuthResponse.fromJson(json.decode(responseBody));
  }

  PhoneCodeResponse parseConfirm(String responseBody) {
    return PhoneCodeResponse.fromJson(json.decode(responseBody));
  }

  User parseSaveSettings(String responseBody) {
    return User.fromJson(json.decode(responseBody));
  }
}

void _printData(
    {String url, Future<Map> headers, int statusCode, String body}) async {
  print('----');
  print(url);
  print(await headers);
  print('status code:' + '$statusCode');
  print(body);
  print('----');
}

String _formatPhone(String phone) {
  return phone.replaceAll(new RegExp(r'[^\w\s]+'), '');
}
