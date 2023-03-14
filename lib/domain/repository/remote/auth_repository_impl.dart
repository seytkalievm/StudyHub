import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../common/constants.dart';
import '../../../model/models/resource.dart';
import '../../../model/models/tokens.dart';
import '../../../model/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  static const headers = {
    "X-API-KEY": apiKey,
    "Content-Type": "application/json",
    "Origin": "http://studyhub.kz",
    'Accept': '*/*',
  };
  var getStorage = GetStorage();

  @override
  Future<Resource<Token>> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    var url = Uri.parse("$serverIP/auth/register/");

    var body = json
        .encode({"email": email, "fullname": fullName, "password": password});

    http.Response response;
    try {
      response = await http.post(headers: headers, url, body: body);
    } catch (e) {
      return Fail(errorMessage: e.toString());
    }
    int statusCode = response.statusCode;

    if (statusCode == registerSuccessCode) {
      var token = Token.fromJson(json.decode(response.body));
      getStorage.write("access", token.accessToken);
      getStorage.write("refresh", token.refreshToken);

      return Success(successData: token);
    } else {
      if (statusCode == registerCredentialsAlreadyExistCode) {
        String message = "User with such email already exists";

        return Fail(errorMessage: message, statusCode: statusCode);
      } else {
        return Fail(errorMessage: "Unexpected error", statusCode: statusCode);
      }
    }
  }

  @override
  Future<Resource<Token>> login({
    required String email,
    required String password,
  }) async {
    var url = Uri.parse("$serverIP/auth/login/");

    var body = json.encode({"email": email, "password": password});

    http.Response response;

    try {
      response = await http.post(url, headers: headers, body: body);
    } catch (e) {
      return Fail(errorMessage: e.toString());
    }
    int statusCode = response.statusCode;

    if (statusCode == loginSuccessCode) {
      var token = Token.fromJson(json.decode(response.body));
      getStorage.write("access", token.accessToken);
      getStorage.write("refresh", token.refreshToken);

      return Success(successData: token);
    } else {
      return statusCode == loginWrongCredentialsCode
          ? Fail(errorMessage: "Wrong email or password")
          : Fail(errorMessage: "Unexpected error", statusCode: statusCode);
    }
  }

  @override
  Resource<int> logout() {
    try {
      getStorage.erase();

      return Success(successData: 1);
    } catch (e) {
      return Fail(errorMessage: e.toString());
    }
  }

  @override
  Future<Resource<String>> refresh() async {
    String refresh = getStorage.read("refresh");

    var url = Uri.parse("$serverIP/auth/login/refresh/");
    var body = jsonEncode({"refresh": refresh}).toString();

    http.Response response;
    String access;
    try {
      response = await http.post(url, headers: headers, body: body);
      access = json.decode(response.body)["access"];

      return Success(successData: access);
    } catch (e) {
      return Fail(errorMessage: e.toString());
    }
  }

  @override
  Future<Resource<Token>> loginWithIU({
    required String code,
  }) async {
    var url = Uri.parse("$serverIP/auth/login/iu/");
    var body = jsonEncode({
      "redirect_uri": redirectUri,
      "code": code,
    }).toString();

    http.Response response;

    try {
      response = await http.post(url, headers: headers, body: body);
    } catch (e) {
      debugPrint(e.toString());

      return Fail(errorMessage: e.toString());
    }

    if (response.statusCode == 200) {
      var token = Token.fromJson(json.decode(response.body));
      getStorage.write("access", token.accessToken);
      getStorage.write("refresh", token.refreshToken);

      debugPrint(token.toString());

      return Success(successData: token);
    }
    debugPrint(response.body);

    return Fail(errorMessage: response.body);
  }
}
