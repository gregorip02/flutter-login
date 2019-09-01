export 'package:provider/provider.dart';
import 'package:flutter_jwt_login/models/user.dart';
import 'package:flutter/material.dart' show ChangeNotifier;

class AppState {
  final User user;

  AppState({ this.user });

  AppState copyWith({ User user }) {
    return AppState(
      user: user ?? this.user
    );
  }

  static Future<AppState> initState() async {
    final User user = await User.getOffline();
    return AppState(
      user: user
    );
  }

  bool hasUser() => user.runtimeType == User;
  bool isAuth() => hasUser() ? user.hasToken() : false;
}

abstract class Store {
  void setState(AppState state);
}

class AppStore with ChangeNotifier implements Store {
  AppState state;
  AppStore(this.state);

  @override
  void setState(AppState state) {
    this.state = state;
    notifyListeners();
  }
}