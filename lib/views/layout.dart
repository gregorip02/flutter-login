import 'package:flutter/material.dart';
import 'package:flutter_jwt_login/state.dart';
// Screens
import 'package:flutter_jwt_login/views/auth.dart';
import 'package:flutter_jwt_login/views/home.dart';

class AppLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppState state = Provider.of<AppStore>(context).state;
    return state.isAuth() ? HomeScreen() : AuthScreen();
  }
}
