import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String name;
  final String email;
  final String token;

  User({ this.name, this.email, this.token });

  factory User.fromJson(Map json) {
    return User(
      name: json['name'],
      email: json['email'],
      token: json['token']
    );
  }

  User copyWith({ String name, String email, String token }) {
    return User(
      name: this.name ?? name,
      email: this.email ?? email,
      token: this.token ?? token
    );
  }

  void setOffline(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', user.toString());
  }

  Future<User> getOffline() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map decoded = json.decode(prefs.getString('user'));
    return User.fromJson(decoded);
  }

  User setToken(String token) => copyWith(token: token);

  bool isAuth() => this.token.isNotEmpty;
}