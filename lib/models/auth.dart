import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/exceptions/auth_exceptions.dart';

class Auth with ChangeNotifier {
  var dio = Dio();

  Future<void> _authenticate(
      String email, String password, String urlFragment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=AIzaSyAa0hSI-JtGZQsA9BfDAWJtea0pnsRffso';
    final response = await dio.post(('$url.json'), data: {
      "email": email,
      "password": password,
      "returnSecureToken": true
    });

    final body = response.data;

    if (body['error'] != null) {
      throw AuthExceptions(body['error']['message']);
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
