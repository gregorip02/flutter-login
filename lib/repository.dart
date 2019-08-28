import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_jwt_login/models/user.dart';
import 'utils.dart';

class BaseRepository {
  final String baseUri = getBaseUri();

  // Los headers enviados por defecto
  final Map<String, String> defaultHeaders = {
    HttpHeaders.authorizationHeader: '',
  };

  Map<String, String> withAuthorizationHeader(String token) {
    Map headers = Map.from(defaultHeaders);
    headers.addAll({
      HttpHeaders.authorizationHeader: token,
    });

    return headers;
  }
}

class AuthRepository extends BaseRepository {
  Future<User> _loginOrRegister(String endpoint, Map credentials) {
    return Future.delayed(Duration(seconds: 5), () async {
      final res = await http.post('$baseUri/login',
        headers: defaultHeaders, body: credentials).timeout(
        Duration(seconds: 20), onTimeout: () {
          return Future.error(null);
        }
      );

      final Map decoded = json.decode(res.body);

      if (res.statusCode == 200) {
        final User user = User.fromJson(decoded['user']).setToken(decoded['token']);
        return user;
      }

      return Future.error(res.statusCode);
    });
  }

  Future<User> login(Map credentials) => _loginOrRegister('login', credentials);
  Future<User> register(Map credentials) => _loginOrRegister('register', credentials);
}