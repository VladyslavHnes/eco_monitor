import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    var url = 'http://10.0.2.2:8080/monitor/users' + urlSegment;
    try {
      final response = await http.post(
        url,
        headers: {
          'content-type': 'application/json'
        },
        body: json.encode(
          {
            'email': email,
            'password': password,
          },
        ),
      );
      final responseData = json.decode(response.body);

      _token = responseData['token'];
      _userId = responseData['userId'].toString();
      _expiryDate = DateTime.now().add(
        Duration(
          milliseconds: 7200000,
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, '/sign-up');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, '/sign-in');
  }
}
