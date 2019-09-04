import 'package:flutter/material.dart';
import 'package:flutter_jwt_login/state.dart';
// Screens
import 'package:flutter_jwt_login/views/auth.dart';
import 'package:flutter_jwt_login/views/home.dart';

class AppLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppStore store = Provider.of<AppStore>(context);
    return store.state.isAuth() ? HomeScreen() : AuthScreen();
  }
}
