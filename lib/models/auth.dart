import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  var dio = Dio();
  static const url =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAa0hSI-JtGZQsA9BfDAWJtea0pnsRffso';

  Future<void> signup(String email, String password) async {
    final response = await dio.post(
      ('$url.json'),
      data: {
        "email": email,
        "password": password,
        "returnSecureToken": true
      }
    );
  }
}
