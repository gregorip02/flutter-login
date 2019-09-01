import 'dart:io';
import 'utils.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_jwt_login/models/user.dart';

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
  Future<User> auth(String endpoint, Map credentials) async {
    if (buildMode() != 'release') {
      // Para mi entorno local, el backend API esta en localhost,
      // así que tendré que hacer una pequeña pausa para
      // simular una petición a Internet.
      await Future.delayed(Duration(seconds: 5));
    }

    final request = await http.post('$baseUri/$endpoint',
      headers: defaultHeaders, body: credentials).timeout(
      Duration(seconds: 20), onTimeout: () {
        return Future.error('Tiempo agotado en la petición');
      }
    );

    final Map decoded = json.decode(request.body);

    // Las respuestas del backend API exitosas pueden variar entre
    // 200 y 201, para login o registro, respectivamente.
    if (request.statusCode == 200 || request.statusCode == 201) {
      final User user = User.fromJson(decoded['user']).copyWith(
        token: decoded['token']
      );
      // Guardando la sessión localmente.
      User.setOffline(user);
      return user;
    }

    return Future.error(decoded['message']);
  }
}