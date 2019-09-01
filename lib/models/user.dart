import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String name;
  final String email;
  final String token;

  User({ this.name = '', this.email = '', this.token = '' });

  factory User.fromJson(Map json) {
    return User(
      name: json['name'],
      email: json['email'],
      token: json['token']
    );
  }

  User copyWith({ String name, String email, String token }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token
    );
  }

  Map toMap() {
    return {
      'name': this.name, 'email': this.email, 'token': this.token
    };
  }

  static void setOffline(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', json.encode(
      user.toMap()
    ));
  }

  static Future<User> getOffline() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('user')) {
      final Map decoded = json.decode(prefs.getString('user'));
      return User.fromJson(decoded);
    }

    return Future.value(null);
  }

  static void dropOffline() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('user')) {
      prefs.remove('user');
    }
  }

  bool hasToken() => this.token.isNotEmpty;

  String toString() {
    final Map userMap = toMap();
    return userMap.toString();
  }
}